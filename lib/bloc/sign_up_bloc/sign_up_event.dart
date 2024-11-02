part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class SignUpRequest extends SignUpEvent{
  final MyUser user;
  final String password;

  const SignUpRequest(this.user, this.password);
}
