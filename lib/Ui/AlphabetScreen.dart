import 'package:baby_name/Constants/AppColors.dart';
import 'package:baby_name/Constants/AppFonts.dart';
import 'package:baby_name/Constants/AppStrings.dart';
import 'package:baby_name/Model/AlphabetModel.dart';
import 'package:baby_name/Utils/Utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AlphabetScreen extends StatefulWidget {
  @override
  _AlphabetScreenState createState() => _AlphabetScreenState();
}

class _AlphabetScreenState extends State<AlphabetScreen> {
  List<AlphabetModel> mList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays([]);

    mList = Utility.getAlphabets();
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
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10)),
                      padding: EdgeInsets.all(8.0),
                      onPressed: null,
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
}
