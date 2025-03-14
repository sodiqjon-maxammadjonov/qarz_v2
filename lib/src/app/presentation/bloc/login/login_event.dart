part of 'login_bloc.dart';

@immutable
sealed class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class LoginEnteringEvent extends LoginEvent {
  final String username;
  final String password;

  LoginEnteringEvent({required this.username, required this.password});

  @override
  List<Object?> get props => [username, password];
}