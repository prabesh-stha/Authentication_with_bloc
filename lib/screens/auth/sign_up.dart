import 'package:authentication_with_bloc/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:authentication_with_bloc/screens/validation/validation_string.dart';
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
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  bool signInRequest = false;
  bool obscureText = true;
  String? errMsg;
  String? signUpError;

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
        setState(() {
          signUpError = "Error while signing up";
        });
        return;
      }
    },
      child: Form(
        key: _formKey,
        child: Column(
          children: [

            if(signUpError != null)
              Center(child: Text(signUpError!, style: const TextStyle(color: Colors.red),),),
            
            const SizedBox(height: 20,),

            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if(value!.isEmpty){
                  return "Please enter email";
                }else if(!emailRegex.hasMatch(value)){
                  return "Please enter valid email";
                }else{
                  return null;
                }
              },
              decoration: InputDecoration(
                errorText: errMsg,
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
              validator: (value) {
                if(value!.isEmpty){
                  return "Please enter password";
                }else if(!passwordRegex.hasMatch(value)){
                  return "Password must be 8 character of number, special character, capital and small letter";
                }else{
                  return null;
                }
              },
              decoration: InputDecoration(
                errorMaxLines: 2,
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

            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              validator: (value) {
                if(value!.isEmpty){
                  return "Please enter name";
                }else if(value.length > 30){
                  return "Name too long";
                }else{
                  return null;
                }
              },
              decoration: InputDecoration(
                errorText: errMsg,
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
                setState(() {
                  errMsg = null;
                  signUpError = null;
                });
              if(_formKey.currentState!.validate()){
                MyUser user = MyUser.empty;
              user = user.copyWith(email: _emailController.text, name: _nameController.text);
              setState(() {
                context.read<SignUpBloc>().add(SignUpRequest(user, _passwordController.text));
              });
              }
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