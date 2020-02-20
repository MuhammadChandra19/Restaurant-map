import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StartRating extends StatelessWidget {
  final double value;
  const StartRating(this.value);

  @override
  Widget build(BuildContext context) {
    bool hasDecimal = (value % 1) != 0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        if (i < value.toInt()) {
          return Icon(
            FontAwesomeIcons.solidStar,
            color: Colors.amber,
            size: 15.0,
          );
        } else if (hasDecimal) {
          return Icon(
            FontAwesomeIcons.solidStarHalf,
            color: Colors.amber,
            size: 15.0,
          );
        }
        return Icon(Icons.star_border);
      }),
    );
  }
}
