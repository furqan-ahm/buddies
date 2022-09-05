import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/controllers/bindings/startup_bindings.dart';
import 'package:task/root.dart';
import 'package:task/screens/splash.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: null,
      builder: (context, snapshot) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          initialBinding: StartUpBindings(),
          theme: ThemeData(
            primarySwatch: Colors.lightBlue, 
          ),
          home: const Splash(),
        );
      }
    );
  }
}
