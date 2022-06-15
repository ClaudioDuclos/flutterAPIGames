import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatelessWidget{
  List<PageViewModel> getPages(){
    return[
      PageViewModel(
        image: Image.network('https://img.freepik.com/free-vector/office-concept-illustration_114360-1248.jpg?w=2000'),
        title: 'Apenas Título',
        body: 'Essa é a descrição!',
        footer: Text('Estou testando ok!', style: TextStyle(color: Colors.black),
        )
      )
    ];
  }



  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: Colors.white,
        pages: getPages(),
        done:Text('Done',
            style: TextStyle(color: Colors.black)),
        onDone: (){},
      ),
    );
  }
}