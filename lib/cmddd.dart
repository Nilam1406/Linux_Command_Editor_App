import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Cmd1 extends StatefulWidget {
  @override
  _Cmd1State createState() => _Cmd1State();
}

String data1;
String output;
String a;

class _Cmd1State extends State<Cmd1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
          leading: Icon(Icons.dehaze),
          centerTitle: true,
          title: Text(
            "LinuxTerminal",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red.shade500),
      body: Container(
        child: StaggeredGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12.0,
          crossAxisSpacing: 12.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          staggeredTiles: [
            StaggeredTile.extent(2, 150.0),
            StaggeredTile.extent(2, 380.0),
          ],
          children: <Widget>[
            Material(
              color: Colors.black,
              elevation: 18.0,
              shadowColor: Color(0x8FFFF603),
              borderRadius: BorderRadius.circular(28.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    height: 60,
                    child: TextField(
                      onChanged: (value) {
                        a = value;
                      },
                      autocorrect: false,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixText: ' root@localhost ~ ',
                        prefixStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.black),
                        // border: OutlineInputBorder(),
                        hintText: "Enter Command Here",
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: RaisedButton(
                        onPressed: () async {
                          var client = http.Client();
                          try {
                            var uriResponse = await client.post(Uri.http(
                                "192.168.43.100", "/cgi-bin/cmd.py", {"p": a}));
                            setState(() {
                              data1 = uriResponse.body;
                            });
                            print(data1);
                          } finally {
                            client.close();
                          }
                        },
                        color: Colors.orangeAccent,
                        child: Text("Submit")),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/rhel.jpeg'), fit: BoxFit.fill)),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    // Container(
                    //   padding: EdgeInsets.all(20.0),
                    //   margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    //   child: Text("Output of Command: \n",
                    //       style: TextStyle(
                    //           color: Colors.black,
                    //           fontSize: 20,
                    //           fontWeight: FontWeight.bold)),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Center(
                        child: Text(
                          data1 ?? " ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
