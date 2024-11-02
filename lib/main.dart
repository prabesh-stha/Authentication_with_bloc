import 'package:authentication_with_bloc/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:authentication_with_bloc/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:authentication_with_bloc/screens/home.dart';
import 'package:authentication_with_bloc/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MyApp(FirebaseUserRepository()));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp(this.userRepository, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: 
       [
         RepositoryProvider<AuthenticationBloc>(create: (_) => AuthenticationBloc(myUserRepository: userRepository))
        ],
      
       child: const MyAppView());
  }
}

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Authentication",
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(builder: (context, state){
        if(state.status == AuthenticationStatus.authenticated){
          return BlocProvider(create: (context) => SignInBloc(userRepository: context.read<AuthenticationBloc>().userRepository),
                      child: const Home(),
                    );
        }else{
          return const Welcome();
        }
      }),
    );
  }
}