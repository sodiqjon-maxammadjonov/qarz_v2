part of 'login_bloc.dart';

@immutable
sealed class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoadingState extends LoginState {}

final class LoginSuccessState extends LoginState {
  final String message;
  LoginSuccessState({required this.message});

  @override
  List<Object?> get props => [message];
}

final class LoginErrorState extends LoginState {
  final String message;

  LoginErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
