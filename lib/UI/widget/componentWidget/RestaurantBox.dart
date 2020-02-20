import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:restaurant_map/domains/restaurant/model/restaurant_model.dart';
import './RestaurantDetailBox.dart';

class RestaurantBox extends StatelessWidget {
  final String image;
  final double lat;
  final double long;
  final Restaurant restaurant;
  final Completer<GoogleMapController> controller;
  final Function executeScroll;

  RestaurantBox(
      {this.image,
      this.lat,
      this.long,
      this.restaurant,
      this.controller,
      this.executeScroll});

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController ctrl = await controller.future;
    ctrl.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _gotoLocation(lat, long);
        // print(lat);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: new FittedBox(
            child: Material(
                color: Colors.white,
                elevation: 14.0,
                borderRadius: BorderRadius.circular(24.0),
                shadowColor: Color(0x802196F3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 180,
                      height: 200,
                      child: ClipRRect(
                        borderRadius: new BorderRadius.circular(24.0),
                        child: FadeInImage(
                          placeholder:
                              AssetImage('assets/images/placeholder.png'),
                          image: NetworkImage(image),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RestaurantDetailBox(restaurant),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
