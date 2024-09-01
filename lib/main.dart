import 'package:electech/features/authentication/controllers/auth_controller.dart';
import 'package:electech/utiles/Constant/strings.dart';
import 'package:electech/utiles/Themes/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: homePageAppBareTitle,
      theme: LightTheme.theme,
      //darkTheme: DarkTheme.theme,
      themeMode: ThemeMode.system,
      home: Scaffold(body: Center(child: SizedBox( height: MediaQuery.of(context).size.height*0.2, child: const CircularProgressIndicator()),)),

    );
  }
}


