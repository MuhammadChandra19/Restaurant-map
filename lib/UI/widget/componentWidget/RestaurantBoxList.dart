import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:restaurant_map/UI/widget/componentWidget/RestaurantBox.dart';
import 'package:restaurant_map/domains/restaurant/model/restaurant_model.dart';

class RestaurantBoxList extends StatelessWidget {
  final Completer<GoogleMapController> controller;
  final ScrollController scrollController;
  final List<Restaurant> restaurants;

  RestaurantBoxList(this.controller, this.scrollController, this.restaurants);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: restaurants == null
            ? null
            : ListView.separated(
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  width: 20.0,
                ),
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: restaurants.length,
                itemBuilder: (ctx, i) => RestaurantBox(
                  controller: controller,
                  image: restaurants[i].imageUrl,
                  lat: restaurants[i].latitude,
                  long: restaurants[i].longtitude,
                  restaurant: restaurants[i],
                ),
              ),
      ),
    );
  }
}
