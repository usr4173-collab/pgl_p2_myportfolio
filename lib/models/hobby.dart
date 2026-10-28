import 'package:flutter/material.dart';

/// A hobby: its name, the icon that represents it and the icon color.
class Hobby {
  final String name;
  final IconData icon;
  final Color color;

  const Hobby({required this.name, required this.icon, required this.color});
}
