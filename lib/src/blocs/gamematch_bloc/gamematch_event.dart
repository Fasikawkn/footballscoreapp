part of 'gamematch_bloc.dart';

abstract class GamematchEvent extends Equatable {
  const GamematchEvent();

  @override
  List<Object> get props => [];
}

class GetGamematchsByLeagueIdEvent extends GamematchEvent{
  final int season;
  final String date;
  final String leagueId;

  const GetGamematchsByLeagueIdEvent({
    required this.date,
    required this.season,
    required this.leagueId,
  });
}

class GetGameMatchByLeaguIdTeamIdEvent extends GamematchEvent{
  final int season;
  final int leagueId;
  final int teamId;
  const GetGameMatchByLeaguIdTeamIdEvent({
    required this.season,
    required this.leagueId,
    required this.teamId,
  });
}


class GetGameMatchByLeagueIdAndDateEvent extends GamematchEvent{
  final int season;
  final int leagueId;
  const GetGameMatchByLeagueIdAndDateEvent({
    required this.leagueId,
    required this.season,
  });
}

