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
  List games = [];

  void getFixture() async {
    print('get fixture');
    var response = await http.get(
        Uri.parse('http://10.0.2.2:8000/partidos'));
    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body)["partidos"];
      print(body);
      games = (body as List<dynamic>).map((g) =>
          Game.fromJson(g as Map<String, dynamic>)).toList();
    } else {
      print(response.statusCode);
      throw Exception("Unable to retrieve games");
    }
  }

  void search() {
    setState(() {
      getFixture();
    });
  }

  void filter(String enteredKeyword) {
    List<dynamic>? results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = games;
    } else {
      results = games
          .where((game) =>
          game["titulo"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      games = results!;
    });
  }

    @override
    Widget build(BuildContext context) {
      getFixture();
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<String>(
                items: <String>['Año', 'B', 'C', 'D'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
              DropdownButton<String>(
                items: <String>['Categoria', 'B', 'C', 'D'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
              DropdownButton<String>(
                items: <String>['Masculino', 'Femenino'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
              TextField(
                onChanged: (value) => filter(value),
                decoration: const InputDecoration(
                    labelText: 'Search', suffixIcon: Icon(Icons.search)),
              ),
              Expanded(
                  child: ListView(
                      children: games.map((game) => GameWidget(game: game))
                          .toList()
                  )
              ),
              OutlinedButton(onPressed: search, child: const Text('get'))
            ]
        ),);
    }
  }

