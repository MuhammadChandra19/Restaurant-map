import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:restaurant_map/domains/location/BLoC/location_bloc.dart';
import 'package:restaurant_map/domains/location/model/location_model.dart';
import 'package:restaurant_map/domains/restaurant/model/restaurant_model.dart';

class GoogleMapWidget extends StatelessWidget {
  final BuildContext context;
  final Completer<GoogleMapController> controller;
  final ScrollController scrollController;
  final double deviceWidth;
  final Location location;
  final List<Restaurant> restaurant;

  GoogleMapWidget(this.context, this.controller, this.scrollController,
      this.deviceWidth, this.location, this.restaurant);

  _animateToIndex(i) => scrollController.animateTo(200.0 * i,
      duration: Duration(seconds: 2), curve: Curves.fastOutSlowIn);

  @override
  Widget build(ctx) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
              target: LatLng(location.latitude, location.longtitude), zoom: 15),
          onMapCreated: (GoogleMapController ctrl) {
            controller.complete(ctrl);
          },
          markers: this.restaurant != null
              ? {
                  ...restaurant
                      .map((item) => Marker(
                          onTap: () {
                            _animateToIndex(restaurant.indexOf(item) + 1);
                            print(200.0 * restaurant.indexOf(item));
                          },
                          markerId: MarkerId(item.name),
                          position: LatLng(item.latitude, item.longtitude),
                          infoWindow: InfoWindow(title: item.name),
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueViolet,
                          )))
                      .toList()
                }
              : null,
        ));
  }
}
