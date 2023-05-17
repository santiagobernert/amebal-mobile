import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Fixture extends StatefulWidget {
  const Fixture({Key? key}) : super(key: key);

  @override
  State<Fixture> createState() => _FixtureState();
}

class _FixtureState extends State<Fixture> {
  void getFixture() async {
    print('get fixture');
    var response = await http.get(
        Uri.parse('http://10.0.2.2:8000/partidos'));
    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body)["partidos"];

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
    getFixture();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [],
      ),
    );
  }
}
