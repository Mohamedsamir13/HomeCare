  import 'package:flutter/material.dart';
  import 'package:get/get_navigation/src/root/get_material_app.dart';
  import 'package:homecare/Features/Authentication/View/Screens/loginPage.dart';
  import 'package:homecare/Features/Authentication/View/Screens/registerPage.dart';
  import 'package:firebase_core/firebase_core.dart';
  import 'package:homecare/Features/Authentication/View/Screens/welcomeScreen.dart';

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(const MyApp());
  }

  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Welcomescreen(),
      );
    }
  }
