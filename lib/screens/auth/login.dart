import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/constants/theme.dart';
import 'package:task/screens/auth/signup.dart';

import 'package:task/controllers/login_controller.dart';

class Login extends GetView<LoginController> {
  const Login({Key? key}) : super(key: key);

  @override
  LoginController get controller => Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(29))),
                child: const Text('buddies',
                    style: TextStyle(
                        color: Colors.teal,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                controller: controller.emailController,
                validator: (val) => val == null || val.isEmpty
                    ? 'Field can not be empty'
                    : null,
                decoration: authFieldsDecoration.copyWith(labelText: 'Email'),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() {
                print(controller.passwordVisible);
                return TextFormField(
                  controller: controller.passwordController,
                  style: TextStyle(color: Colors.white),
                  validator: (val) => val == null || val.isEmpty
                      ? 'Field can not be empty'
                      : null,
                  decoration: authFieldsDecoration
                      .copyWith(labelText: 'Password')
                      .copyWith(
                          suffixIcon: GestureDetector(
                        child: Icon(
                          controller.passwordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onTap: () {
                          controller.switchVisibility();
                        },
                      )),
                  obscureText: !controller.passwordVisible.value,
                );
              }),
              const SizedBox(
                height: 20,
              ),
              Obx(() {
                    return TextButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                            foregroundColor: MaterialStateProperty.all(Colors.teal),
                            backgroundColor: MaterialStateProperty.all(Colors.white)),
                        onPressed: controller.loading.value?null:() {
                          controller.login();
                        },
                        child: Container(
                              alignment: Alignment.center,
                              width: Size.infinite.width,
                              height: 40,
                              child: controller.loading.value?const CircularProgressIndicator(color: Colors.teal, strokeWidth: 2,):const Text('Login', style: TextStyle(fontSize: 18),),
                            )
                    );
                  }
                ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(const SignUp());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Sign Up!',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
