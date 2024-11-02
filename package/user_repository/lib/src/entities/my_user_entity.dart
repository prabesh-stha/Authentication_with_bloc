import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable{
  final String uid;
  final String email;
  final String name;

  const MyUserEntity({required this.uid, required this.email, required this.name});

  Map<String, Object?> toDocument(){
    return {
      "uid" : uid,
      "email": email,
      "name": name
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc){
    return MyUserEntity(uid: doc["uid"] as String, email: doc["email"] as String, name: doc["name"] as String);
  }
  
  @override
  List<Object?> get props => [uid, email, name];
}