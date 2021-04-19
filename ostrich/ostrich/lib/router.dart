import 'dart:html' as html;

import 'package:flutter/material.dart';

import 'Pages/BasePage.dart';
import 'Pages/HomePage.dart';


class RoutedApp extends MaterialApp {
  factory RoutedApp(Map merchantRoutes) {
    var knownRoutes = {
      '/': (BuildContext context) => HomePage(
        key: GlobalObjectKey<HomePageDefaultState>(
            DateTime.now().millisecondsSinceEpoch),
        name: 'homePage',
        path: '/',
      )
    };
    knownRoutes
        .addAll(merchantRoutes as Map<String, HomePage Function(BuildContext)>);
    return RoutedApp._(knownRoutes);
  }

  static Route unKnownRoute(RouteSettings settings) {
      return MaterialPageRoute<dynamic>(builder: (context) {
        return HomePage(
            key: GlobalObjectKey<HomePageDefaultState>(
                DateTime.now().millisecondsSinceEpoch),
            name: 'homePage',
            path: '/');
      });
  }

  RoutedApp._(Map routes)
      : super(
      title: 'Ostrich.ai | Investment Club',
      onUnknownRoute: unKnownRoute,
      onGenerateRoute: unKnownRoute,
      routes: routes as Map<String, Widget Function(BuildContext)>,
      debugShowCheckedModeBanner: false,
      theme: ThemeData());
}
