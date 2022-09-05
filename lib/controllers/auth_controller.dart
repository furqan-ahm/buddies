import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/screens/auth/login.dart';
import 'package:task/screens/user/user_panel.dart';

import '../models/user.dart';

class AuthController extends GetxController {
  Rx<MyUser?> user = Rx<MyUser?>(null);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  @override
  void onInit() {
    user.bindStream(FirebaseAuth.instance
        .authStateChanges()
        .map((event) => event == null ? null : MyUser.fromUser(event)));
    
    super.onInit();
  }


  startUp() {
    if(_auth.currentUser==null){
      Get.to(Login());
    }
    else{
      Get.to(UserPanel());
    }
  }

  //SignUp method
  Future<bool> createUser(String name, String email, String password) async{
    try{
      final userCred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await userCred.user?.updateDisplayName(name);
        if(userCred.user!=null) {
          await _firestore.collection('users').doc(userCred.user!.uid).set(
          {
            'uid':userCred.user?.uid,
            'displayName':name,
            'photoUrl':null
          }
        );
      }
      
      return true;
    } catch (e) {
      if (e is FirebaseAuthException) {
        Get.snackbar('Error', e.message.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5));
        return false;
      }
    }
    return false;
  }


  //Signout method
  signOut(){
    try {
      _auth.signOut();
    } catch (e) {
      if (e is FirebaseAuthException) {
        Get.snackbar('Error', e.message.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5));
      }
    }
  }


  //Login Method
  Future<bool> login(String email, String password) async {
    try {
      final userCred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
          return true;
    } catch (e) {
      if (e is FirebaseAuthException) {
        Get.snackbar('Error', e.message.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5));
        return false;
      }
    }
    return false;
  }

}
