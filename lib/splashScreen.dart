import 'dart:io';

import 'package:example_flutter/rippleBackground.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleBounceAnim;

  RippleBackground rippleBackground1;
  RippleBackground rippleBackground2;
  RippleBackground rippleBackground3;
  RippleBackground rippleBackground4;
  RippleBackground rippleBackground5;


  @override
  void initState() {
    super.initState();
 //   getRemoteConfg();

    rippleBackground1 = RippleBackground(
      isPlaying: true,
      onComplete: () {
        print('Complete1');
        rippleBackground2.startAnimation();
      },
    );
    rippleBackground2 = RippleBackground(
      onComplete: () {
        print('Complete2');
        rippleBackground3.startAnimation();
      },
    );
    rippleBackground3 = RippleBackground(
      onComplete: () {
        print('Complete3');
        rippleBackground4.startAnimation();
      },
    );
    rippleBackground4 = RippleBackground(
      onComplete: () {
        print('Complete4');
        rippleBackground5.startAnimation();
      },
    );
    rippleBackground5 = RippleBackground(
      onComplete: () {
        print('Complete5');
        rippleBackground1.startAnimation();
      },
    );

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    scaleBounceAnim = Tween(begin: 10.0, end: 150.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.bounceOut));


    scaleBounceAnim.addListener(() {
      setState(() {

      });
    });

    Timer(Duration(milliseconds: 500), () {
      controller.forward();
    });
  }



  @override
  Widget build(BuildContext context) {
   // util.getDeviceMetrics(context);


    return splashPage();
  }
  Widget splashPage(){
    return Scaffold(
      body: Stack(
        //alignment: Alignment.center,
        children: <Widget>[

     /*     Positioned.fill(
              child: FlareActor("images/Penguin.flr",
                  alignment: Alignment.center,
                  isPaused: false,
                  fit: BoxFit.cover,
                  animation: "walk")),*/
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                colors: [Color(0xff1E5146),Color(0xff047035)],
                tileMode:
                TileMode.clamp, // repeats the gradient over the canvas
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: /*Image.asset(
              'images/pichai.jpg',
              height: scaleBounceAnim.value,
            ),*/
            FlareActor("images/Penguin.flr",
                alignment: Alignment.center,
                isPaused: false,
                fit: BoxFit.cover,
                animation: "walk")
          ),

          Align(
              alignment: Alignment(0.0, 0.35),
              child: Text(
                'Free Technical Courses | Developer News\n Live Mentorship',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              )),
          Positioned(
            top: - MediaQuery.of(context).size.height / 2,
            left: - MediaQuery.of(context).size.width / 2,
            height:  MediaQuery.of(context).size.height * 2,
            width:  MediaQuery.of(context).size.width * 2,
            child: Stack(
              children: <Widget>[
                rippleBackground2,
                rippleBackground1,
                rippleBackground3,
                rippleBackground4,
                rippleBackground5,
              ],
            ),
          ),
     /*     Container(
            height: 200,
            width: 200,
            child: FlareActor("images/intro(1).flr2d",alignment:Alignment.center, fit:BoxFit.contain, animation:"coding"),
          ),*/
          Align(
            alignment: Alignment(0.0, 0.8),
            child: GestureDetector(
              onTap: () {
                //   print('click');
                //  Navigator.pop(context);

              },
              child: Container(
                alignment: Alignment.center,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    new BorderRadius.all(Radius.circular(40.0))),
                height:70.0,
                width: 200.0,
                child: Text(
                  'Get Started !',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
