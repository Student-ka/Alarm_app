import 'package:flutter/material.dart';

class Alarm {
  TimeOfDay time;
  String label;
  bool isEnabled;

  Alarm({required this.time, required this.label, this.isEnabled = true});
}
