import 'package:baby_name/Constants/AppColors.dart';
import 'package:baby_name/Constants/AppFonts.dart';
import 'package:baby_name/Constants/AppStrings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays([]);
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/baby_bg.png"), fit: BoxFit.fill),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: new Text(
                AppStrings.tap_to_select_your_category,
                style: TextStyle(
                    color: AppColors.colorYellow,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    fontFamily: AppFonts.harabaraMaisDemo),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Row(
                children: <Widget>[
                  Expanded(
                    child: Card(
                      elevation: 18.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            new Image.asset("assets/images/om.png", height: 60, width: 60,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Text(
                                AppStrings.hindu,
                                style: TextStyle(
                                    color: AppColors.colorOrange,
                                    fontSize: 20.0,
                                    fontFamily: AppFonts.pointDEMOSemiBold,),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      elevation: 18.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            new Image.asset("assets/images/ramadan.png", height: 60, width: 60,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Text(
                                AppStrings.muslim,
                                style: TextStyle(
                                  color: AppColors.colorOrange,
                                  fontSize: 20.0,
                                  fontFamily: AppFonts.pointDEMOSemiBold,),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Row(
                children: <Widget>[
                  Expanded(
                    child: Card(
                      elevation: 18.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            new Image.asset("assets/images/sardar.png", height: 60, width: 60,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Text(
                                AppStrings.sikh,
                                style: TextStyle(
                                  color: AppColors.colorOrange,
                                  fontSize: 20.0,
                                  fontFamily: AppFonts.pointDEMOSemiBold,),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      elevation: 18.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            new Image.asset("assets/images/god.png", height: 60, width: 60,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Text(
                                AppStrings.christian,
                                style: TextStyle(
                                  color: AppColors.colorOrange,
                                  fontSize: 20.0,
                                  fontFamily: AppFonts.pointDEMOSemiBold,),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
