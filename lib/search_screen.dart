import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:medifo2/display.dart' as display;
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = "";
  TextEditingController searchController = TextEditingController();
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

  searchAppBar(BuildContext context) {
    return GradientAppBar(
      gradient: LinearGradient(colors: [Colors.teal[300], Colors.teal[700]]),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 20),
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: TextField(
            controller: searchController,
            onChanged: (val) {
              setState(() {
                query = val;
              });
            },
            cursorColor: Colors.black87,
            autofocus: true,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 35,
            ),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  WidgetsBinding.instance
                      .addPostFrameCallback((_) => searchController.clear());
                  display.dis(query);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => display.HomePage(),
                    ), //MaterialPageRoute
                  );
                },
              ),
              border: InputBorder.none,
              hintText: "Search",
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Color(0x88ffffff),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: searchAppBar(context),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }
}
