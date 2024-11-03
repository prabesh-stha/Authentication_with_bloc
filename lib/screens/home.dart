import 'package:authentication_with_bloc/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: TextButton(onPressed: (){
        context.read<SignInBloc>().add(SignOutRequest());
      }, child: const Text("Sign Out"))
    );
  }
}