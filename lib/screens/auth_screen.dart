import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';

enum AuthState {
  Login,
  SignUp,
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthState _authState = AuthState.SignUp;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _form = GlobalKey<FormState>();

  final Map<String, String> _commonErr = {
    'EMAIL_EXISTS': 'The email address is already in use by another account.',
    'OPERATION_NOT_ALLOWED': 'Password sign-in is disabled for this project.',
    'TOO_MANY_ATTEMPTS_TRY_LATER':
        'We have blocked all requests from this device due to unusual activity. Try again later.',
    'EMAIL_NOT_FOUND':
        'There is no user record corresponding to this identifier. The user may have been deleted.',
    'INVALID_PASSWORD':
        'The password is invalid or the user does not have a password',
    'USER_DISABLED': 'The user account has been disabled by an administrator',
    'INVALID_EMAIL': 'This is not a valid email address',
  };

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _confirmPasswordController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showErrorDialog(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              print('press');
              Navigator.of(ctx).pop();
            },
            child: const Text('Okey'),
          ),
        ],
      ),
    );
  }

  void _onSubmit(BuildContext context) async {
    if (_form.currentState == null) {
      return;
    }
    final _isValidate = _form.currentState!.validate();
    if (!_isValidate) {
      return;
    }
    _form.currentState!.save;
    try {
      if (_authState == AuthState.SignUp) {
        await Provider.of<Auth>(context, listen: false)
            .signUp(_emailController.text, _passwordController.text);
        setState(() {
          _authState = AuthState.Login;
        });
      } else {
        print('login...');
        await Provider.of<Auth>(context, listen: false)
            .login(_emailController.text, _passwordController.text);
      }
    } on HttpException catch (e) {
      print('catch1');
      var errorMessage = 'Authentication failed';
      final String errCatchStr = e.toString();
      _commonErr.forEach((key, value) {
        if (errCatchStr.contains(key)) {
          errorMessage = value;
        }
      });
      _showErrorDialog(errorMessage, context);
    } catch (e) {
      print('err');
      var errorMessage = 'Authentication failed';
      _showErrorDialog(errorMessage, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Center(
          child: Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Email'),
                  ),
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email!';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Password'),
                  ),
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password!';
                    }
                    if (value.length < 8) {
                      return 'The password must be longer than 8 character!';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
                if (_authState == AuthState.SignUp)
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Confirm Password'),
                    ),
                    controller: _confirmPasswordController,
                    validator: (value) {
                      if (_passwordController.text !=
                          _confirmPasswordController.text) {
                        return 'Password is not match!';
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () => _onSubmit(context),
                  child:
                      Text(_authState == AuthState.Login ? 'Login' : 'Sign Up'),
                ),
                TextButton(
                  onPressed: () => setState(() {
                    _authState = _authState == AuthState.Login
                        ? AuthState.SignUp
                        : AuthState.Login;
                  }),
                  child: Text(_authState == AuthState.Login
                      ? 'Go to sign up'
                      : 'Back to login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
