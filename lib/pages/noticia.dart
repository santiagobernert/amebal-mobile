import 'package:flutter/material.dart';

class Noticia extends StatelessWidget {
  final bool principal;
  final String titulo;
  const Noticia({Key? key, this.principal=false, required this.titulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: principal? double.infinity : 120,
      color: Colors.amberAccent,
      height: principal? 100 : 50,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      alignment: const Alignment(1, 0),
      child: Text(titulo),
    );
  }
}
