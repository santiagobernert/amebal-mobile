import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/announces.dart';

import '../widgets/game.dart';
import 'package:amebal/widgets/filters.dart';


class Fixture extends StatefulWidget {
  const Fixture({Key? key}) : super(key: key);

  @override
  State<Fixture> createState() => _FixtureState();
}

class _FixtureState extends State<Fixture> {
  String torneo = "Todos";
  String categoria = "Todos";
  String sexo = "Todos";
  Future<List<Game>> getFixture() async {
    var response = await http.get(
        Uri.parse('http://10.0.2.2:8000/partidos?categoria=$categoria&sexo=$sexo&torneo=$torneo'));
    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body)["partidos"];
      return (body as List<dynamic>).map((g)=>Game.fromJson(g as Map<String, dynamic>)).toList();
    }else {
      print(response.statusCode);
      throw Exception("Unable to retrieve games");
    }
  }

  void filters(_torneo, _categoria, _sexo){
    print(torneo+ categoria+sexo);
    setState(() {
      torneo = _torneo;
      categoria = _categoria;
      sexo = _sexo;
    });
    print(torneo+ categoria+sexo);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Game>>(
      future: getFixture(),
      builder: (context, snapshot) {
        if (snapshot.data == null){
          return const Padding(
            padding: EdgeInsets.all(200.0),
            child: CircularProgressIndicator(),
          );
        }
        return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20,),
                const Text("Fixture", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                Filters(filters),
                Expanded(
                    child: ListView(
                      children: announceMap(snapshot.data!.map((game) => Container(child: GameWidget(game: game))).toList())
                    )
                ),
              ]
        );
      }
    );
  }
}
