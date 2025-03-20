import 'package:flutter/material.dart';

enum ColorSeed {
  deepPurple(Colors.deepPurple),
  indigo(Colors.indigo),
  blue(Colors.blue),
  teal(Colors.teal),
  green(Colors.green),
  yellow(Colors.yellow),
  orange(Colors.orange),
  deepOrange(Colors.deepOrange),
  pink(Colors.pink);

  const ColorSeed(this.color);

  final Color color;
}
