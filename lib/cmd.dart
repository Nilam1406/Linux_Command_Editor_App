import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:http/http.dart' as http;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Cmd extends StatefulWidget {
  @override
  _CmdState createState() => _CmdState();
}

String data1 = "";

class _CmdState extends State<Cmd> {
  String a = "";
  String b = "";
  String data1 = "";

  myButton() {
    return Material(
      color: Colors.orangeAccent.shade100,
      elevation: 18.0,
      shadowColor: Color(0x8FFFF603),
      borderRadius: BorderRadius.circular(28.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            onChanged: (value) {
              a = value;
            },
            autocorrect: false,
            textAlign: TextAlign.start,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.tablet_android),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              hintText: "Enter Command Here",
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: RaisedButton(
                onPressed: () async {
                  var url = "http://192.168.43.54/cgi-bin/docker.py?p=${a}";
                  // print("url");
                  var r = await http.get(url);
                  setState(() {
                    data1 = r.body;
                  });
                  print(data1);
                },
                color: Color(0xFFE64A19),
                child: Text("Get Output")),
          ),
        ],
      ),
    );
  }

  myItems() {
    return Material(
      color: Color(0xFFE64A19),
      elevation: 18.0,
      shadowColor: Color(0x8FFF9603),
      borderRadius: BorderRadius.circular(28.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text("Output of Command: \n",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                data1,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.dehaze), onPressed: null),
        centerTitle: true,
        title: Text(
          "Command",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color(0xFFE64A19),
      ),
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 12.0,
        crossAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: <Widget>[myButton(), myItems()],
        staggeredTiles: [
          StaggeredTile.extent(2, 150.0),
          StaggeredTile.extent(2, 380.0),
        ],
      ),
    );
  }
}
