import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart';

class FirebaseUserRepository implements UserRepository{
final FirebaseAuth _firebaseAuth;

FirebaseUserRepository({FirebaseAuth? firebaseAuth}) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

final userCollection = FirebaseFirestore.instance.collection("users");

  @override
  Future<MyUser> getUserData(String uid) async{
    try{
      return await userCollection.doc(uid).get().then((doc){
        return MyUser.fromEntity(MyUserEntity.fromDocument(doc.data()!));
      });
    }catch(e){
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> setUserData(MyUser user)async{
    try{
      await userCollection.doc(user.uid).set(user.toEntity().toDocument());
    }catch(e){
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> signIn(String email, String password)async {
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    }catch(e){
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> signOut() async{
    try{
     await _firebaseAuth.signOut();
    }catch(e){
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> signUp(MyUser user, String password)async {
    try{
      UserCredential credentical = await _firebaseAuth.createUserWithEmailAndPassword(email: user.email, password: password);
      user = user.copyWith(uid: credentical.user!.uid);
      return user;
    }catch(e){
      log(e.toString());
      rethrow;
    }
  }

  @override
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser){
      return firebaseUser;
    });
  }

}