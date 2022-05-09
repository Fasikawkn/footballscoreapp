import 'package:footballscoreapp/src/constants/api_endpoints.dart';
import 'package:http/http.dart' as http;

class LeaguesDataProvider{
  final http.Client httpClient;
  LeaguesDataProvider({
    required this.httpClient,
  });

  // get all leagues data -> names, season, id...

  Future<dynamic> getAllLeaguesData() async{
    late dynamic _apiResponse;
    try {
      final _jsonResponse = await httpClient.get(
        Uri.parse(baseUrl+getLeaguesEndpoint),
        headers: {
          'X-RapidAPI-Host': rapidApiHost,
          'X-RapidAPI-Key' : rapidApiKey,
        }
      );
      
    } catch (e) {
    }
    
  }
}