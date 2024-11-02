import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

class MyUser extends Equatable{

  final String uid;
  final String email;
  final String name;

  const MyUser({required this.uid, required this.email, required this.name});

  static const MyUser empty = MyUser(uid: "", email: "", name: "");

  MyUser copyWith({
    String? uid,
    String? email,
    String? name
  }){
    return MyUser(uid: uid ?? this.uid, email: email ?? this.email, name: name ?? this.name);
  }



  bool get isEmpty => this == MyUser.empty;

  bool get isNotEmpty => this != MyUser.empty;

  MyUserEntity toEntity(){
    return MyUserEntity(uid: uid, email: email, name: name);
  }

 static MyUser fromEntity(MyUserEntity entity){
    return MyUser(uid: entity.uid, email: entity.email, name: entity.name);
  }

  @override
  List<Object?> get props => [uid, email, name];


}