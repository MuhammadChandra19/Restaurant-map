import 'package:flutter/material.dart';

import 'package:restaurant_map/UI/widget/componentWidget/StarRating.dart';
import 'package:restaurant_map/domains/restaurant/model/restaurant_model.dart';

class RestaurantDetailBox extends StatelessWidget {
  final Restaurant restaurant;
  RestaurantDetailBox(this.restaurant);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            restaurant.name,
            style: TextStyle(
                color: Color(0xff6200ee),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        SizedBox(height: 5.0),
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
                child: Text(
              restaurant.rating.average,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
            StartRating(double.parse(restaurant.rating.average)),
            Container(
                child: Text(
              restaurant.rating.votes,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
          ],
        )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
          restaurant.cuisines,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        )),
        SizedBox(height: 5.0),
        // Container(
        //     child: Text(
        //   restaurant.timings,
        //   style: TextStyle(
        //       color: Colors.black54,
        //       fontSize: 18.0,
        //       fontWeight: FontWeight.bold),
        // )),
      ],
    );
  }
}
