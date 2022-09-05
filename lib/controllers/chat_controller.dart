import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task/controllers/auth_controller.dart';
import 'package:task/models/chat_room.dart';
import 'package:task/models/message.dart';

import '../models/user.dart';

class ChatController extends GetxController {
  ChatRoom room;

  MyUser buddy;

  ChatController({required this.room, required this.buddy});

  final _firestore = FirebaseFirestore.instance;
  final _authCon = Get.find<AuthController>();

  Rx<List<Message>> messages = Rx<List<Message>>([]);

  TextEditingController messageController=TextEditingController();


  MyUser get currentUser=> _authCon.user.value!;
  

  @override
  void onInit() {
    messages.bindStream(_firestore
        .collection('chatrooms')
        .doc(room.chatRoomId)
        .collection('messages')
        .orderBy('time')
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Message.fromMapWithRef(e.data(),e.reference)).toList().reversed.toList()));

    super.onInit();
  }

  markRead(DocumentReference messageRef){
    messageRef.update({'unread':false});
  }

  void sendMessage() {
    if(messageController.text.isNotEmpty){
      _firestore.collection('chatrooms').doc(room.chatRoomId).collection('messages').add(
        {
          'text':messageController.text,
          'sender':currentUser.toMap(),
          'receiver': buddy.toMap(),
          'time': Timestamp.now(),
          'unread':true
        }
      );
      _firestore.collection('chatrooms').doc(room.chatRoomId).update(
        {
          'lastMessageTime':Timestamp.now(),
          'lastMessage':  {
            'text':messageController.text,
            'sender':currentUser.toMap(),
            'receiver': buddy.toMap(),
            'time': Timestamp.now(),
            'unread':true
          }
        }
      );
      messageController.clear();
    }
  }
}
