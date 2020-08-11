import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medifo2/intro.dart';
//import 'package:medifo2/search_screen.dart';
//import 'display.dart';
//import 'homepage.dart';

Future<Null> main(List<String> arguments) async {
  WidgetsFlutterBinding.ensureInitialized();
  //print(await hacker_news_scraper.initiate(Client(),"wikoryl"));

//void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: App(),
    ),
  );
  //print(await hacker_news_scraper.initiate(Client(),"wikoryl"));
}
