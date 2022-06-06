import 'package:collection/collection.dart';
import 'package:footballscoreapp/src/constants/constants_api/countries.dart';
import 'package:footballscoreapp/src/constants/constants_api/popular_teams.dart';
import 'package:footballscoreapp/src/constants/constants_api/popular_teams_league.dart';
import 'package:footballscoreapp/src/models/league.dart';
import 'package:footballscoreapp/src/models/models.dart';
import 'package:intl/intl.dart';

String getTime(DateTime dateTime) {
  return "${dateTime.hour < 10 ? '0${dateTime.hour}' : dateTime.hour}.${dateTime.minute < 10 ? '0${dateTime.minute}' : dateTime.minute}";
}

String formatDate(int timeStamp) {
  DateTime _dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);

  return DateFormat('hh:mm a').format(_dateTime);
}

String getDate(DateTime date) {
  return "${date.year}-${date.month < 10 ? '0${date.month}' : date.month}-${date.day < 10 ? '0${date.day}' : date.day}";
}

String formatDateBySlash(String dateString) {
  DateTime _dateTime = DateTime.parse(dateString);

  return '${_dateTime.month}/${_dateTime.day}/${_dateTime.year}';
}

// format date TES 14, 1999
String formatDatebyDayYear(String dateString){
  DateTime _dateTime = DateTime.parse(dateString);
  String day = DateFormat('EEE').format(_dateTime).toUpperCase();
  String dayNum = _dateTime.day.toString();
  String year = _dateTime.year.toString();

  return '$day $dayNum, $year';
}

List<League> getLeagues(List<dynamic> jsonList) {
  return jsonList.map((league) => League.fromJson(league)).toList();
}

List<Country> getCountries(List<dynamic> jsonCountries) {
  return jsonCountries.map((country) => Country.fromJson(country)).toList();
}

List<Country> getCountriesInitial(List<dynamic> jsonCountries) {
  return jsonCountries
      .sublist(0, 10)
      .map((country) => Country.fromJson(country))
      .toList();
}

Map<dynamic, List<Country>> getCountryFlag() {
  List<Country> _countriesModel =
      countries.map((country) => Country.fromJson(country)).toList();
  final _countries = groupBy(_countriesModel, (Country country) {
    return country.name;
  });
  return _countries;
}

List<TeamLeagueModel> getPopularTeams() {
  print('${popularTeams.length}');
  print('${popularTeamsLeague.length}');

  List<TeamLeagueModel> _teamLeague = [];
  for (int i = 0; i < popularTeams.length; i++) {
    TeamModel _teamModel = TeamModel.fromJson(popularTeams[i]);
    League _leagueModel = League.fromJson(popularTeamsLeague[i]);

    TeamLeagueModel _teamLeagueModel =  TeamLeagueModel(league: _leagueModel, teamModel: _teamModel);
    _teamLeague.add(_teamLeagueModel);
  }

  return _teamLeague;

}
