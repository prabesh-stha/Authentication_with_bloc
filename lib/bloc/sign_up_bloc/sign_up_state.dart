part of 'sign_up_bloc.dart';


@immutable
abstract class SignUpState extends Equatable {
  const SignUpState();
  
  @override
  List<Object?> get props => [];
}

class SignUpInitial extends SignUpState {}
class SignUpProcess extends SignUpState{}
class SignUpSuccess extends SignUpState{}
class SignUpFailure extends SignUpState{}
