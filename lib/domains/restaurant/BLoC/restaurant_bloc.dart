import 'dart:async';

import 'package:restaurant_map/BLoC/bloc.dart';
import 'package:restaurant_map/domains/location/model/location_model.dart';
import 'package:restaurant_map/domains/restaurant/httpClient/restaurant_http.dart';
import 'package:restaurant_map/domains/restaurant/model/restaurant_model.dart';

class RestaurantBloc implements Bloc {
  final Location location;
  final _client = RestaurantHttp();
  final _controller = StreamController<List<Restaurant>>();

  Stream<List<Restaurant>> get stream => _controller.stream;
  RestaurantBloc(this.location);

  Future<void> submitQuery(String query, [bool withCoordinate = false]) async {
    final results =
        await _client.fetchRestaurants(location, query, withCoordinate);
    _controller.sink.add(results);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
