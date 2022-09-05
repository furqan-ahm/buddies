import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:task/controllers/auth_controller.dart';
import 'package:task/screens/user/user_panel.dart';

import 'auth/login.dart';

class Splash extends GetView<AuthController> {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(
        Duration(milliseconds: 200),
        ()=>controller.startUp()
      );
    });
    return const Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}