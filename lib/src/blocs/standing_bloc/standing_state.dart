part of 'standing_bloc.dart';

abstract class StandingState extends Equatable {
  const StandingState();
  
  @override
  List<Object> get props => [];
}

class StandingInitialState extends StandingState {}


class StandingLoadingState extends StandingState{}

class StandingLoadedState extends StandingState{
  final LeagueTable standings;
  const StandingLoadedState(this.standings);
}

class StandingTeamLoadedState extends StandingState{
  final LeagueTable standings;
  const StandingTeamLoadedState(this.standings);
}

class StandingErrorState extends StandingState{
  final String errorMessage;
  const StandingErrorState(this.errorMessage);
}