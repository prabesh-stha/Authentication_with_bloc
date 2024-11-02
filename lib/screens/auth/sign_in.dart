import 'package:authentication_with_bloc/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool obscureText = true;
  bool signInRequest = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(listener: (context, state){
      if(state is SignInSuccess){
        setState(() {
          signInRequest = false;
        });
      }else if(state is SignInProcess){
        setState(() {
          signInRequest = true;
        });
      }else if(state is SignInFailure){
        setState(() {
          signInRequest = false;
        });
      }
    },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 20,),

            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Email",
                prefixIcon: const Icon(CupertinoIcons.mail),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25)
                )
              ),
            ),

            const SizedBox(height: 20,),

            TextFormField(
              controller: _passwordController,
              obscureText: obscureText,
              decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: const Icon(CupertinoIcons.lock),
                suffixIcon: IconButton(onPressed: (){
                  setState(() {
                    obscureText = !obscureText;
                  });
                }, icon: obscureText ? const Icon(CupertinoIcons.eye) : const Icon(CupertinoIcons.eye_slash)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25)
                )
              ),
            ),

            const SizedBox(height: 20,),
            !signInRequest?
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
                )
              ),
              onPressed: (){
              context.read<SignInBloc>().add(SignInRequest(_emailController.text, _passwordController.text));
            }, child: const Text("Sign in")),
            )
            :
            const CircularProgressIndicator()
          ],
        )
        ),
    );
  }
}