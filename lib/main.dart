import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app1/pages/HomePage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app1/provider/google_sign_pro.dart';
import 'package:get/get.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(home: MyApp(),debugShowCheckedModeBanner: false,));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => googleSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
           home:HomePage()));
}
