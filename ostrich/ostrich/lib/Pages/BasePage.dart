import 'package:flutter/material.dart';

// ignore: must_be_immutable
abstract class BasePage extends StatefulWidget {
  final String name;
  final String path;

  BasePage({required Key key, required this.name, required this.path}) : super(key: key);
}