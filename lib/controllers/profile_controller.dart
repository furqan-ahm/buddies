import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task/controllers/auth_controller.dart';
import 'package:task/root.dart';

import '../models/user.dart';

class ProfileController extends GetxController{

  final AuthController _authController = Get.find<AuthController>();
  final storage = FirebaseStorage.instance;


  late Rx<MyUser> currentUser;

  @override
  void onInit() {

    FirebaseAuth.instance.userChanges().listen(_userListener);

    currentUser=_authController.user.value!.obs;
    super.onInit();
  }


  void _userListener(User? user){
    if(user!=null)currentUser.value=MyUser.fromUser(user);
  }

  setPhoto() async{
    final result = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(result!=null) {
      
      await storage.ref(currentUser.value.userId).child('profile.${result.path.split('.').last}').putFile(File(result.path));
      final url =await storage.ref(currentUser.value.userId).child('profile.${result.path.split('.').last}').getDownloadURL();

      FirebaseAuth.instance.currentUser?.updatePhotoURL(url);
      FirebaseFirestore.instance.collection('users').doc(currentUser.value.userId).update({'photoUrl':url});
    } 
  }

  signOut(){
    _authController.signOut();
    Get.off(Root());
  }



}