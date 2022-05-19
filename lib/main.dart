import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

//Primeiro Bloco
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ConsultaPad',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Lista de Jogos'),
    );
  }
}


//Segundo Bloco
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


//Terceiro Bloco (conteúdo)
class _MyHomePageState extends State<MyHomePage> {

  Future<List<Game>> _getGames() async{
    var data = await http.get(Uri.parse("https://free-to-play-games-database.p.rapidapi.com/api/games?rapidapi-key=ea48a3f6b4mshdb6f4b6978f473dp158ff7jsn4e1c2e0b8ec8"));
    var jsonData = json.decode(data.body);

    List<Game> games = [];

    for(var u in jsonData){

      Game game = Game(u["id"], u["title"], u["genre"], u["thumbnail"]);

      games.add(game);

    }

    print(games.length);
    return games;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getGames(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.data == null){
              return Container(
                child: Center(
                  child: Text('Carregando...'),
                )
              );
            }
            else{
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int id){
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      snapshot.data[id].thumbnail
                    ),
                  ),
                  title: Text(snapshot.data[id].title),
                  subtitle: Text(snapshot.data[id].genre),
                  onTap:(){
                    Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => DescPage(snapshot.data[id])));
                  },
                );
              },
            );
            }
          },
        )
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}


class DescPage extends StatelessWidget {

  final Game game;
  DescPage(this.game);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(game.title),
      ),
    );
  }
}


class Game{
  final int id;
  final String title;
  final String genre;
  final String thumbnail;

  Game(this.id, this.title, this.genre, this.thumbnail);

}
