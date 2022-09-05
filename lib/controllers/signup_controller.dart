import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/controllers/auth_controller.dart';
import 'package:task/screens/user/user_panel.dart';

class SignUpController extends GetxController{

  final authController = Get.find<AuthController>();

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  RxBool loading = false.obs;
  
  RxBool passwordVisible = false.obs;

  final formKey = GlobalKey<FormState>();


  signup()async{
    if(formKey.currentState!.validate()){
      loading.value=true;
      final result = await authController.createUser(nameController.text, emailController.text, passwordController.text);
      if(result){
        Get.offAll(UserPanel());
      }
      loading.value=false;
    }
  }

  void switchVisibility() {
    passwordVisible.value=!passwordVisible.value;
  }


  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

}