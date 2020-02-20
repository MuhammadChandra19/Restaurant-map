import 'dart:async';

import 'package:restaurant_map/BLoC/bloc.dart';
import 'package:restaurant_map/domains/location/httpClient/location_http.dart';
import 'package:restaurant_map/domains/location/model/location_model.dart';

class LocationQueryBloc implements Bloc {
  final _controller = StreamController<List<Location>>();
  final _client = LocationHttp();
  Stream<List<Location>> get locationStream => _controller.stream;

  void submitQuery(String query) async {
    final results = await _client.fetchLocations(query);
    _controller.sink.add(results);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
