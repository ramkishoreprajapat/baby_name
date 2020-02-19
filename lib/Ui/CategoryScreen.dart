import 'package:baby_name/Constants/AppColors.dart';
import 'package:baby_name/Constants/AppConstant.dart';
import 'package:baby_name/Constants/AppFonts.dart';
import 'package:baby_name/Constants/AppStrings.dart';
import 'package:baby_name/Ui/AlphabetScreen.dart';
import 'package:baby_name/Utils/Utility.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CategoryScreen extends StatefulWidget {
  final String genderType;
  CategoryScreen({Key key, @required this.genderType}) : super(key: key);
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  InterstitialAd _interstitialAd;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays([]);
    _interstitialAd?.dispose();
    _interstitialAd = Utility.createInterstitialAd(AppConstant.DASHBOARD_REWARD_UNIT_AD_ID)..load();
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
                    child: GestureDetector(
                      onTap: () {
                        _interstitialAd?.show();
                        _interstitialAd = Utility.createInterstitialAd(AppConstant.DASHBOARD_REWARD_UNIT_AD_ID)..load();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AlphabetScreen(
                              genderType: widget.genderType,
                              categoryType: AppConstant.HINDU,
                            ),
                          ),
                        );
                      },
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
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _interstitialAd?.show();
                        _interstitialAd = Utility.createInterstitialAd(AppConstant.DASHBOARD_REWARD_UNIT_AD_ID)..load();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AlphabetScreen(
                              genderType: widget.genderType,
                              categoryType: AppConstant.MUSLIM,
                            ),
                          ),
                        );
                      },
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
                    child: GestureDetector(
                      onTap: () {
                        _interstitialAd?.show();
                        _interstitialAd = Utility.createInterstitialAd(AppConstant.DASHBOARD_REWARD_UNIT_AD_ID)..load();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AlphabetScreen(
                              genderType: widget.genderType,
                              categoryType: AppConstant.SIKH,
                            ),
                          ),
                        );
                      },
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
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _interstitialAd?.show();
                        _interstitialAd = Utility.createInterstitialAd(AppConstant.DASHBOARD_REWARD_UNIT_AD_ID)..load();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AlphabetScreen(
                              genderType: widget.genderType,
                              categoryType: AppConstant.CHISTIAN,
                            ),
                          ),
                        );
                      },
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _interstitialAd?.dispose();
  }
}
