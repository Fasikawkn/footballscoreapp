import 'package:footballscoreapp/src/models/models.dart';
import 'package:footballscoreapp/src/services/data_providers/data_providers.dart';

class CountryRepository{
  final CountryDataProvider dataProvider;

  CountryRepository({required this.dataProvider});

  // Get all Countries
  Future<List<Country>> getAllCountries() async{
    final _jsonResponse = await dataProvider.getAllCountries();
    final _response = _jsonResponse['response'] as List;

    return _response.map((country) => Country.fromJson(country)).toList();

  }
}