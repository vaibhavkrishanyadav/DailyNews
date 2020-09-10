import 'package:flutter/material.dart';
import 'package:newsapp/screens/home.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primaryColor: Colors.white,
  ),
  home: Home(),
));
