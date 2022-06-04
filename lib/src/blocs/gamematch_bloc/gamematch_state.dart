part of 'gamematch_bloc.dart';

abstract class GamematchState extends Equatable {
  const GamematchState();
  
  @override
  List<Object> get props => [];
}

class GamematchInitialState extends GamematchState {

}

class GamematchLoadingState extends GamematchState{}


class GamematchLoadedState extends GamematchState{
  final List<GameMatch> gameMathes;
  const GamematchLoadedState({
    required this.gameMathes,
  });
}

class LeagueGamematchLoadedState extends GamematchState{
  final List<LeagueGameMatch> gameMatches;
  const LeagueGamematchLoadedState(this.gameMatches);
}

class GamematchErrorState extends GamematchState{
  final String appException;
  const GamematchErrorState({
    required this.appException,
  });
  
}
