import 'package:baby_name/Constants/AppColors.dart';
import 'package:baby_name/Constants/AppFonts.dart';
import 'package:baby_name/Constants/AppStrings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

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
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/baby_bg.png"),
                fit: BoxFit.fill)),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Image.asset(
                  "assets/images/baby_boy.png",
                  width: _animation.value * 140,
                  height: _animation.value * 140,
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
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Image.asset(
                  "assets/images/baby_girl.png",
                  width: _animation.value * 140,
                  height: _animation.value * 140,
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
            )
          ],
        ),
      ),
    );
  }
}
