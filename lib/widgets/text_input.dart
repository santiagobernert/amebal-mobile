import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final Function callback;
  const TextInput(this.callback, {super.key});

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  final controller = TextEditingController();

  void post(){
    FocusScope.of(context).unfocus();
    widget.callback(controller.text);
    controller.clear();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: "Buscar...",
        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        labelStyle: TextStyle(color: Theme.of(context).inputDecorationTheme.labelStyle?.color,),
        border: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 0),
        ),
        suffixIcon: IconButton(
          onPressed: post,
          tooltip: 'Buscar',
          icon: Icon(Icons.search, color: Theme.of(context).inputDecorationTheme.iconColor,),
        )));
  }
}
