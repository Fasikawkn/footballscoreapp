import 'dart:io';

import 'package:footballscoreapp/src/constants/api_endpoints.dart';
import 'package:footballscoreapp/src/services/API/exceptions.dart';
import 'package:footballscoreapp/src/services/API/response.dart';
import 'package:http/http.dart' as http;

class CountryDataProvider {
  final http.Client httpClient;

  CountryDataProvider({required this.httpClient});

  // get all countries
  Future<dynamic> getAllCountries() async {
    late dynamic _jsonResponse;
    try {
      final _response = await httpClient.get(
        Uri.parse(baseUrl + countriesEndpoint),
        headers: {
          'X-RapidAPI-Host': rapidApiHost,
          'X-RapidAPI-Key': rapidApiKey,
        },
      );

      _jsonResponse = returnResponse(_response);
    } on SocketException catch (e) {
      throw FetchDataException('No Internet Connetion');
    }
    return _jsonResponse;
  }
}
