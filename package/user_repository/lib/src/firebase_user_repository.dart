import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/src/models/my_user.dart';
import 'package:user_repository/src/user_repo.dart';
import 'package:user_repository/user_repository.dart';

class FirebaseUserRepository implements UserRepository{
FirebaseAuth _firebaseAuth;

FirebaseUserRepository(FirebaseAuth? firebaseAuth) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

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
  Future<void> setUserData(MyUser user) {
    // TODO: implement setUserData
    throw UnimplementedError();
  }

  @override
  Future<void> signIn(String email, String password) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<MyUser> signUp(MyUser user, String password) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  // TODO: implement user
  Stream<User?> get user => throw UnimplementedError();

}