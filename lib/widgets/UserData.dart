import 'package:flutter/material.dart';

class UserData extends StatelessWidget {
  IconData icon;
  String fieldName;
  String data;

  UserData(this.icon, this.fieldName, this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Color(0xff00448d),
            borderRadius: BorderRadius.horizontal(left: Radius.circular(10))
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icon!=Icons.add?Icon(icon, color: Colors.white,):const SizedBox(width: 5, height: 25,),
                Text(
                  "${fieldName.substring(0, 1).toUpperCase()}${fieldName.substring(1)}", style: const TextStyle(color: Colors.white, fontSize: 10),)
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(data),
        )
      ],
    );
  }
}
