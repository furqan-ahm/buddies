import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/controllers/auth_controller.dart';
import 'package:task/screens/user/user_panel.dart';

class LoginController extends GetxController{

  final authController = Get.find<AuthController>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool passwordVisible = false.obs;
  RxBool loading = false.obs;


  final formKey = GlobalKey<FormState>();


  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }


  login()async{
    if(formKey.currentState!.validate()){
      loading.value = true;
      final result = await authController.login(emailController.text, passwordController.text);
      loading.value = false;

      if(result){
        Get.off(UserPanel());
      }
    }
  }

  void switchVisibility() {
    passwordVisible.value=!passwordVisible.value;
  }


}