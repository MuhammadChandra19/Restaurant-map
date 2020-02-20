import 'dart:async';
import 'dart:convert' show json;

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class BaseApi {
  final _apiKey = 'b117c1327dd3d43f5e1efb265c1d25cb';
  final _host = 'developers.zomato.com';
  final _contextRoot = 'api/v2.1';

  Map<String, String> get _headers =>
      {'Accept': 'application/json', 'user-key': _apiKey};

  Future<Map> request(
      {@required String path, Map<String, String> parameters}) async {
    parameters.removeWhere((String k, dynamic v) => v == '' || v == null);

    final uri = Uri.https(_host, '$_contextRoot/$path', parameters);

    final result = await http.get(uri, headers: _headers);
    final jsonObject = json.decode(result.body);
    return jsonObject;
  }
}
