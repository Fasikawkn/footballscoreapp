part of 'standing_bloc.dart';

abstract class StandingEvent extends Equatable {
  const StandingEvent();

  @override
  List<Object> get props => [];
}


class GetStandingDataEvent extends StandingEvent{
  final int leagueId;
  final int season;
  const GetStandingDataEvent({
    required this.leagueId,
    required this.season,
  });
}

class GetStandingDataForTeamEvent extends StandingEvent{
  final int leagueId;
  final int season;
  final int teamId;
  const GetStandingDataForTeamEvent({
    required this.leagueId,
    required this.season,
    required this.teamId,
  });
}
