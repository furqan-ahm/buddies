import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task/controllers/auth_controller.dart';
import 'package:task/models/chat_room.dart';
import 'package:task/models/user.dart';
import 'package:task/screens/user/chat.dart';

class SearchController extends GetxController {
  final _authCon = Get.find<AuthController>();
  final _firestore = FirebaseFirestore.instance;

  Rx<List<MyUser>> users=Rx<List<MyUser>>([]);

  TextEditingController name = TextEditingController();

  getUsersStream() {
    users.bindStream(
      _firestore
        .collection('users')
        .where('uid', isNotEqualTo: _authCon.user.value!.userId)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => MyUser.fromMap(e.data())).toList()));
  }


  createChatRoom(MyUser otherUser)async{
    int compare=_authCon.user.value!.userId.compareTo(otherUser.userId);

    String id;
    List<String> memberIds;

    if(compare>0){
      memberIds=[_authCon.user.value!.userId,otherUser.userId];
      id=_authCon.user.value!.userId+otherUser.userId;
      
    }
    else{
      id=otherUser.userId+_authCon.user.value!.userId;
      memberIds=[otherUser.userId,_authCon.user.value!.userId];
    }

    await _firestore.collection('chatrooms').doc(id).set(
        {
          'chatroomId':id,
          'memberIds':memberIds
        },
        SetOptions(merge: true)
      );
    Get.to(Chat(chatRoom: ChatRoom(chatRoomId: id, memberIds: memberIds),buddy: otherUser,));
  }

  @override
  void onInit() {
    getUsersStream();
    super.onInit();
  }


}
