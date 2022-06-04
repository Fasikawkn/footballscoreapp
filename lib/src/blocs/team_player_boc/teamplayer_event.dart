part of 'teamplayer_bloc.dart';

abstract class TeamplayerEvent extends Equatable {
  const TeamplayerEvent();

  @override
  List<Object> get props => [];
}


class GetTeamPlayers extends TeamplayerEvent{
  final int teamId;
  const GetTeamPlayers(this.teamId);
}
