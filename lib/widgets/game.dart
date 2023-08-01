import 'package:flutter/material.dart';

class Game{
  final int id;
  final String titulo;
  final String torneo;
  final String categoria;
  final int equipoA;
  final int equipoB;
  final int arbitro1;
  final int arbitro2;
  final int mesa1;
  final int mesa2;
  final String sede;
  final String fecha;
  final String jornada;
  final String resultado;
  Game(
      {required this.id,
      required this.titulo,
      required this.torneo,
      required this.categoria,
      required this.equipoA,
      required this.equipoB,
      required this.arbitro1,
      required this.arbitro2,
      required this.mesa1,
      required this.mesa2,
      required this.sede,
      required this.fecha,
      required this.jornada,
      required this.resultado});

  factory Game.fromJson(Map<String, dynamic> json){
    return Game(
      id: json["id"],
      titulo: json["titulo"],
      torneo: json['torneo'],
      categoria: json['categoria'],
      equipoA: json['equipoA'],
      equipoB: json['equipoB'],
      arbitro1: json['arbitro1'],
      arbitro2: json['arbitro2'],
      mesa1: json['mesa1'],
      mesa2: json['mesa2'],
      sede: json['sede'],
      fecha: json['fecha'],
      jornada: json['jornada'],
      resultado: json['resultado'],
    );
  }
  Map<String, dynamic> toJson() => {
    'id' : id,
    'titulo' :titulo,
    'torneo' : torneo,
    'categoria' : categoria,
    'equipoA' : equipoA,
    'equipoB' : equipoB,
    'arbitro1' : arbitro1,
    'arbitro2' : arbitro2,
    'mesa1' : mesa2,
    'mesa2' : mesa2,
    'sede' : sede,
    'fecha' : fecha,
    'jornada' : jornada,
    'resultado' : resultado
  };
}

class GameWidget extends StatelessWidget {
  Game game;
  GameWidget({super.key, required this.game});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      height: 170,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                      color: Color(0xFF0A4B8F),
                    ),
                    alignment: Alignment.center,
                    child: Text(game.torneo, style: const TextStyle(color: Colors.white, ),)),
              ),
            ],
          ),
          Text(game.fecha),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.sports_baseball_outlined, size: 60.0,),
              Text(game.resultado),
              const Icon(Icons.shield_moon_outlined, size: 60.0,),
            ],
          ),
          Text(game.titulo),
        ],
      ),
    );
  }
}