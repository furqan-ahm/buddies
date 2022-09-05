import 'package:firebase_auth/firebase_auth.dart';

class MyUser{

  String userId;
  String? displayName;
  String? photoUrl;

  MyUser({required this.userId, this.displayName, this.photoUrl});

  static MyUser fromUser(User user){
    return MyUser(userId: user.uid, displayName: user.displayName, photoUrl: user.photoURL);
  }

  static MyUser fromMap(Map userData){
    return MyUser(userId: userData['uid'],displayName: userData['displayName'], photoUrl: userData['photoUrl']);
  }


  Map<String,dynamic> toMap(){
    return {
      'uid':userId,
      'displayName':displayName,
      'photoUrl':photoUrl
    };
  }

  bool equals(MyUser user)=>user.userId==userId;

  @override
  String toString() {
    return userId;
  }
}