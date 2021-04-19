import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ostrich/router.dart';
import 'Pages/HomePage.dart';

Future<Map> loadMerchantRoutes() async {
  WidgetsFlutterBinding.ensureInitialized();
  Map<String, HomePage Function(BuildContext)> routes = {};
  return routes;
}

void main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    print(details.exception);
    print(details.stack);
    final String coffeeMugAsciiArt = """
     (  ) ) (   )
       ) (   ) (
      (   ) (  )
     ___________
    /___________\
    |           |_____
    |              _  \
    |             | | |
    |             |_| |
    |            _____/
    |           |
    |___________|
    """;
    final String errorScreenText1 = "Well, this wasn't supposed to happen!";
    final String errorScreenText2 =
        "Something's gone wrong, and I've sent a note to the team already. You might be able to fix it if you refresh the screen. In the mean time, might I suggest a fresh cup of coffee?";
    final String errorScreenText3 = "- athelite bot 5000";
    return Column(children: [
      Expanded(
          child: Padding(
              padding: EdgeInsets.only(top: 80),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(coffeeMugAsciiArt,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              backgroundColor: Colors.transparent,
                              decoration: TextDecoration.none))
                    ]),
                    Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Container(
                            width: 330,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(errorScreenText1,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          backgroundColor: Colors.transparent,
                                          decoration: TextDecoration.none)),
                                  Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Text(errorScreenText2,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              backgroundColor:
                                              Colors.transparent,
                                              decoration:
                                              TextDecoration.none))),
                                  Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(errorScreenText3,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w900,
                                              backgroundColor:
                                              Colors.transparent,
                                              decoration: TextDecoration.none)))
                                ])))
                  ])))
    ]);
  };
  var routes = await loadMerchantRoutes();
  var app = RoutedApp(routes);
  return runZonedGuarded(
        () => runApp(app),
        (error, stackTrace) async {
      print(error);
      print(stackTrace);
    },
  );
}
