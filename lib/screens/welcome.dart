import 'package:authentication_with_bloc/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:authentication_with_bloc/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:authentication_with_bloc/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:authentication_with_bloc/screens/auth/sign_in.dart';
import 'package:authentication_with_bloc/screens/auth/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  bool isSignUp = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Text("Welcome back!", style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
                ),
                const SizedBox(height: kToolbarHeight,),
                if(isSignUp)
                  BlocProvider(create: (context) => SignUpBloc(userRepository: context.read<AuthenticationBloc>().userRepository),
                  child: const SignUp(),),

                if(!isSignUp)
                BlocProvider(create: (context) => SignInBloc(userRepository: context.read<AuthenticationBloc>().userRepository),
                      child: const SignIn(),
                    ),
              
              Center(child: TextButton(onPressed: (){
                setState(() {
                  isSignUp = !isSignUp;
                });
              }, child: Text(isSignUp ? "Already have an account?" : "Create a new account?")),)
              ],
            ),
          )
        ),
      ),
    );
  }
}