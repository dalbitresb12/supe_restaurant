import 'dart:convert';

import 'package:http/http.dart';
import 'package:supe_restaurants/models/restaurant_model.dart';
import 'package:supe_restaurants/models/user_model.dart';

class InvalidLoginException implements Exception {
  static const _cause = 'Invalid username or password';

  String cause = _cause;
}

class SupeClient {
  final Client _client;
  final String _endpoint;

  SupeClient({
    Client? client,
    String? endpoint,
  })  : _client = client ?? Client(),
        _endpoint = endpoint ?? 'probable-knowledgeable-zoo.glitch.me';

  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    final params = {
      'username': username,
      'password': password,
    };
    final url = Uri.https(_endpoint, '/users', params);
    final response = await _client.get(url);
    final decoded = jsonDecode(utf8.decode(response.bodyBytes)) as List;
    if (decoded.length != 1) throw InvalidLoginException();
    return UserModel.fromJson(decoded[0]);
  }

  Future<UserModel> register({
    required String username,
    required String firstName,
    required String lastName,
    required String password,
  }) async {
    final body = {
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'password': password,
    };
    final encoded = jsonEncode(body);
    final url = Uri.https(_endpoint, '/users');
    final response = await _client.post(
      url,
      body: encoded,
      headers: {'content-type': 'application/json'},
    );
    final decoded =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    return UserModel.fromJson(decoded);
  }

  Future<List<RestaurantModel>> getAllRestaurants() async {
    final url = Uri.https(_endpoint, '/restaurants');
    final response = await _client.get(url);
    final decoded = jsonDecode(utf8.decode(response.bodyBytes)) as List;
    return decoded.map((e) => RestaurantModel.fromJson(e)).toList();
  }
}
