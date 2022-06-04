part of 'league_bloc.dart';

@immutable
abstract class LeagueState extends Equatable{

 

}

class LeagueInitialState extends LeagueState {
   @override
  List<Object> get props => [];
}

class LeagueLoadingState extends LeagueState{
    @override
  List<Object> get props => [];
}

class LeagueLoadedState extends LeagueState{
  final List<League> leagues;
  LeagueLoadedState(this.leagues);
   @override
  List<Object> get props => [leagues];
}

class LeagueErrorState extends LeagueState{
  final String errorMessage;
  LeagueErrorState(this.errorMessage);
   @override
  List<Object> get props => [errorMessage];
}

