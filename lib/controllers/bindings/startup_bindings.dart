import 'package:get/get.dart';
import 'package:task/controllers/auth_controller.dart';

class StartUpBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
    
}