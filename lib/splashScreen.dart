import 'dart:io';

import 'package:example_flutter/rippleBackground.dart';
import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<SplashScreen>
    with SingleTickerProviderStateMixin , FlareController{
  AnimationController controller;
  Animation<double> scaleBounceAnim;

  RippleBackground rippleBackground1;
  RippleBackground rippleBackground2;
  RippleBackground rippleBackground3;
  RippleBackground rippleBackground4;
  RippleBackground rippleBackground5;

  double _rockAmount = 0.5;
  double _speed = 1.0;
  double _rockTime = 0.0;
  bool _isPaused = false;

  ActorAnimation _rock;

  @override
  void initialize(FlutterActorArtboard artboard) {
    _rock = artboard.getAnimation("music_walk");
  }


  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    _rockTime += elapsed * _speed;
    _rock.apply(_rockTime % _rock.duration, artboard, _rockAmount);
    return true;
  }


  @override
  void initState() {
    super.initState();
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
          Positioned.fill(
              child: FlareActor("images/Penguin.flr",
                  alignment: Alignment.center,
                  isPaused: _isPaused,
                  fit: BoxFit.cover,
                  animation: "walk",controller: this,)),

          Positioned(
            top: - MediaQuery.of(context).size.height / 1.75,
            left: - MediaQuery.of(context).size.width / 2,
            height:  MediaQuery.of(context).size.height *2,
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

          Positioned.fill(
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                        height: 200,
                        color: Colors.black.withOpacity(0.5),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text("Mix Amount",
                                style: TextStyle(color: Colors.white)),
                            new Slider(
                              value: _rockAmount,
                              min: 0.0,
                              max: 1.0,
                              divisions: null,
                              onChanged: (double value) {
                                setState(() {
                                  _rockAmount = value;
                                });
                              },
                            ),
                            new Text("Speed",
                                style: TextStyle(color: Colors.white)),
                            new Slider(
                              value: _speed,
                              min: 0.2,
                              max: 3.0,
                              divisions: null,
                              onChanged: (double value) {
                                setState(() {
                                  _speed = value;
                                });
                              },
                            ),
                            new Text("Paused",
                                style: TextStyle(color: Colors.white)),
                            new Checkbox(
                              value: _isPaused,
                              onChanged: (bool value) {
                                setState(() {
                                  _isPaused = value;
                                });
                              },
                            )
                          ],
                        )),
                  ])),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  void setViewTransform(Mat2D viewTransform) {
    // TODO: implement setViewTransform
  }
}


