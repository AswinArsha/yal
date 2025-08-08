part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

final class SignUp extends SignupEvent {
  final String email;
  final String password;

  SignUp({required this.email, required this.password});
}
