part of 'league_bloc.dart';

@immutable
abstract class LeagueEvent extends Equatable {
 
}

class GetLeaguesEvent extends LeagueEvent {
   @override
  List<Object> get props => [];
}


class GetLeaguesByCountryNameEvent extends LeagueEvent{
  final String name;
   GetLeaguesByCountryNameEvent(this.name);
 @override
  List<Object> get props => [];

}