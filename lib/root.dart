import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:task/controllers/auth_controller.dart';
import 'package:task/screens/user/user_panel.dart';
import 'package:task/screens/auth/login.dart';

class Root extends GetView<AuthController>{
  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=>controller.user.value!=null?const UserPanel():const Login()
      );
  }

}