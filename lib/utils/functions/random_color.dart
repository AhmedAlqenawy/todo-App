
import 'dart:math';
import 'package:flutter/material.dart';
final random=Random();
Color? getRandomColor(){
  return Colors.primaries[Random().nextInt(Colors.primaries.length)]
  [(Random().nextInt(8)+1) * 100];
  /*Color.fromARGB(random.nextInt(256), random.nextInt(256),
      random.nextInt(256), random.nextInt(256));*/
}