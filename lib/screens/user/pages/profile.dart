import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/controllers/profile_controller.dart';

class ProfilePage extends GetWidget<ProfileController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfileController get controller => Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Size.infinite.width,
      height: Size.infinite.height,
      color: Colors.teal,
      child: Center(child: Obx(() {
        if(controller.currentUser.value==null)return Container();
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundColor: Colors.blueGrey.shade700,
                foregroundColor: Colors.white,
                foregroundImage: controller.currentUser.value!.photoUrl == null
                    ? null
                    : Image.network(controller.currentUser.value!.photoUrl!).image,
                child: Align(
                  alignment: Alignment.bottomRight + const Alignment(0, 0),
                  child: GestureDetector(
                    onTap: () {
                      controller.setPhoto();
                    },
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                controller.currentUser.value!.displayName ?? '',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton.icon(
                  onPressed: () {
                    controller.signOut();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    foregroundColor: MaterialStateProperty.all(Colors.teal),
                  ),
                  icon: const Icon(
                    Icons.logout,
                  ),
                  label: const Text('Sign Out'))
            ],
          ),
        );
      })),
    );
  }
}
