import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import 'package:task/controllers/user_panel_controller.dart';
import 'package:task/screens/user/pages/home.dart';
import 'package:task/screens/user/pages/inbox.dart';
import 'package:task/screens/user/pages/profile.dart';
import 'package:task/screens/user/pages/search.dart';

class UserPanel extends GetView<UserPanelController> {
  const UserPanel({Key? key}) : super(key: key);

  @override
  UserPanelController get controller => Get.put(UserPanelController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Obx(
          ()=>IndexedStack(
            index: controller.selectedPage.value,
            children: const [Home(),Search(), Inbox(), ProfilePage()],
          )
        ),
      ),
      bottomNavigationBar: Obx(() {
          return MoltenBottomNavigationBar(
            domeCircleColor: Colors.teal,
              tabs: [
                MoltenTab(icon: Icon(Icons.home)),
                MoltenTab(icon: Icon(Icons.search)),
                MoltenTab(icon: Icon(Icons.inbox)),
                MoltenTab(icon: Icon(Icons.person)),

              ],
              selectedIndex: controller.selectedPage.value,
              onTabChange: (index) {
                controller.switchPage(index);
              });
        }
      ),
    );
  }
}
