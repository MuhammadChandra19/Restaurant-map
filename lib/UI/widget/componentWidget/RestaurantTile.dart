import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restaurant_map/UI/widget/componentWidget/ImageViewerBox.dart';
import 'package:restaurant_map/domains/restaurant/model/restaurant_model.dart';

class RestaurantTile extends StatelessWidget {
  const RestaurantTile({
    Key key,
    @required this.restaurant,
  }) : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ImageViewerBox(width: 50, height: 50, url: restaurant.thumbUrl),
      title: Text(restaurant.name),
      trailing: Icon(FontAwesomeIcons.arrowCircleRight),
      onTap: () {},
    );
  }
}
