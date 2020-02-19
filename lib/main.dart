import 'package:baby_name/Constants/AppConstant.dart';
import 'package:baby_name/Ui/AlphabetScreen.dart';
import 'package:baby_name/Ui/CategoryScreen.dart';
import 'package:baby_name/Ui/Dashboard.dart';
import 'package:baby_name/Ui/NameListScreen.dart';
import 'package:baby_name/Utils/Utility.dart';
import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';

void main() => runApp(MyApp());
// You can also test with your own ad unit IDs by registering your device as a
// test device. Check the logs for your device's ID value.
const String testDevice = 'YOUR_DEVICE_ID';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  BannerAd _bannerAd;

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: AppConstant.AD_MOB_APP_ID);
    _bannerAd = Utility.createBannerAd()..load();

  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _bannerAd ??= Utility.createBannerAd();
    _bannerAd
      ..load()
      ..show();


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Dashboard(),
    );
  }
}

