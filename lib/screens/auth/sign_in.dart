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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool obscureText = true;
  bool signInRequest = false;
  String? errMsg;
  String? signInError;

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
          signInError = "Invalid credential";
        });
      }
    },
      child: Form(
        key: _formKey,
        child: Column(
          children: [

            if(signInError != null)
              Center(child: Text(signInError!, style: const TextStyle(color: Colors.red),),),
            const SizedBox(height: 20,),

            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if(value!.isEmpty){
                  return "Please enter email.";
                }else{
                  return null;
                }
              },
              decoration: InputDecoration(
                hintText: "Email",
                prefixIcon: const Icon(CupertinoIcons.mail),
                errorText: errMsg,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25)
                )
              ),
            ),

            const SizedBox(height: 20,),

            TextFormField(
              controller: _passwordController,
              obscureText: obscureText,
              validator: (value) {
                if(value!.isEmpty){
                  return "Please enter password";
                }else{
                  return null;
                }
              },
              decoration: InputDecoration(
                errorText: errMsg,
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
                setState(() {
                  signInError = null;
                  errMsg = null;
                });
                if(_formKey.currentState!.validate()){
                   context.read<SignInBloc>().add(SignInRequest(_emailController.text, _passwordController.text));
                }
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