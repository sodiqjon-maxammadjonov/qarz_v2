import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:qarz_v2/src/app/data/service/auth/login_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEnteringEvent>(loginEntering);
  }

  FutureOr<void> loginEntering (
      LoginEnteringEvent event,
      Emitter<LoginState> emit,
      ) async {
    await AuthService(emit: emit).signIn(event.username, event.password);
  }
}
