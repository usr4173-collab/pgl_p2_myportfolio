import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../models/hobby.dart';

/// List of hobbies shown in the "Hobbies" tab.
const List<Hobby> hobbies = [
  Hobby(name: 'Tocar la guitarra', icon: Icons.music_note, color: AppColors.primary),
  Hobby(name: 'Escuchar música', icon: Icons.headphones, color: AppColors.info),
  Hobby(name: 'Jugar a videojuegos', icon: Icons.sports_esports, color: AppColors.success),
  Hobby(name: 'Leer cómics', icon: Icons.menu_book, color: Colors.deepOrange),
  Hobby(name: 'Explorar el mundo', icon: Icons.explore, color: AppColors.success),
  Hobby(name: 'Cuidar de mis amigos', icon: Icons.groups, color: AppColors.primary),
  Hobby(name: 'Aprender de Joel', icon: Icons.school, color: AppColors.warning),
  Hobby(name: 'Estar con Riley', icon: Icons.favorite, color: AppColors.error),
  Hobby(name: 'Silbar', icon: Icons.record_voice_over, color: AppColors.info),
];
