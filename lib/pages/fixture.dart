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
    var response = await http.get(
        Uri.parse('http://10.0.2.2:8000/partidos'));
    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body)["partidos"];
      return (body as List<dynamic>).map((g)=>Game.fromJson(g as Map<String, dynamic>)).toList();
    }else {
      print(response.statusCode);
      throw Exception("Unable to retrieve games");
    }
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
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: ListView(
                      children: snapshot.data!.map((game) => GameWidget(game: game)).toList()
                    )
                ),
              ]
        ),);
      }
    );
  }
}
