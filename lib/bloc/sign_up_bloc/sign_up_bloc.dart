import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;
  SignUpBloc({required UserRepository userRepository}) : _userRepository = userRepository, super(SignUpInitial()) {
    on<SignUpRequest>((event, emit) async{
      emit(SignUpProcess());
      try{
        MyUser user = await _userRepository.signUp(event.user, event.password);
        await _userRepository.setUserData(user);
        emit(SignUpSuccess());
      }catch(e){
        log(e.toString());
        emit(SignUpFailure());
      }
    });
  }
}
