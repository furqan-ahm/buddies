import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/constants/theme.dart';
import 'package:task/controllers/signup_controller.dart';

class SignUp extends GetView<SignUpController> {
  const SignUp({Key? key}) : super(key: key);

  
  @override
  SignUpController get controller => Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                  cursorColor: Colors.teal,
                  style: const TextStyle(color: Colors.white),
                  controller: controller.nameController,
                  decoration: authFieldsDecoration.copyWith(labelText: 'Name'),
                   validator: (val) => val == null || val.isEmpty
                      ? 'Field can not be empty'
                      : null,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  cursorColor: Colors.teal,
                  style: const TextStyle(color: Colors.white),
                  controller: controller.emailController,
                  decoration: authFieldsDecoration.copyWith(labelText: 'Email'),
                   validator: (val) => val == null || val.isEmpty
                      ? 'Field can not be empty'
                      : null,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  cursorColor: Colors.teal,
                  style: const TextStyle(color: Colors.white),
                  controller: controller.passwordController,
                  decoration: authFieldsDecoration.copyWith(labelText: 'Password').copyWith(
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
                  validator: (val) => val == null || val.isEmpty
                      ? 'Field can not be empty'
                      : null,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  cursorColor: Colors.teal,
                  style: const TextStyle(color: Colors.white),
                  decoration: authFieldsDecoration.copyWith(labelText: 'Confirm Password'),
                  validator: (val) => val != controller.passwordController.text
                      ? 'Passwords must match'
                      : null,
                ),
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
                          controller.signup();
                        },
                        child: Container(
                              alignment: Alignment.center,
                              width: Size.infinite.width,
                              height: 40,
                              child: controller.loading.value?const CircularProgressIndicator(color: Colors.teal, strokeWidth: 2,):const Text('Sign Up', style: TextStyle(fontSize: 18),),
                            )
                    );
                  }
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? ", style: TextStyle(color: Colors.white),),
                    InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Login!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
