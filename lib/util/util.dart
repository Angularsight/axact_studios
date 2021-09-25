

import 'package:flutter/material.dart';

class Util{

  static Color getColor(int index){
    var colorList = [
      Colors.lightBlueAccent.shade200,
      Colors.lightGreen.shade200,
      Colors.orangeAccent.shade200,
      Colors.redAccent.shade200,
      Colors.limeAccent.shade200,
      Colors.lightBlueAccent.shade200,
      Colors.lightGreen.shade200,
      Colors.orangeAccent.shade200,
      Colors.redAccent.shade200,
      Colors.limeAccent.shade200,
      Colors.lightBlueAccent.shade200,
      Colors.lightGreen.shade200,
    ];
    // colorList.shuffle();
    return colorList[index];
  }

}