import 'dart:io';

import 'package:footballscoreapp/src/constants/api_endpoints.dart';
import 'package:footballscoreapp/src/services/API/exceptions.dart';
import 'package:footballscoreapp/src/services/API/response.dart';
import 'package:http/http.dart' as http;

class LeaguesDataProvider {
  final http.Client httpClient;
  LeaguesDataProvider({
    required this.httpClient,
  });

  // Get all leagues data -> names, season, id...

  Future<dynamic> getAllLeaguesData() async {
    late dynamic _apiResponse;
    try {
      final _jsonResponse = await httpClient
          .get(Uri.parse(baseUrl + getLeaguesEndpoint), headers: {
        'X-RapidAPI-Host': rapidApiHost,
        'X-RapidAPI-Key': rapidApiKey,
      });

      _apiResponse = returnResponse(_jsonResponse);
    } on SocketException catch (e) {
      throw FetchDataException('No Internet Connection');
    }

    return _apiResponse;
  }

  Future<dynamic> getLeagueByCountryName(String name) async {
    late dynamic _jsonResponse;
    try {
      final _queryParameter = {'country': name.toString()};
      var queryString = Uri(queryParameters: _queryParameter).query;
      var _url = baseUrl + getLeaguesEndpoint + '?' + queryString;
      final _response = await httpClient.get(
        Uri.parse(
          _url,
        ),
        headers: {
          'X-RapidAPI-Host': rapidApiHost,
          'X-RapidAPI-Key': rapidApiKey,
        },
      );
   

      _jsonResponse = returnResponse(_response);

    } on SocketException catch (e) {
      throw FetchDataException('No Internet Connection');
      
    }
    return _jsonResponse;
  }

  // get League by teamId
  Future<dynamic> getLeagueByTeamId(int teamId) async{
    late dynamic _jsonResponse;
    try {
      final _queryParameter = {'team': teamId.toString()};
      var queryString = Uri(queryParameters: _queryParameter).query;
      var _url = baseUrl + getLeaguesEndpoint + '?' + queryString;
      final _response = await httpClient.get(
        Uri.parse(
          _url,
        ),
        headers: {
          'X-RapidAPI-Host': rapidApiHost,
          'X-RapidAPI-Key': rapidApiKey,
        },
      );
   

      _jsonResponse = returnResponse(_response);

    } on SocketException catch (e) {
      throw FetchDataException('No Internet Connection');
      
    }
    return _jsonResponse;
  }
}
