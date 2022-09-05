import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task/controllers/auth_controller.dart';
import 'package:task/models/user.dart';

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


  createChatRoom(){
    
  }

  @override
  void onInit() {
    getUsersStream();
    super.onInit();
  }


}
