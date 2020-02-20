import 'package:flutter/material.dart';
import 'package:restaurant_map/BLoC/bloc_provider.dart';
import 'package:restaurant_map/UI/screen/MainSearch_screen.dart';
import 'package:restaurant_map/UI/screen/NearbyRestaurants_screen.dart';
import 'package:restaurant_map/UI/screen/SearchLocations_screen.dart';
import 'package:restaurant_map/domains/location/BLoC/location_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocationBloc>(
      bloc: LocationBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter GoogleMaps Demo',
        theme: ThemeData(
          primaryColor: Color(0xff6200ee),
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (ctx) => NearbyRestaurants(),
          SearchLocationScreen.routeName: (ctx) => SearchLocationScreen()
        },
      ),
    );
  }
}
