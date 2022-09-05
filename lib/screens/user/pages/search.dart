import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/constants/theme.dart';
import 'package:task/controllers/search_controller.dart';

class Search extends GetWidget<SearchController> {
  const Search({Key? key}) : super(key: key);

  @override
  SearchController get controller => Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Size.infinite.width,
      height: Size.infinite.height,
      color: Colors.teal,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          TextField(
            style: TextStyle(color: Colors.white),
            decoration: searchFieldDecoration,
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: controller.users.value.length,
                itemBuilder: (context, index) {
                  final user = controller.users.value[index];
                  print(user.photoUrl);
                  return ListTile(
                    tileColor: Colors.white,
                    leading: CircleAvatar(
                      foregroundImage: user.photoUrl == null
                          ? null
                          : Image.network(user.photoUrl!).image,
                      radius: 20,
                    ),
                    title: Text(
                      user.displayName!,
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.message_rounded),
                      color: Colors.white,
                    ),
                  );
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
