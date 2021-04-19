import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:ostrich/Extensions/HexColor.dart';
import 'package:ostrich/Widgets/CorrelationGraphs.dart';
import 'package:ostrich/Widgets/CountUp.dart';
import 'BasePage.dart';

class HomePageDefaultState extends State<HomePage> {
  Key? keyForUpdateState;

  HomePageDefaultState(Key key) {
    keyForUpdateState = key;
  }

  Widget getLayout(BuildContext context, width, height) {
    return Expanded(
        child: Container(
      color: Colors.black,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Text("Ostrich.AI",
              style: GoogleFonts.rockSalt(
                  textStyle:
                      Theme.of(context).textTheme.headline4!.merge(TextStyle(
                            color: Colors.pink,
                          )))),
          // Load a Lottie file from your assets
          Positioned(
              top: -height / 30,
              child: Container(
                  width: 2 * width / 3,
                  height: height / 3,
                  child: Lottie.asset(
                    'LottieAnimations/eye.json',
                  ))),
          Positioned(
              top: height / 5,
              child: Column(children: [
                Text("Awoke March 3, 2021",
                    style: GoogleFonts.rockSalt(
                        textStyle: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .merge(TextStyle(
                              color: Colors.pink,
                            )))),
                Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Container(
                        width: 300,
                        child: Text(
                            "We provide signals to online hedge funds who pay us depending on their correlation.",
                            style: TextStyle(color: Colors.white)))),
                Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(children: [
                              Text('Avg Daily Return: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .merge(TextStyle(color: Colors.white))),
                              Row(children: [
                                Countup(
                                  begin: 0,
                                  end: 9.7,
                                  precision: 1,
                                  duration: Duration(seconds: 2),
                                  separator: ',',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .merge(TextStyle(color: Colors.green)),
                                ),
                                Text('%',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .merge(TextStyle(color: Colors.green)))
                              ])
                            ])),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(children: [
                              Text('Avg 3 Month Return: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .merge(TextStyle(color: Colors.white))),
                              Row(children: [
                                Countup(
                                  begin: 0,
                                  end: 201.3,
                                  precision: 1,
                                  duration: Duration(seconds: 2),
                                  separator: ',',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .merge(TextStyle(color: Colors.green)),
                                ),
                                Text('%',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .merge(TextStyle(color: Colors.green)))
                              ])
                            ])),
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: CustomizedLine(GlobalKey()))
              ])),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(body: Builder(builder: (context) {
      return SingleChildScrollView(
          child: Container(
              height: height,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    getLayout(context, width, height),
                  ])));
    }));
  }
}

// ignore: must_be_immutable
class HomePage extends BasePage {
  Key key;

  HomePage({required this.key, required String name, required String path})
      : super(key: key, name: name, path: path);

  @override
  State<StatefulWidget> createState() => HomePageDefaultState(key);
}
