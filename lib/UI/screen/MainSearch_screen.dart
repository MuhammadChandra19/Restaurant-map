import 'package:flutter/material.dart';
import 'package:restaurant_map/BLoC/bloc_provider.dart';
import 'package:restaurant_map/UI/screen/SearchLocations_screen.dart';
import 'package:restaurant_map/UI/screen/SearchRestaurants_screen.dart';
import 'package:restaurant_map/domains/location/BLoC/location_bloc.dart';
import 'package:restaurant_map/domains/location/model/location_model.dart';

class MainSearch extends StatelessWidget {
  static const routeName = '/search';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Location>(
      stream: BlocProvider.of<LocationBloc>(context).locationStream,
      builder: (context, snapshot) {
        final location = snapshot.data;

        if (location == null) {
          return SearchLocationScreen();
        }

        return SearchRestaurantScreen(location: location);
      },
    );
  }
}
