abstract class GoogleSignInState {}

class GoogleSignInInitial extends GoogleSignInState {}

class GoogleSignInLoading extends GoogleSignInState {}

class GoogleSignInSuccess extends GoogleSignInState {}

class GoogleSignInFailure extends GoogleSignInState {
  final String message;
  GoogleSignInFailure(this.message);
}

class LogoutLoading extends GoogleSignInState {}

class LogoutSuccess extends GoogleSignInState {}

class LogoutFailure extends GoogleSignInState {
  final String message;
  LogoutFailure(this.message);
}
