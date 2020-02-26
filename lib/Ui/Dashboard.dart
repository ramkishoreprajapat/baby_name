import 'package:baby_name/Constants/AppColors.dart';
import 'package:baby_name/Constants/AppConstant.dart';
import 'package:baby_name/Constants/AppFonts.dart';
import 'package:baby_name/Constants/AppStrings.dart';
import 'package:baby_name/Ui/CategoryScreen.dart';
import 'package:baby_name/Ui/NameListScreen.dart';
import 'package:baby_name/Utils/Utility.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  InterstitialAd _interstitialAd;

  void setUpAnimationIcon() {
    _animationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));

    _animation = new CurvedAnimation(
        parent: _animationController, curve: Curves.easeOut);

    _animation.addListener(() {
      this.setState(() {});
    });

    _animationController.forward();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays([]);

    setUpAnimationIcon();

    _interstitialAd?.dispose();
    _interstitialAd = Utility.createInterstitialAd(AppConstant.DASHBOARD_REWARD_UNIT_AD_ID)..load();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/baby_bg.jpg"),
                fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {


                    _interstitialAd?.show();
                    _interstitialAd = Utility.createInterstitialAd(AppConstant.DASHBOARD_REWARD_UNIT_AD_ID)..load();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryScreen(
                          genderType: AppConstant.BOY,
                        ),
                      ),
                    );
                  },
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: new BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 90.0, // has the effect of softening the shadow
                              spreadRadius: 0, // has the effect of extending the shadow

                            )
                          ],
                        ),
                        child: new Image.asset(
                          "assets/images/baby_boy.png",
                          width: _animation.value * 140,
                          height: _animation.value * 140,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Text(AppStrings.boy,
                            style: TextStyle(
                                color: AppColors.colorYellow,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                fontFamily: AppFonts.harabaraMaisDemo)),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {

                    _interstitialAd?.show();
                    _interstitialAd = Utility.createInterstitialAd(AppConstant.DASHBOARD_REWARD_UNIT_AD_ID)..load();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryScreen(
                          genderType: AppConstant.GIRL,
                        ),
                      ),
                    );
                  },
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: new BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 90.0, // has the effect of softening the shadow
                              spreadRadius: 0, // has the effect of extending the shadow

                            )
                          ],
                        ),
                        child: new Image.asset(
                          "assets/images/baby_girl.png",
                          width: _animation.value * 140,
                          height: _animation.value * 140,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Text(
                          AppStrings.girl,
                          style: TextStyle(
                              color: AppColors.colorOrange,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              fontFamily: AppFonts.harabaraMaisDemo),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            GestureDetector(
                onTap: () {
                  _interstitialAd?.show();
                  _interstitialAd = Utility.createInterstitialAd(AppConstant.DASHBOARD_REWARD_UNIT_AD_ID)..load();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NameListScreen(
                        genderType: 'B',
                        categoryType: 4,
                        characterType: 'K',
                        isFav: true,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: new BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey,
                        blurRadius: 90.0, // has the effect of softening the shadow
                        spreadRadius: 0, // has the effect of extending the shadow

                      )
                    ],
                  ),
                  child: new Image.asset(
                    'assets/images/heart.png',
                    height: 80,
                    width: 80,
                  ),
                )),
            GestureDetector(
                onTap: () {
                  _interstitialAd?.show();
                  _interstitialAd = Utility.createInterstitialAd(AppConstant.DASHBOARD_REWARD_UNIT_AD_ID)..load();
                  Share.share(AppConstant.PLAYSTORE_PATH);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 16.0),
                  decoration: new BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey,
                        blurRadius: 90.0, // has the effect of softening the shadow
                        spreadRadius: 0, // has the effect of extending the shadow

                      )
                    ],
                  ),
                  child: new Image.asset(
                    'assets/images/share.png',
                    height: 80,
                    width: 80,
                  ),
                ))
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
