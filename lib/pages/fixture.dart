import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/game.dart';


class Fixture extends StatefulWidget {
  const Fixture({Key? key}) : super(key: key);

  @override
  State<Fixture> createState() => _FixtureState();
}

class _FixtureState extends State<Fixture> {
  Future<List<Game>> getFixture() async {
    List<Game> games = [];
    print('get fixture');
    var response = await http.get(
        Uri.parse('http://10.0.2.2:8000/partidos'));
    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body)["partidos"];
      body.forEach(
          (game) => {
            games.add(Game(id: game.id, titulo: game.titulo, torneo: game.torneo,categoria: game.categoria,equipoA: game.equipoA,equipoB: game.equipoB,arbitro1: game.arbitro1,arbitro2: game.arbitro2,mesa1: game.mesa1,mesa2: game.mesa2,sede: game.sede,fecha: game.fecha,jornada: game.jornada,resultado: game.resultado))
          }
      );
      return games;
    }else {
      print(response.statusCode);
      throw Exception("Unable to retrieve games");
    }


  }
  void search(){
    setState(() {
      getFixture();
    });
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: getFixture(),
      builder: (BuildContext context, AsyncSnapshot<List<Game>> snapshot) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Expanded(child: ListView(
                children: snapshot.data != null? snapshot.data?.map((game)=>GameWidget(game: game)).toList() ?? []: [],
              ))]

        ),);
      },

    );
  }
}
