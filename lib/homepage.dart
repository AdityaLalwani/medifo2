import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'package:medifo2/display.dart' as dis;
import 'package:medifo2/search_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage1 extends StatefulWidget {
  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          title: Text('MediFo: 2'),
          backgroundColor: Colors.black87,
          leading: Padding(
            child: Image.asset("images/vaccine.png"),
            padding: EdgeInsets.all(10),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                  ), //MaterialPageRoute
                );
              },
            ),
          ],
        ),
        body: OCR());
  }
}

class OCR extends StatefulWidget {
  @override
  _OCRState createState() => _OCRState();
}

class _OCRState extends State<OCR> {
  SharedPreferences sharedPreferences;

  Future<String> LastScan() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String score = sharedPreferences.getString('high_score');
    if (score == null) {
      score = 'croc';
    }
    return score;
  }

  void updateHighScore(String textValue) {
    String sc = sharedPreferences.getString('high_score');
    if (sc == null) {
      sharedPreferences.setString('high_score', textValue);
    } else {
      sharedPreferences.setString('high_score', textValue);
    }
  }

  int _cameraOcr = FlutterMobileVision.CAMERA_BACK;

  String _textValue = "";
  Future<Null> _read() async {
    List<OcrText> texts = [];
    try {
      texts = await FlutterMobileVision.read(
        camera: _cameraOcr,
        waitTap: true,
        fps: 2.0,
        autoFocus: true,
      );
    } on Exception {
      texts.add(new OcrText('Failed to recognize text.'));
    }
    if (!mounted) return;

    setState(() {
      _textValue = (texts[0].value);
      dis.dis(_textValue);
      updateHighScore(_textValue);
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => dis.HomePage(),
      ), //MaterialPageRoute
    );
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
            SizedBox(height: 220),
            Text(
              'Your Last Scan\n',
              style: TextStyle(color: Colors.white70),
            ),
            FutureBuilder<String>(
              future: LastScan(),
              builder: (ctx, snapshot) {
                if (snapshot.hasData) {
                  return InkWell(
                    onTap: () async {
                      dis.dis(snapshot.data);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => dis.HomePage(),
                        ), //MaterialPageRoute
                      );
                    },
                    child: Center(
                      child: Text(
                        snapshot.data,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                } else {
                  return Text(
                    'CROC',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 30),
            RaisedButton(
              onPressed: _read,
              child: new Text(
                'Start Scanning',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.teal,
              splashColor: Colors.orangeAccent,
            ),
            SizedBox(height: 10),
            Text(
              'Tap on the text to Select',
              style: TextStyle(color: Colors.white70),
            ),
          ])),
    );
  }
}
