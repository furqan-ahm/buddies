import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/controllers/inbox_controller.dart';
import 'package:task/models/message.dart';
import 'package:task/models/user.dart';
import 'package:task/screens/user/chat.dart';

class Inbox extends GetWidget<InboxController> {
  const Inbox({Key? key}) : super(key: key);


  @override
  InboxController get controller => Get.put(InboxController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Size.infinite.width,
      height: Size.infinite.height,
      color: Colors.teal,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
            alignment: Alignment.center,
            width: Size.infinite.width,
            child: Text('Inbox', style: TextStyle(color: Colors.teal,fontWeight: FontWeight.bold,fontSize: 18),),
          ),
          Expanded(
            child: Obx(() {
                return ListView.builder(
                  itemCount: controller.chatrooms.value.length,
                  itemBuilder: (context, index){

                    final chatRoom = controller.chatrooms.value[index];

                    Message? lastMessage=controller.chatrooms.value[index].lastMessage!;

                    bool isSentByMe=lastMessage.sender!.userId==controller.currentUser!.userId;
                    MyUser buddy=isSentByMe?lastMessage.reciever!:lastMessage.sender!;
                    return GestureDetector(
                      onTap: (){
                        Get.to(Chat(chatRoom: chatRoom, buddy: buddy));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 0,
                        ),
                        child: Column(
                          children: [
                            (index == 0)
                                ? SizedBox(
                              height: 24,
                            )
                                : SizedBox.shrink(),
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: (lastMessage!=null?lastMessage.unread!&&!isSentByMe:false)
                                      ? BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                    border: Border.all(
                                      width: 2,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    // shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                      ),
                                    ],
                                  )
                                      : BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: CircleAvatar(
                                    radius: 35,
                                    foregroundImage:
                                    //AssetImage(targetUser.profileImage),
                                    buddy.photoUrl==null?null:Image.network(buddy.photoUrl!).image,
                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      left: 20,
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  buddy.displayName!,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                lastMessage.unread!&&!isSentByMe?Container(
                                                  margin: const EdgeInsets.only(left: 5),
                                                  width: 7,
                                                  height: 7,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Theme.of(context).primaryColor,
                                                  ),
                                                ):Container()
                                              ],
                                            ),
                                            Text(
                                              lastMessage!=null?
                                              lastMessage.time!.hour.toString()+':'+lastMessage.time!.minute.toString():'00:00',
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            (lastMessage!=null?lastMessage.text!:''),
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black54,
                                              fontWeight: lastMessage.unread!&&!isSentByMe?FontWeight.w800:FontWeight.normal
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 0.5,
                              color: Theme.of(context).primaryColor,
                              height: 24,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            ),
          )
        ],
      ),
    );
  }
}