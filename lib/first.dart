import 'package:flutter/material.dart';
import 'package:freegames/gamespage.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("First Page")
      ),
      body: Container(
        child: Center(
          child: RaisedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => GamesPage()));
            },
            child: Text("Entrar"),
          ),
        ),
      ),
    );
  }
}