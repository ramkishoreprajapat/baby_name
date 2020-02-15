import 'dart:convert';

import 'package:baby_name/Constants/AppColors.dart';
import 'package:baby_name/Constants/AppFonts.dart';
import 'package:baby_name/Constants/AppStrings.dart';
import 'package:baby_name/Model/BabyNameModel.dart';
import 'package:baby_name/Utils/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:toast/toast.dart';
import 'package:tts/tts.dart';

class NameListScreen extends StatefulWidget {
  final String genderType;
  final int categoryType;
  final String characterType;
  NameListScreen(
      {Key key,
      @required this.genderType,
      @required this.categoryType,
      @required this.characterType})
      : super(key: key);
  @override
  _NameListScreenState createState() => _NameListScreenState();
}

class _NameListScreenState extends State<NameListScreen> {
  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  List<BabyNameModel> duplicateItems = new List<BabyNameModel>();
  List<BabyNameModel> items = new List<BabyNameModel>();

  TextEditingController editingController = TextEditingController();

  void _query() async {
    final allRows = await dbHelper.queryParticularRows(
        widget.genderType, widget.categoryType, widget.characterType);
    print('query all rows:');
    allRows.forEach((row) {
      //print(row);
      print(row['babyname']);
      duplicateItems.add(BabyNameModel(
          babyid: row['babyid'],
          babygender: row['babygender'],
          babyname: row['babyname'],
          meaning: row['meaning'],
          religionId: row['religionId']));
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
        if (item.babyname.contains(query)) {
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

  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setEnabledSystemUIOverlays([]);
    _query();

    /*  setState(() {
      items.addAll(duplicateItems);
    });*/
    super.initState();

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
                image: AssetImage("assets/images/baby_bg.png"),
                fit: BoxFit.fill)),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 0.0),
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
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 2.0),
                    child: Card(
                      /*title: Text('${items[index].babyname}'),*/
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            new Row(
                              children: <Widget>[
                                /* new Container(
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
                                        MediaQuery.of(context).size.width - 100,
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
                                    onTap:() {
                                      speak(items[index].babyname);
                                    },
                                    child: Icon(
                                      Icons.volume_up,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      var str = items[index].babyname +'\n' +items[index].meaning;
                                      Clipboard.setData(new ClipboardData(text: str));
                                      Toast.show(AppStrings.copied_to_clipboard, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                                    },
                                    child: Icon(
                                      Icons.content_copy,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                  ),
                                  Icon(
                                    Icons.favorite,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      var str = items[index].babyname +'\n' +items[index].meaning;
                                      Share.share(str);
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
      ),
    );
  }

   speak(text)  async {
    Tts.speak(text);
  }
}
