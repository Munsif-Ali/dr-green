abstract class AuthenticationException {
  final String _msg = "Something Went Wrong";
  String get getMessage => _msg;
}

class UserNotFoundAuthException implements Exception, AuthenticationException {
  @override
  final String _msg = "User Not Found";
  @override
  String get getMessage => _msg;
}

class WrongPasswordAuthException implements Exception, AuthenticationException {
  @override
  final String _msg = "Please Enter correct password";
  @override
  String get getMessage => _msg;
}

class EmailAlreadyInUseAuthException
    implements Exception, AuthenticationException {
  @override
  final String _msg = "The input email is already used by another account";
  @override
  String get getMessage => _msg;
}

class UserNotLoggedInAuthException
    implements Exception, AuthenticationException {
  @override
  final String _msg = "User is not Logged In";
  @override
  String get getMessage => _msg;
}

class InvalidEmailAuthException implements Exception, AuthenticationException {
  @override
  final String _msg = "Please Enter Valid Email";
  @override
  String get getMessage => _msg;
}

class GenericAuthException implements Exception, AuthenticationException {
  @override
  final String _msg = "Something Went Wrong";
  @override
  String get getMessage => _msg;
}

class WeakPasswordAuthException implements Exception, AuthenticationException {
  @override
  final String _msg = "Please Enter Strong Password";
  @override
  String get getMessage => _msg;
}
