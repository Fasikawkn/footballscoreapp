import 'dart:io';

import 'package:footballscoreapp/src/models/player_statistics.dart';
import 'package:footballscoreapp/src/services/API/response.dart';
import 'package:footballscoreapp/src/services/services.dart';
import 'package:http/http.dart' as http;

import '../../constants/constants.dart';

class PlayerDataProvider {
  final http.Client httpClient;
  PlayerDataProvider({
    required this.httpClient,
  });

  // get Player for the team
  Future<dynamic> getPlayersForTheTeam(int teamId) async {
    late dynamic _apiResponse;
    try {
      final _queryParameter = {'team': teamId.toString()};
      var endUrl = baseUrl + playersSquad;
      var queryString = Uri(queryParameters: _queryParameter).query;
      final url = endUrl + '?' + queryString;
      final _jsonResponse = await http.get(
        Uri.parse(url),
        headers: {
          'X-RapidAPI-Host': rapidApiHost,
          'X-RapidAPI-Key': rapidApiKey,
        },
      );

      _apiResponse = returnResponse(_jsonResponse);
    } on SocketException catch (e) {
      throw FetchDataException('No Internet Connection');
    }

    return _apiResponse;
  }

  Future<dynamic> getPlayerStatistics(
      int leagueId, int season, int teamId) async {
    late dynamic _jsonResponse;
    try {
      final _queryParameter = {
        'league': leagueId.toString(),
        'season': season.toString(),
        'team': teamId.toString()
      };
      var endUrl = baseUrl + playerStatistics;
      var queryString = Uri(queryParameters: _queryParameter).query;
      final url = endUrl + '?' + queryString;
      final _response = await http.get(
        Uri.parse(url),
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

  // Get Coache
   Future<dynamic> getCoaches(int teamId) async {
    late dynamic _jsonResponse;
    try {
      final _queryParameter = {
        
        'team': teamId.toString()
      };
      var endUrl = baseUrl + coatch;
      var queryString = Uri(queryParameters: _queryParameter).query;
      final url = endUrl + '?' + queryString;
      final _response = await http.get(
        Uri.parse(url),
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


  // Fetch top scorers
  Future<dynamic> getTopScoreress(int leagueId, int season) async {
    late dynamic _jsonResponse;
    try {
      final _queryParameter = {
        'season': season.toString(),
        'league': leagueId.toString()
      };
      var endUrl = baseUrl + topScorrers;
      var queryString = Uri(queryParameters: _queryParameter).query;
      final url = endUrl + '?' + queryString;
      final _response = await http.get(
        Uri.parse(url),
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
