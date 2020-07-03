import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'entities/note.dart';
import 'entities/note1.dart';
import 'json_scraping.dart' as hacker_news_scraper;
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'my_flutter_app_icons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

String s;
Future dis(String ss) {
  s = ss;
}

class _HomePageState extends State<HomePage> {
  // Text translated
  String _textTranslated = " ";
  String _textTranslated1 = " ";
  String _textTranslated2 = " ";
  String _textTranslated3 = " ";
  GoogleTranslator _translator = new GoogleTranslator(); // Translator
// Translate the text with the codes of the two languages selected

  List<Note> _notes = List<Note>();
  List<Note1> _notes1 = List<Note1>();

  Future<List<Note>> fetchNotes() async {
    var response = await hacker_news_scraper.initiate(Client(), s);
    var notes = List<Note>();
    var notesJson = json.decode(response);
    for (var noteJson in notesJson) {
      notes.add(Note.fromJson(noteJson));
    }
    return notes;
  }

  Future<List<Note1>> fetchNotes1() async {
    var response = await hacker_news_scraper.initiate1(Client(), s);
    var notes1 = List<Note1>();
    var notesJson1 = json.decode(response);
    for (var noteJson1 in notesJson1) {
      notes1.add(Note1.fromJson(noteJson1));
    }
    return notes1;
  }

  @override
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _notes.addAll(value);
      });
    });
    fetchNotes1().then((value) {
      setState(() {
        _notes1.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(s),
          backgroundColor: Colors.teal.shade500,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            tooltip: 'Back',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.teal[100],
        body: FutureBuilder(
          //future: getHomePost(),
          builder: (context, snapshot) {
            if (snapshot == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    height: 200.0,
                    margin: EdgeInsets.all(5.0),
                    child: Card(
                      elevation: 15.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            //first container
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                10.0, 10.0, 10.0, 0),
                                            child: Text(
                                              _notes[index].title,
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 20.0),
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            customDialog(
                                                context,
                                                _notes[index].title,
                                                _notes1[index].title);
                                          });
                                        },
                                        child: ImageIcon(
                                            AssetImage("images/english.png"))),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 20.0),
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            customDialog1(
                                                context,
                                                _notes[index].title,
                                                _notes1[index].title);
                                          });
                                        },
                                        child: ImageIcon(
                                            AssetImage("images/hindi.png"))),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 20.0),
                                    child: InkWell(
                                        onTap: () {
                                          customAvi2(_notes[index].title,
                                              _notes1[index].title);
                                          customDialog2(
                                              context,
                                              this._textTranslated3,
                                              this._textTranslated2);
                                        },
                                        child: ImageIcon(
                                            AssetImage("images/gujarati.png"))),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                              child: Text(
                                _notes1[index].title,
                                maxLines: 5,
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                  //backgroundColor: Colors.tealAccent,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: _notes1.length,
              );
            }
          },
        ),
      ),
    );
  }

  customDialog(BuildContext context, String title, String des) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              height: MediaQuery.of(context).size.height / 1.20,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.teal.shade200,
                        Colors.teal.shade100,
                        Colors.teal.shade50,
                        Colors.teal.shade100,
                        Colors.teal.shade200
                      ])),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          des,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _onTextChanged(String text) async {
    _translator.translate(text, from: 'en', to: 'hi').then((translatedText) {
      setState(() {
        _textTranslated = translatedText;
      });
    });
    //return _textTranslated;
  }

  _onTextChanged1(String text) async {
    _translator.translate(text, from: 'en', to: 'hi').then((translatedText) {
      setState(() {
        _textTranslated1 = translatedText;
      });
    });
    //return _textTranslated1;
  }

  _onTextChanged2(String text) => _translator
          .translate(text, from: 'en', to: 'gu')
          .then((translatedText) async {
        if (translatedText == " ")
          _onTextChanged2(text);
        else
          _textTranslated2 = translatedText;
      });
  _onTextChanged3(String text) => _translator
          .translate(text, from: 'en', to: 'gu')
          .then((translatedText) async {
        if (translatedText == " ")
          _onTextChanged3(text);
        else
          _textTranslated3 = translatedText;
      });
  customDialog1(BuildContext context, String title, String des) {
    _onTextChanged1(des);
    _onTextChanged(title);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              height: MediaQuery.of(context).size.height / 1.20,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.teal.shade200,
                        Colors.teal.shade100,
                        Colors.teal.shade50,
                        Colors.teal.shade100,
                        Colors.teal.shade200
                      ])),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        this._textTranslated,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          this._textTranslated1,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  customAvi2(String title, String des) {
    _onTextChanged2(des);
    _onTextChanged3(title);
  }

  customDialog2(BuildContext context, String title, String des) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              height: MediaQuery.of(context).size.height / 1.20,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.teal.shade200,
                        Colors.teal.shade100,
                        Colors.teal.shade50,
                        Colors.teal.shade100,
                        Colors.teal.shade200
                      ])),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          des,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
