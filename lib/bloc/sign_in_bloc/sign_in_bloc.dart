import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository _userRepository;
  SignInBloc(UserRepository userRepository) : _userRepository = userRepository, super(SignInInitial()) {
    on<SignInRequest>((event, emit) async{
      emit(SignInProcess());
      try{
        await _userRepository.signIn(event.email, event.password);
        emit(SignInSuccess());
      }catch(e){
        log(e.toString());
        emit(SignInFailure(e.toString()));
      }
    });
  }
}
