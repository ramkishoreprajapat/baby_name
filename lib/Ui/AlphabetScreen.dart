import 'package:baby_name/Constants/AppColors.dart';
import 'package:baby_name/Constants/AppConstant.dart';
import 'package:baby_name/Constants/AppFonts.dart';
import 'package:baby_name/Constants/AppStrings.dart';
import 'package:baby_name/Model/AlphabetModel.dart';
import 'package:baby_name/Ui/NameListScreen.dart';
import 'package:baby_name/Utils/Utility.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AlphabetScreen extends StatefulWidget {
  final String genderType;
  final int categoryType;
  AlphabetScreen({Key key, @required this.genderType, @required this.categoryType}) : super(key: key);
  @override
  _AlphabetScreenState createState() => _AlphabetScreenState();
}

class _AlphabetScreenState extends State<AlphabetScreen> {
  List<AlphabetModel> mList;
  InterstitialAd _interstitialAd;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays([]);

    mList = Utility.getAlphabets();
    _interstitialAd?.dispose();
    _interstitialAd = Utility.createInterstitialAd(AppConstant.DASHBOARD_REWARD_UNIT_AD_ID)..load();
  }

  @override
  Widget build(BuildContext context) {
    print("Gender Type : "+widget.genderType);
    print(" Category : "+widget.categoryType.toString());
    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/baby_bg.jpg"), fit: BoxFit.fill),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
              child: new Text(
                AppStrings.select_baby_name_by_letter,
                style: TextStyle(
                    color: AppColors.colorYellow,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    fontFamily: AppFonts.harabaraMaisDemo),
                textAlign: TextAlign.start,
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 9.0,
                  mainAxisSpacing: 9.0,
                ),
                itemCount: mList.length,
                itemBuilder: (context, i) => SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: new Container(
                    child: RaisedButton(
                      color: AppColors.colorOrangeTransparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10)),
                      padding: EdgeInsets.all(8.0),
                      onPressed: () {
                        _interstitialAd?.show();
                        _interstitialAd = Utility.createInterstitialAd(AppConstant.DASHBOARD_REWARD_UNIT_AD_ID)..load();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NameListScreen(
                              genderType: widget.genderType,
                              categoryType: widget.categoryType,
                              characterType: mList[i].text,
                              isFav: false,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        mList[i].text,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 36.0,
                            fontFamily: AppFonts.harabaraMaisDemo),
                      ),
                    ),
                  ),
                ),
              ),
            ),
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
