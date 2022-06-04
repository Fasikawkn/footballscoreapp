import 'dart:io';

import 'package:footballscoreapp/src/constants/constants.dart';
import 'package:footballscoreapp/src/services/API/response.dart';
import 'package:footballscoreapp/src/services/services.dart';
import 'package:http/http.dart' as http;

class SearchDataProvider{
    final http.Client httpClient = http.Client();

    // Search in league 
    Future<dynamic> searchLeague(String search) async{
      late dynamic _jsonResponse;
     try {
      final _queryParameter = {
        'search': search,
      };
      var endUrl = baseUrl + getLeaguesEndpoint;
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
    } on SocketException  {
      throw FetchDataException('No Internet Connection');
    }
    return _jsonResponse;
  }

  // search in teams
  Future<dynamic> searchTeams(String search) async{
    late dynamic _jsonResponse;
     try {
      final _queryParameter = {
        'search': search,
      };
      var endUrl = baseUrl + teamsEndpoint;
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
    } on SocketException  {
      throw FetchDataException('No Internet Connection');
    }
    return _jsonResponse;
  }

  // search player
  Future<dynamic> searchPlayer(String search, int leagueId) async{
    late dynamic _jsonResponse;
     try {
      final _queryParameter = {
        'search': search,
        'league': leagueId.toString()
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
    } on SocketException  {
      throw FetchDataException('No Internet Connection');
    }
    return _jsonResponse;
  }

  // 
    

}