import 'package:get/get.dart';
import 'package:task/screens/user/pages/home.dart';

import '../screens/user/pages/inbox.dart';
import '../screens/user/pages/profile.dart';
import '../screens/user/pages/search.dart';

class UserPanelController extends GetxController{

  RxInt selectedPage=0.obs;


  final List<GetWidget> pages=[const Home(),const Search(), const Inbox(), const ProfilePage()];

  switchPage(int index){
    selectedPage.value=index;
  }

}