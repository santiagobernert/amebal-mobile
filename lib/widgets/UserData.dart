import 'package:flutter/material.dart';

class UserData extends StatelessWidget {
  IconData icon;
  String fieldName;
  String data;

  UserData(this.icon, this.fieldName, this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
                "${fieldName.substring(0, 1).toUpperCase()}${fieldName.substring(1)}",
            style: const TextStyle(color: Color(0xFF0A4B8F), fontSize: 12,)),
          Text(data, style: const TextStyle(fontSize: 16),)
        ],
      ),
    );
  }
}
