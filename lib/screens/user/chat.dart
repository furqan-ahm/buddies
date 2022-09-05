import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/constants/theme.dart';
import 'package:task/controllers/chat_controller.dart';
import 'package:task/models/chat_room.dart';
import 'package:task/models/user.dart';

class Chat extends GetView<ChatController> {
  const Chat({Key? key, required this.chatRoom, required this.buddy})
      : super(key: key);

  final ChatRoom chatRoom;
  final MyUser buddy;

  @override
  ChatController get controller => Get.put(ChatController(room: chatRoom,buddy: buddy));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          buddy.displayName!,
          style: TextStyle(color: Colors.teal),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                  return ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: controller.messages.value.length,
                    itemBuilder: (context, index) {
                      final message = controller.messages.value[index];
                      final isSendbyMe = message.sender!.equals(controller.currentUser);

                      if(message.unread!&&!isSendbyMe){
                        controller.markRead(message.ref!);
                      }

                      return Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            margin: EdgeInsets.only(bottom: 8),
                            alignment: isSendbyMe?Alignment.centerRight:Alignment.centerLeft,
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(isSendbyMe?20:0),
                                    bottomRight: Radius.circular(isSendbyMe?0:20),
                                  ),
                                  color: isSendbyMe?Theme.of(context).primaryColor.withOpacity(0.75):Colors.blueGrey,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(message.text!,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 16),),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(message.time!.hour.toString()+':'+message.time!.minute.toString(),style: TextStyle(color: Colors.black),),
                                        SizedBox(width: 5,),
                                        isSendbyMe?Icon(message.unread!?Icons.check_circle_outline:Icons.check_circle,size: 18,):Container()
                                      ],
                                    )
                                  ],
                                )
                            )
                        );
                    },
                  );
                }
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.messageController,
                      decoration: messageFieldDecoration,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        controller.sendMessage();
                      },
                      icon: Icon(Icons.send))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
