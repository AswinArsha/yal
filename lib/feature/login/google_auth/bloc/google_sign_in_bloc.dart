import 'package:bloc/bloc.dart';
import 'package:yalgamers/feature/login/google_auth/bloc/google_sign_in_event.dart';
import 'package:yalgamers/feature/login/google_auth/bloc/google_sign_in_state.dart';

import '../data/auth_repository_impl.dart';

class GoogleSignInBloc extends Bloc<GoogleSignInEvent, GoogleSignInState> {
  final AuthRepositoryImpl authrepo;
  GoogleSignInBloc({
    required this.authrepo,
  }) : super(GoogleSignInInitial()) {
    on<StartGoogleSignIn>((event, emit) async {
      emit(GoogleSignInLoading());
      try {
        await authrepo.signInWithGoogle();
        emit(GoogleSignInSuccess());
      } catch (e) {
        emit(GoogleSignInFailure(e.toString().replaceAll("Exception: ", "")));
      }
    });

    on<StartLogout>((event, emit) async {
      emit(LogoutLoading());
      try {
        await authrepo.logout();
        emit(LogoutSuccess());
      } catch (e) {
        emit(LogoutFailure(e.toString().replaceAll("Exception: ", "")));
      }
    });
  }
}
