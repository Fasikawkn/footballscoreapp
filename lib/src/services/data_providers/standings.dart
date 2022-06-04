import 'dart:io';

import 'package:footballscoreapp/src/constants/constants.dart';
import 'package:footballscoreapp/src/services/API/response.dart';
import 'package:footballscoreapp/src/services/services.dart';
import 'package:http/http.dart' as http;



class StandingsDataProvider{
  final http.Client httpClient;

  StandingsDataProvider({
    required this.httpClient,
  });

  // Get Table information for the league

  Future<dynamic> getStandingData(int leagueId, int season) async{
    late dynamic _apiResponse;
    try {
      final _queryParameter = {
           'season': season.toString(),
            'league': leagueId.toString()
          };
      var endUrl = baseUrl +standingsEndpoint;
      var queryString = Uri(queryParameters: _queryParameter).query;
      final url = endUrl+'?'+queryString;
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

  // standing Information for the team

  Future<dynamic> getStateDataForTeam(int leagueId, int season, int teamId) async{
    late dynamic _apiResponse;
    try {
      final _queryParameter = {
           'season': season.toString(),
            'league': leagueId.toString(),
            'team': teamId.toString()
          };
      var endUrl = baseUrl +standingsEndpoint;
      var queryString = Uri(queryParameters: _queryParameter).query;
      final url = endUrl+'?'+queryString;
      final _jsonResponse = await http.get(
        Uri.parse(url),
        headers: {
          'X-RapidAPI-Host': rapidApiHost,
          'X-RapidAPI-Key': rapidApiKey,
        },
      );

     

      _apiResponse = returnResponse(_jsonResponse);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return _apiResponse;
  }

  
}