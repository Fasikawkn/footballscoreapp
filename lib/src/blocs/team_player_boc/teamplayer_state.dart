part of 'teamplayer_bloc.dart';

abstract class TeamplayerState extends Equatable {
  const TeamplayerState();
  
  @override
  List<Object> get props => [];
}

class TeamplayerInitial extends TeamplayerState {}

class TeamplayerLoading extends TeamplayerState{}

class TeamplayerLoaded extends TeamplayerState{
  final List<TeamPlayerModel> playersSquad;
  const TeamplayerLoaded(this.playersSquad);
}

class TeamSquadLoaded extends TeamplayerState{
  final List<TeamSquad> teamSquad;
  const TeamSquadLoaded(this.teamSquad);
}
class TeamplayerError extends TeamplayerState{
  final String errorMessage;
  const  TeamplayerError(this.errorMessage);
}
