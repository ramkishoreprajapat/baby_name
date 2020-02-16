import 'package:flutter/material.dart';

class BabyNameModel {
  final babyid;
  final babygender;
  final String babyname;
  final meaning;
  final religionId;
  int isfav;
  Color isfavColor;

    BabyNameModel(
      {this.babyid, this.babygender, this.babyname, this.meaning, this.religionId, this.isfav, this.isfavColor = Colors.grey});
}
