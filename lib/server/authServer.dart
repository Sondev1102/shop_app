class AuthServer {
  static const String _apiKey = 'AIzaSyCbJfy6Z-OHundQyj95gbV2pRq2QxYSeTM';
  static const String _baseSignUpUrl =
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_apiKey';
  static const String _baseLoginUrl =
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_apiKey';

  String get signUpUrl {
    return _baseSignUpUrl;
  }

  String get loginUrl {
    return _baseLoginUrl;
  }
}
