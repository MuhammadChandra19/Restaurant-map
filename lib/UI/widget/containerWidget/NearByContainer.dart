import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:restaurant_map/UI/widget/componentWidget/RestaurantBoxList.dart';
import 'package:restaurant_map/UI/widget/componentWidget/GoogleMapWidget.dart';
import 'package:restaurant_map/domains/location/model/location_model.dart';
import 'package:restaurant_map/domains/restaurant/BLoC/restaurant_bloc.dart';
import 'package:restaurant_map/domains/restaurant/model/restaurant_model.dart';

class NearByContainer extends StatelessWidget {
  final Completer<GoogleMapController> controller;
  final Location location;
  final BuildContext context;

  NearByContainer(this.controller, this.location, this.context);

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext ctx) {
    final bloc = RestaurantBloc(location);
    bloc.submitQuery(location.cityName);
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder<List<Restaurant>>(
        stream: bloc.stream,
        builder: (context, snapshot) {
          final results = snapshot.data;

          return Stack(
            children: <Widget>[
              GoogleMapWidget(context, controller, _scrollController, width,
                  location, results),
              RestaurantBoxList(controller, _scrollController, results),
            ],
          );
        });
  }
}
