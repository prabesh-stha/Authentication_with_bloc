part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInRequest extends SignInEvent{
  final String email;
  final String password;

  const SignInRequest(this.email, this.password);
}