import 'package:flutter/material.dart';

class Game{
  int id = 0;
  String titulo = "";
  String torneo = "";
  String categoria = "";
  int equipoA = 0;
  int equipoB = 0;
  int arbitro1 = 0;
  int arbitro2 = 0;
  int mesa1 = 0;
  int mesa2 = 0;
  String sede = "";
  String fecha = "";
  String jornada = "";
  String resultado = "";
  Game({id, titulo, torneo, categoria, equipoA, equipoB, arbitro1, arbitro2, mesa1, mesa2, sede, fecha, jornada, resultado});

  factory Game.fromJson(Map<String, dynamic> json){
    return Game(
      id : json['id'],
      titulo : json['titulo'],
      torneo : json['torneo'],
      categoria : json['categoria'],
      equipoA : json['equipoA'],
      equipoB : json['equipoB'],
      arbitro1 : json['arbitro1'],
      arbitro2 : json['arbitro2'],
      mesa1 : json['mesa1'],
      mesa2 : json['mesa2'],
      sede : json['sede'],
      fecha : json['fecha'],
      jornada : json['jornada'],
      resultado : json['resultado'],
    );
  }
}

class GameWidget extends StatelessWidget {
  String id;
  String titulo;
  String torneo;
  String categoria;
  String equipoA;
  String equipoB;
  String arbitro1;
  String arbitro2;
  String mesa1;
  String mesa2;
  String sede;
  String fecha;
  String jornada;
  String resultado;
  GameWidget({super.key, required this.id, required this.titulo, required this.torneo, required this.categoria, required this.equipoA, required this.equipoB,
   required this.arbitro1, required this.arbitro2, required this.mesa1, required this.mesa2,
   required this.sede, required this.fecha, required this.jornada, required this.resultado});
  @override
  Widget build(BuildContext context) {
    Game game = Game(id: id, titulo: titulo, torneo: torneo, categoria: categoria, equipoA: equipoA, equipoB: equipoB, arbitro1: arbitro1, arbitro2: arbitro2, mesa1: mesa1, mesa2: mesa2, sede: sede, fecha: fecha, jornada: jornada, resultado: resultado,) ;
    return Container(
      width: double.infinity,
      color: Colors.white,
      height: 170,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Container(color: Colors.indigo, child: Text(game.torneo),))
        ],
      ),
    );
  }
}