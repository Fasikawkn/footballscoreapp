import 'dart:io';

import 'package:footballscoreapp/src/constants/constants.dart';
import 'package:footballscoreapp/src/services/API/exceptions.dart';
import 'package:footballscoreapp/src/services/API/response.dart';
import 'package:http/http.dart' as http;

class TeamDataProvider {
  final http.Client httpClient;

  const TeamDataProvider({
    required this.httpClient,
  });

  // get leagues for the country;
  Future<dynamic> getTeamsByLeagueId(int leagueId, int season) async {
    late dynamic _jsonResponse;
    try {
      final _queryParameter = {
        'season': season.toString(),
        'league': leagueId.toString()
      };
      var endUrl = baseUrl + teamsEndpoint;
      var queryString = Uri(queryParameters: _queryParameter).query;
      final url = endUrl + '?' + queryString;
      final _response = await httpClient.get(
        Uri.parse(url),
        headers: {
          'X-RapidAPI-Host': rapidApiHost,
          'X-RapidAPI-Key': rapidApiKey,
        },
      );
      _jsonResponse = returnResponse(_response);
    }on SocketException catch (e) {
      throw FetchDataException('No Internet Connection');
    }
    return _jsonResponse;
  }
}
