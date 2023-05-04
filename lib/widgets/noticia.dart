import 'package:flutter/material.dart';

class Noticia extends StatelessWidget {
  final bool principal;
  final String titulo;
  const Noticia({Key? key, this.principal=false, required this.titulo}) : super(key: key);

  void click(){

  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: principal? double.infinity : MediaQuery.of(context).size.width * 0.42,
        color: Colors.amberAccent,
        height: principal? 170 : 120,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        alignment: Alignment.bottomLeft,
        child: Text(titulo),
      );
  }
}
