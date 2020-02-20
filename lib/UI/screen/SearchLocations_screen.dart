import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:restaurant_map/BLoC/bloc_provider.dart';
import 'package:restaurant_map/domains/location/BLoC/location_bloc.dart';
import 'package:restaurant_map/domains/location/BLoC/location_query_bloc.dart';
import 'package:restaurant_map/domains/location/model/location_model.dart';

class SearchLocationScreen extends StatelessWidget {
  static const routeName = '/changeLocation';
  final bool isFullScreenDialog;
  // final Completer<GoogleMapController> controller;

  const SearchLocationScreen({Key key, this.isFullScreenDialog = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> controller =
        ModalRoute.of(context).settings.arguments;
    final bloc = LocationQueryBloc();
    return BlocProvider<LocationQueryBloc>(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(title: Text('Where do you want to eat?')),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter a location'),
                onChanged: (query) {
                  bloc.submitQuery(query);
                },
              ),
            ),
            Expanded(
              child: _buildResults(bloc, controller),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildResults(
      LocationQueryBloc bloc, Completer<GoogleMapController> controller) {
    return StreamBuilder<List<Location>>(
      stream: bloc.locationStream,
      builder: (context, snapshot) {
        // 1
        final results = snapshot.data;

        if (results == null) {
          return Center(child: Text('Enter a location'));
        }

        if (results.isEmpty) {
          return Center(child: Text('No Results'));
        }

        return _buildSearchResults(results, controller);
      },
    );
  }

  Widget _buildSearchResults(
      List<Location> results, Completer<GoogleMapController> controller) {
    // 2

    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (context, index) {
        final location = results[index];
        return ListTile(
          title: Text(location.title),
          onTap: () async {
            print('kepencet');
            print(DateTime.now());
            final locationBloc = BlocProvider.of<LocationBloc>(context);
            final GoogleMapController ctrl = await controller.future;
            ctrl
                .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
              target: LatLng(location.latitude, location.longtitude),
              zoom: 15,
              tilt: 50.0,
              bearing: 45.0,
            )))
                .then((_) {
              print('ganti loklasi duluan');
              print(DateTime.now());
              locationBloc.selectLocation(location);
              locationBloc.setSaveChangeLocation(false);
              Navigator.of(context).pop();
            });
          },
        );
      },
    );
  }
}
