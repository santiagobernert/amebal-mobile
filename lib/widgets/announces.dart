import "package:flutter/material.dart";

//function that adds 1 Announce Widget every 4 elements of a list
List<Widget> announceMap({list, int separation=4}){
    List<int> numbers = [for(var i=0; i<list.length; i+=separation) i];
    for (var i in numbers) {
        list.insert(i, Container(width: double.infinity,
            height: 50,
            decoration: BoxDecoration(border: Border.all(width: 2)),
            child: const Text("Anuncio")));
    }
    return list;
}


