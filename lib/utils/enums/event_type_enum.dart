import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/string_const.dart';

enum EventType {
  all(title: StringConst.all, iconData: FontAwesomeIcons.ticket),
  party(title: StringConst.party, iconData: FontAwesomeIcons.champagneGlasses),
  concert(title: StringConst.concert, iconData: FontAwesomeIcons.music),
  movie(title: StringConst.movie, iconData: FontAwesomeIcons.film),
  food(title: StringConst.food, iconData: FontAwesomeIcons.utensils),
  comedy(title: StringConst.comedy, iconData: FontAwesomeIcons.faceLaugh);

  final String title;
  final IconData iconData;

  const EventType({
    required this.title,
    required this.iconData,
  });
}
