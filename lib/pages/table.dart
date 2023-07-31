import 'package:amebal/widgets/filters.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class PosTable{
  int team;
  int games_played;
  int wins;
  int losses;
  int draws;
  int goals_for;
  int goals_against;
  int goal_difference;
  int points;
  PosTable(this.team,
  this.games_played,
  this.wins,
  this.losses,
  this.draws,
  this.goals_for,
  this.goals_against,
  this.goal_difference,
  this.points,);

  factory PosTable.fromJson(Map<String, dynamic> json) {
     return PosTable(
       json["Equipo"],
        json["J"],
        json["G"],
        json["P"],
        json["E"],
        json["GF"],
        json["GC"],
        json["DG"],
        json["PTS"],
      );
    }

  static Future<String> getTeamName(int teamNumber) async {
    var response = await http.get(
        Uri.parse('http://10.0.2.2:8000/equipo?num=$teamNumber'));
    if (response.statusCode == 200) {
      dynamic equipo = jsonDecode(response.body)["equipo"];
      var clubfetch = await http.get(
        Uri.parse('http://10.0.2.2:8000/club?nombre=${equipo["club"]}')
      );
      if (clubfetch.statusCode == 200){
        dynamic club = jsonDecode(clubfetch.body)["club"];
        return club["abreviatura"];
      }
      else {
        print(clubfetch.statusCode);
        return "team";
      }
    } else {
      print(response.statusCode);
      return "team";
    }
  }
}

class PositionsTable extends StatefulWidget {
  const PositionsTable({Key? key}) : super(key: key);

  @override
  State<PositionsTable> createState() => _PositionsTableState();
}

class _PositionsTableState extends State<PositionsTable> {
  late Future<List> table;
  String torneo = "Global Handball Showdown 2026";
  String categoria = "Menor";
  String sexo = "Masculino";
  Future<List> getTable() async {
    var response = await http.get(
        Uri.parse('http://10.0.2.2:8000/posiciones?categoria=$categoria&sexo=$sexo&torneo=$torneo'));
    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body)["tabla"];
      print(torneo+ categoria+sexo);
      return(body as List<dynamic>).map((t)=>PosTable.fromJson(t as Map<String, dynamic>)).toList();
    } else {
      print(response.statusCode);
      print(response.body);
      throw Exception("Unable to retrieve table");
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
    return FutureBuilder<List>(
      future: getTable(),
      builder: (context, snapshot) {
        if (snapshot.hasError){
          return Column(
            children: [
              const SizedBox(height: 20,),
              const Text("Tabla de Posiciones", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),
              Container(width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(border: Border.all(width: 2)),
                  child: const Text("Anuncio")),
              Filters(filters),
              const SizedBox(height: 20,),
              Text("Error: ${snapshot.error}"),
              Container(width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(border: Border.all(width: 2)),
                  child: const Text("Anuncio")),
            ],
          );
        }
        if (snapshot.data == null){
          return const CircularProgressIndicator();
        }
        return Column(
          children: [
            const SizedBox(height: 20,),
            const Text("Tabla de Posiciones", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            const SizedBox(height: 20,),
            Container(width: double.infinity,
                height: 50,
                decoration: BoxDecoration(border: Border.all(width: 2)),
                child: const Text("Anuncio")),
            Filters(filters),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
              decoration: const BoxDecoration(color: Color(0xFF0A4B8F)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text("Equipo", style: TextStyle(color: Colors.white),),
                  Text("J", style: TextStyle(color: Colors.white),),
                  Text("G", style: TextStyle(color: Colors.white),),
                  Text("P", style: TextStyle(color: Colors.white),),
                  Text("E", style: TextStyle(color: Colors.white),),
                  Text("GF", style: TextStyle(color: Colors.white),),
                  Text("GC", style: TextStyle(color: Colors.white),),
                  Text("DG", style: TextStyle(color: Colors.white),),
                  Text("PTS", style: TextStyle(color: Colors.white),),],
              ),
            ),
            Table(
              columnWidths: const {
                0: FlexColumnWidth(1.7),
                1: FlexColumnWidth(0.7),
                2: FlexColumnWidth(0.7),
                3: FlexColumnWidth(0.7),
                4: FlexColumnWidth(0.7),
                5: FlexColumnWidth(1),
                6: FlexColumnWidth(1),
                7: FlexColumnWidth(1),
                8: FlexColumnWidth(1),
              },
              children: snapshot.data!.map((data) => TableRow(
                children: [
                  FutureBuilder<String>(
                    future: PosTable.getTeamName(data.team),
                    builder: (context, snapshot) {
                      return Container(
                          height: 50,
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                          alignment: Alignment.center,
                          child: Text(snapshot.data!));
                    }
                  ),
                  Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text("${data.games_played}")),
                  Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text("${data.wins}")),
                  Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text("${data.losses}")),
                  Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text("${data.draws}")),
                  Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text("${data.goals_for}")),
                  Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text("${data.goals_against}")),
                  Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text("${data.goal_difference}")),
                  Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                      alignment: Alignment.center,
                      child: Text("${data.points}")),
                ],
              )).toList(),
            ),
            Container(width: double.infinity,
                height: 50,
                decoration: BoxDecoration(border: Border.all(width: 2)),
                child: const Text("Anuncio")),
          ],
        );
      }
    );
  }
}
