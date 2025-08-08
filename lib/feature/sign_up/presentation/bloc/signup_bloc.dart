import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalgamers/feature/sign_up/data/repository/auth_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final authRepository = AuthRepository();
  SignupBloc() : super(SignupInitial()) {
    on<SignUp>((event, emit) async {
      try {
        final success =
            await authRepository.signInWithEmail(event.email, event.password);

        if (success) {
          emit(SignupSuccess());
        }
      } catch (e) {
        emit(SignupFailure(e.toString().replaceFirst('Exception: ', '')));
      }
    });
  }
}
