import 'package:cloud_firestore/cloud_firestore.dart';

import 'user.dart';

class Message{
  final DocumentReference? ref;
  final MyUser? sender;
  final MyUser? reciever;
  final String? imgUrl;
  final String? text;
  final bool? unread;
  final DateTime? time;

  Message({required this.sender,required this.reciever, required this.text, required this.unread, required this.time, this.imgUrl, this.ref});

  static Message fromMapWithRef(Map<String,dynamic> mapData, DocumentReference? ref)=>
      Message(
          sender: MyUser.fromMap(mapData['sender']),
          reciever: MyUser.fromMap(mapData['receiver']),
          text: mapData['text'],
          imgUrl: mapData['imgUrl'],
          unread: mapData['unread'],
          time: (mapData['time'] as Timestamp).toDate(),
          ref: ref
      );

  static Message fromMap(Map<String,dynamic> mapData)=>
      Message(
          sender: MyUser.fromMap(mapData['sender']),
          reciever: MyUser.fromMap(mapData['receiver']),
          text: mapData['text'],
          imgUrl: mapData['imgUrl'],
          unread: mapData['unread'],
          time: (mapData['time'] as Timestamp).toDate(),
      );

  

  toMap(){
    return {
      'sender':sender!.toMap(),
      'receiver':reciever!.toMap(),
      'senderId':sender!.userId,
      'text':text,
      'imgUrl':imgUrl,
      'unread':unread,
      'time':time?.toUtc()
    };
  }
}