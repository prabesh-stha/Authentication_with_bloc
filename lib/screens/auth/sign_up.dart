import 'package:authentication_with_bloc/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  bool signInRequest = false;
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(listener: (context, state){
      if(state is SignUpSuccess){
        setState(() {
          signInRequest = false;
        });
      }else if(state is SignUpProcess){
        setState(() {
           signInRequest = true;
        });
      }else if (state is SignUpFailure){
        return;
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

            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: "Name",
                prefixIcon: const Icon(CupertinoIcons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25)
                )
              ),
            ),

            const SizedBox(height: 20,),

            !signInRequest ?
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue
              ),
              onPressed: (){
              MyUser user = MyUser.empty;
              user = user.copyWith(email: _emailController.text, name: _nameController.text);
              setState(() {
                context.read<SignUpBloc>().add(SignUpRequest(user, _passwordController.text));
              });
            }, child: const Text("Sign up"))
            )
            :
            const CircularProgressIndicator()
            ]
            )
        ),
      );
  }
}