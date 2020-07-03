import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medifo2/intro.dart';
import 'package:medifo2/search_screen.dart';
import 'display.dart';
import 'homepage.dart';

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

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black87,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'MEDIFO',
                style: TextStyle(
                    fontFamily: 'Aclonica',
                    color: Colors.white,
                    fontSize: 50.0),
              ),
              Center(
                child: RaisedButton(
                  color: Colors.black87,
                  child: CircleAvatar(
                    radius: 80.0,
                    backgroundImage: AssetImage('images/vaccine.png'),
                  ),
                  onPressed: () {
                    // Navigate to the second screen using a named route
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => App(),
                      ), //MaterialPageRoute
                    );
                  },
                ),
              ),
              Center(
                child: Text(
                  'MEDICINE INFO.',
                  style: TextStyle(
                      fontFamily: 'Aclonica',
                      color: Colors.white,
                      fontSize: 40.0),
                ),
              )
            ],
          )),
    );
  }
}
