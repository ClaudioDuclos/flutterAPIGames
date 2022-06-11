import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freegames/first.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const GamesPage());
}

//Primeiro Bloco
class GamesPage extends StatelessWidget {
  const GamesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ConsultaPad',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Free Games - List'),
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

      Game game = Game(u["id"], u["title"], u["genre"], u["thumbnail"], u["short_description"], u["platform"]);

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
                      child: Text('Loading Games...',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: Colors.purple,
                        ),
                      ),

                    )
                );
              }
              else{
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int id){
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(
                            snapshot.data[id].thumbnail
                        ),
                      ),
                      title: Text(snapshot.data[id].title,
                      style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600,
                      color: Colors.purple),),
                      subtitle: Text(snapshot.data[id].genre,
                        style: TextStyle(fontFamily: 'Montserrat'),),
                      onTap:(){
                        Navigator.push(context,
                            //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DescPage()));
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
      backgroundColor: Colors.purple,
      body: Stack(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                ),
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: MediaQuery.of(context).size.height / 1.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 110),
                      child: Column(
                        children: [
                          //FlutterLogo(size: 100),
                          // Container(
                          //     width: 100,
                          //     height: 95,
                          //     child: Image.asset('assets/images/white.png')
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              game.title,
                              style: TextStyle(
                                  fontFamily: 'Montserrat', fontSize: 30, fontWeight: FontWeight.w800),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Text(
                                game.short_description,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
                            child: Container(
                              child: Divider(color: Colors.purple),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Text(
                                'Genre: ${game.genre}',
                                textAlign: TextAlign.center,
                                style:
                                TextStyle(fontSize: 20, color: Colors.grey[600], fontFamily: 'Montserrat', fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1,
                              child: Text(
                                'Platform: ${game.platform}',
                                textAlign: TextAlign.center,
                                style:
                                TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600, fontFamily:'Montserrat'),
                              ),
                            ),
                          ),
                          Container(
                            width: 200,
                            height: 75,
                            padding: const EdgeInsets.only(top: 30),
                              child: RaisedButton(
                                color: Colors.purple,
                                textColor: Colors.white,
                                hoverColor: Colors.purple[300],
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => GamesPage()));
                                },
                                child: Text("See more"),
                              ),
                          ),
                          Container(
                            width: 200,
                            height: 75,
                            //
                            padding: const EdgeInsets.only(top: 30),
                            child: RaisedButton(
                              color: Colors.purple,
                              textColor: Colors.white,
                              hoverColor: Colors.purple[300],
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => GamesPage()));
                              },
                              child: Text("Back"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 7,
                ),
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 25.0,
                        spreadRadius: 2,
                      )
                    ],
                  ),

                  child: Image.network(game.thumbnail, height: 100),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}




class Game{
  final int id;
  final String title;
  final String genre;
  final String thumbnail;
  final String short_description;
  final String platform;

  Game(this.id, this.title, this.genre, this.thumbnail, this.short_description, this.platform);

}
