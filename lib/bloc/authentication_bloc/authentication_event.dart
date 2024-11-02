part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationChanged extends AuthenticationEvent{
  final User? user;

   const AuthenticationChanged(this.user);
}
