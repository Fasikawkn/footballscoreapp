import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:footballscoreapp/src/models/team_player_model.dart';
import 'package:footballscoreapp/src/services/repositories/player_repository.dart';

part 'teamplayer_event.dart';
part 'teamplayer_state.dart';

class TeamplayerBloc extends Bloc<TeamplayerEvent, TeamplayerState> {
  final PlayerRepository repository;
  TeamplayerBloc({
    required this.repository,
  }) : super(TeamplayerInitial()) {
    on<GetTeamPlayers>(_mapGetPlayerForTeamEvent);
  }

  void _mapGetPlayerForTeamEvent(
      GetTeamPlayers event, Emitter<TeamplayerState> emit) async {
    emit(TeamplayerLoading());
    try {
      final _response = await repository.getPlayersForTheTeam(event.teamId);
      final _group = groupBy(_response, (TeamPlayerModel player) {
        return player.position;
      });
      List<TeamSquad> _squad = _group.entries
          .map((entry) => TeamSquad(player: entry.value, position: entry.key!))
          .toList();
      emit(TeamSquadLoaded(_squad));
    } catch (e) {
      emit(TeamplayerError(e.toString()));
    }
  }
}
