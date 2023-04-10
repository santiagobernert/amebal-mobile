import 'package:flutter/material.dart';

class Noticia extends StatelessWidget {
  final bool principal;
  final String titulo;
  const Noticia({Key? key, this.principal=false, required this.titulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: principal? double.infinity : MediaQuery.of(context).size.width * 0.41,
      color: Colors.amberAccent,
      height: principal? 150 : 100,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      alignment: const Alignment(0, 0),
      child: Text(titulo),
    );
  }
}
