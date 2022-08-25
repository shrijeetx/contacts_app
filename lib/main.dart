import 'package:contact/utils/constants.dart';
import 'package:contact/view_models/contacts_controller.dart';
import 'package:contact/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await _splashScreenInitialization();
  runApp(const MyApp());
}

Future _splashScreenInitialization() async{
  Get.put(ContactsController());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kScaffoldBackgroundColor,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}