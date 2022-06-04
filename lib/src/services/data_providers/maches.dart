import 'dart:io';
import 'package:footballscoreapp/src/constants/constants.dart';
import 'package:footballscoreapp/src/services/API/response.dart';
import 'package:footballscoreapp/src/services/services.dart';
import 'package:http/http.dart' as http;

class MatchesDataProvider {
  final http.Client httpClient;
  MatchesDataProvider({
    required this.httpClient,
  });

  // Get Game matches by Date
  Future<dynamic> getFixtureByDate(DateTime dateTime) async{
    String _date = getDate(dateTime);
  late dynamic _apiResponse;
    try {
      final _queryParameter = {
            'date': _date,
          };
      var endUrl = baseUrl +fixtureEndpoint;
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

  // Get Maches by League Id;

  Future<dynamic> getMachesByLeagueId(
      String date, int season, String leagueId) async {
    late dynamic _apiResponse;
    try {
      final _queryParameter = {
            'date': date,
            'season': season.toString(),
            'league': leagueId
          };
      var endUrl = baseUrl +fixtureEndpoint;
      // final url = Uri.https(rapidApiHost+'/v3/' + fixtureEndpoint,_queryParameter);
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

  // get matchs by LeagueID , TeamId, start date and EndDate

  Future<dynamic> getMatchesByLeagueIdTeamId(int leagueId, int season, int teamId) async{
    String _todayString = getDate(DateTime.now());
    String _startDate = getDate(DateTime.now().subtract(const Duration(days: 180)));

    late dynamic _apiResponse;
    try {
   final _queryParameter = {
            'league': leagueId.toString(),
            'season': season.toString(),
            'team': teamId.toString(),
            'from': _startDate,
            'to': _todayString,
          };
      var endUrl = baseUrl +fixtureEndpoint;
      var queryString = Uri(queryParameters: _queryParameter).query;
      final url = endUrl+'?'+queryString;
      final _jsonResponse = await http.get(
        Uri.parse(url),
        headers: {
          'X-RapidAPI-Host': rapidApiHost,
          'X-RapidAPI-Key': rapidApiKey,
        },
      );
      print(_jsonResponse.body);

      _apiResponse = returnResponse(_jsonResponse);
    } on SocketException catch (e) {
      throw FetchDataException('No Internet Connection');
    }
    catch (e){
      print('The error is ${e.toString()}');
    }

    return _apiResponse;
  }

  // get matches by leagueId, season, start date and end date
  Future<dynamic> getMatchesByLeagueIdAndDate(int leagueId, int season) async{
    String _todayString = getDate(DateTime.now());
    String _startDate = getDate(DateTime.now().subtract(const Duration(days: 180)));

    late dynamic _apiResponse;
    try {
   final _queryParameter = {
            'league': leagueId.toString(),
            'season': season.toString(),
            'from': _startDate,
            'to': _todayString,
          };
      var endUrl = baseUrl +fixtureEndpoint;
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
    catch (e){
      print('The error is ${e.toString()}');
    }

    return _apiResponse;
  }

  // Fixture Statistics by Id
  Future<dynamic> getFixtureStatisticsById(int fixtureId) async{
    late dynamic _jsonResponse;
    try {
   final _queryParameter = {
            'fixture': fixtureId.toString(),
          };
      var endUrl = baseUrl +fixtureStatistics;
      var queryString = Uri(queryParameters: _queryParameter).query;
      final url = endUrl+'?'+queryString;
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
    catch (e){
      print('The error is ${e.toString()}');
    }

    return _jsonResponse;
  }

  // get fixture lineups
  Future<dynamic> getFixtureLineups(int fixtureId) async{
    late dynamic _jsonResponse;
    try {
   final _queryParameter = {
            'fixture': fixtureId.toString(),
          };
      var endUrl = baseUrl + fixtureLineups;
      var queryString = Uri(queryParameters: _queryParameter).query;
      final url = endUrl+'?'+queryString;
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
    catch (e){
      print('The error is ${e.toString()}');
    }

    return _jsonResponse;
  }

  // get fixture event
  Future<dynamic> getFixtureEvents(int fixtureId) async{
    late dynamic _jsonResponse;
    try {
   final _queryParameter = {
            'fixture': fixtureId.toString(),
          };
      var endUrl = baseUrl + fixtureEvents;
      var queryString = Uri(queryParameters: _queryParameter).query;
      final url = endUrl+'?'+queryString;
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
    catch (e){
      print('The error is ${e.toString()}');
    }

    return _jsonResponse;
  }
  
}
