import 'package:baby_name/Constants/AppColors.dart';
import 'package:baby_name/Constants/AppConstant.dart';
import 'package:baby_name/Constants/AppFonts.dart';
import 'package:baby_name/Constants/AppStrings.dart';
import 'package:baby_name/Model/BabyNameModel.dart';
import 'package:baby_name/Utils/DatabaseHelper.dart';
import 'package:baby_name/Utils/Utility.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:toast/toast.dart';
import 'package:tts/tts.dart';

class NameListScreen extends StatefulWidget {
  final String genderType;
  final int categoryType;
  final String characterType;
  final bool isFav;
  NameListScreen(
      {Key key,
      this.genderType,
      this.categoryType,
      this.characterType,
      this.isFav})
      : super(key: key);
  @override
  _NameListScreenState createState() => _NameListScreenState();
}

class _NameListScreenState extends State<NameListScreen> {
  InterstitialAd _interstitialAd;
  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  List<BabyNameModel> duplicateItems = new List<BabyNameModel>();
  List<BabyNameModel> items = new List<BabyNameModel>();

  TextEditingController editingController = TextEditingController();

  void _query() async {
    var allRows;
    if(widget.isFav) {
      allRows = await dbHelper.queryFavRows();
    }else{
      allRows = await dbHelper.queryParticularRows(
          widget.genderType, widget.categoryType, widget.characterType);
    }

    print('query all rows:');
    allRows.forEach((row) {
      //print(row);
      print(row['babyname']);
      print(row['isfav']);
      duplicateItems.add(
        BabyNameModel(
            babyid: row['babyid'],
            babygender: row['babygender'],
            babyname: row['babyname'],
            meaning: row['meaning'],
            religionId: row['religionId'],
            isfav: row['isfav'],
            isfavColor: row['isfav'] == 0 ? Colors.grey : Colors.red),
      );
    });
    items.addAll(duplicateItems);
    setState(() {});
  }

  void filterSearchResults(String query) {
    List<BabyNameModel> dummySearchList = List<BabyNameModel>();
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<BabyNameModel> dummyListData = List<BabyNameModel>();
      dummySearchList.forEach((item) {
        if (item.babyname.toLowerCase().contains(query.toLowerCase()) || item.meaning.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }

  void removeItem(int index) {
    setState(() {
      items = List.from(items)
        ..removeAt(index);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setEnabledSystemUIOverlays([]);

      _query();


    /*  setState(() {
      items.addAll(duplicateItems);
    });*/
    super.initState();
    _interstitialAd?.dispose();
    _interstitialAd = Utility.createInterstitialAd(AppConstant.DASHBOARD_REWARD_UNIT_AD_ID)..load();
    // _insert();
  }

  @override
  Widget build(BuildContext context) {
    print("Gender Type : " + widget.genderType);
    print("Category : " + widget.categoryType.toString());
    print("Characters : " + widget.characterType);
    return Material(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/baby_bg.jpg"),
                fit: BoxFit.fill)),
        child: Stack(
          children: [
            Column(
              children: <Widget>[
                Visibility(
                  visible: !widget.isFav,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 4.0),
                    child: Theme(
                      data: new ThemeData(
                          primaryColor: AppColors.colorOrange,
                          primaryColorDark: AppColors.colorOrange,
                          cursorColor: Colors.black),
                      child: TextField(
                        onChanged: (value) {
                          filterSearchResults(value);
                        },
                        controller: editingController,
                        decoration: InputDecoration(
                          fillColor: AppColors.colorOrange,
                          hintText: AppStrings.search,
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.colorOrange,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 2.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                new Row(
                                  children: <Widget>[
                                   /*  new Container(

                                      width: 40.0,

                                      height: 40.0,

                                      decoration: new BoxDecoration(

                                          shape: BoxShape.circle,

                                          image: new DecorationImage(

                                              fit: BoxFit.fill,

                                              image: new AssetImage(

                                                  "assets/images/user_profile.jpg"))),

                                    ),*/

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                100,
                                        child: new Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              '${items[index].babyname}',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily:
                                                      AppFonts.harabaraMaisDemo,
                                                  fontSize: 14.0),
                                            ),
                                            Text(
                                              '${items[index].meaning}',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontFamily:
                                                      AppFonts.harabaraMaisDemo,
                                                  fontSize: 10.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                new Divider(
                                  height: 5,
                                  color: Colors.grey,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          speak(items[index].babyname);
                                          _interstitialAd?.show();
                                          _interstitialAd = Utility.createInterstitialAd(AppConstant.DASHBOARD_REWARD_UNIT_AD_ID)..load();
                                        },
                                        child: Icon(
                                          Icons.volume_up,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          var str = items[index].babyname +
                                              '\n' +
                                              items[index].meaning;

                                          Clipboard.setData(
                                              new ClipboardData(text: str));

                                          Toast.show(
                                              AppStrings.copied_to_clipboard,
                                              context,
                                              duration: Toast.LENGTH_SHORT,
                                              gravity: Toast.BOTTOM);
                                        },
                                        child: Icon(
                                          Icons.content_copy,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {

                                          dbHelper.updateFav(
                                              items[index].babyid,
                                              items[index].isfav == 0 ? 1 : 0);

                                          if(widget.isFav){
                                            removeItem(index);
//                                            items.removeAt(index);
                                          }else {
                                            setState(() {
                                              if (items[index].isfav == 0) {
                                                items[index].isfavColor =
                                                    Colors.red;

                                                items[index].isfav = 1;
                                              } else {
                                                items[index].isfavColor =
                                                    Colors.grey;

                                                items[index].isfav = 0;
                                              }
                                            });

                                           //
                                          }

                                        },
                                        child: Icon(
                                          Icons.favorite,
                                          color: items[index].isfavColor,
                                          size: 20,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          var str = items[index].babyname +
                                              '\n' +
                                              items[index].meaning;

                                          Share.share(str);

                                          _interstitialAd?.show();
                                          _interstitialAd = Utility.createInterstitialAd(AppConstant.DASHBOARD_REWARD_UNIT_AD_ID)..load();
                                        },
                                        child: Icon(
                                          Icons.share,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Visibility(
              visible: widget.isFav ? items.length == 0 ? true : false : false,
              child: Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .50 - 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Image.asset(
                      'assets/images/empty_heart.png',
                      height: 80,
                      width: 80,
                    ),
                    new Text(
                      AppStrings.not_added_favorite_yet,
                      style: TextStyle(
                          color: AppColors.colorWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          fontFamily: AppFonts.harabaraMaisDemo),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  speak(text) async {
    Tts.speak(text);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _interstitialAd?.dispose();
  }

}
