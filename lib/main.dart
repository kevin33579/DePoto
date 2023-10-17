import 'dart:io';

import 'package:camera/camera.dart';
import 'package:depoto/views/pages/pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

late List<CameraDescription> cameras;


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DePOTO2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        Splash.routeName: (context) => Splash(),
        MainMenu.routeName: (context) => MainMenu(),
        ContainerDetails.routeName:(context) => ContainerDetails(),
        Survei.routeName: (context) => Survei(),
        SurveiList.routeName: (context) => SurveiList(),
        CraniView.routeName:(context) => CraniView(),
        CraniContainerDetails.routeName: (context) => CraniContainerDetails(),
        CraniList.routeName:(context)=> CraniList(),


      },
    );
  }
}
