// import 'dart:async';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:restaurant_map/BLoC/bloc_provider.dart';
// import 'package:restaurant_map/UI/screen/MainSearch_screen.dart';
import 'package:restaurant_map/UI/screen/SearchLocations_screen.dart';
import 'package:restaurant_map/UI/widget/containerWidget/NearByContainer.dart';
import 'package:restaurant_map/domains/location/BLoC/location_bloc.dart';
import 'package:restaurant_map/domains/location/model/location_model.dart';
// import 'package:restaurant_map/domains/restaurant/BLoC/restaurant_bloc.dart';

class NearbyRestaurants extends StatelessWidget {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Restaurant Nearby'),
          actions: <Widget>[
            IconButton(
                icon: Icon(FontAwesomeIcons.search),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                      SearchLocationScreen.routeName,
                      arguments: _controller);
                })
          ],
        ),
        body: StreamBuilder<Location>(
            stream: BlocProvider.of<LocationBloc>(context).locationStream,
            builder: (context, snapshot) {
              final location = snapshot.data;
              if (location == null) {
                return FutureBuilder<Location>(
                  future:
                      BlocProvider.of<LocationBloc>(context).getAsyncLocation,
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return NearByContainer(_controller, location, context);
                    }
                  },
                );
              }
              return NearByContainer(_controller, location, context);
            }));
  }
}
