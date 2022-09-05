import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:task/controllers/auth_controller.dart';
import 'package:task/models/chat_room.dart';
import 'package:task/models/user.dart';

class InboxController extends GetxController {
  final _auth = Get.find<AuthController>();
  final _firestore = FirebaseFirestore.instance;

  Rx<List<ChatRoom>> chatrooms = Rx<List<ChatRoom>>([]);


  MyUser? get currentUser=>_auth.user.value; 


  @override
  void onInit() {
    print('hey');
    chatrooms.bindStream(_firestore
        .collection('chatrooms')
        .where('memberIds', arrayContains: _auth.user.value!.userId)
        .orderBy('lastMessageTime')
        .snapshots()
        .map((event) =>
            event.docs.map((e) => ChatRoom.fromMap(e.data())).toList()));
    
    super.onInit();
  }
}
