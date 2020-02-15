import 'dart:convert';

import 'package:baby_name/Constants/AppStrings.dart';
import 'package:baby_name/Utils/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NameListScreen extends StatefulWidget {
  final String genderType;
  final int categoryType;
  final String characterType;
  NameListScreen({Key key, @required this.genderType, @required this.categoryType, @required this.characterType}) : super(key: key);
  @override
  _NameListScreenState createState() => _NameListScreenState();
}

class _NameListScreenState extends State<NameListScreen> {
  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  var items = List<String>();

  TextEditingController editingController = TextEditingController();

  void _query() async {
    final allRows = await dbHelper.queryParticularRows(widget.genderType, widget.categoryType, widget.characterType);
    print('query all rows:');
    allRows.forEach((row){
      //print(row);
      print(row['babyname']);
    });
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems);
    if(query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if(item.contains(query)) {
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
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    items.addAll(duplicateItems);
    // _insert();
    _query();
  }

  @override
  Widget build(BuildContext context) {
    print("Gender Type : "+widget.genderType);
    print("Category : "+widget.categoryType.toString());
    print("Characters : "+widget.characterType);
    return Material(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/baby_bg.png"),
                fit: BoxFit.fill)),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    filterSearchResults(value);
                  },
                  controller: editingController,
                  decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('${items[index]}'),
                    );
                  },
                ),
              ),
            ],
          ),
      ),
    );
  }
}
