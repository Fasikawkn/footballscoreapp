import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:footballscoreapp/src/constants/constants.dart';
import 'package:footballscoreapp/src/models/match.dart';
import 'package:footballscoreapp/src/services/repositories/matches.dart';
import 'package:flutter/material.dart';
part 'gamematch_event.dart';
part 'gamematch_state.dart';

class GamematchBloc extends Bloc<GamematchEvent, GamematchState> {
  final GameMatchesRepository gameMatchesRepository;

  GamematchBloc({required this.gameMatchesRepository})
      : super(GamematchInitialState()) {
    on<GetGamematchsByLeagueIdEvent>(_mapGetGamematchesByLeagueId);
    on<GetGameMatchByLeaguIdTeamIdEvent>(_mapGetGamematchesByLeagueIdTeamId);
    on<GetGameMatchByLeagueIdAndDateEvent>(_mapGetGameMatchesByLeagueIdAndDate);
  }

  void _mapGetGamematchesByLeagueId(
      GetGamematchsByLeagueIdEvent event, Emitter<GamematchState> emit) async {
    emit(GamematchLoadingState());
    try {
      final _response = await gameMatchesRepository.getMachesByLeagueId(
          event.date, event.season, event.leagueId);
      emit(GamematchLoadedState(gameMathes: _response));
    } catch (e) {
      emit(GamematchErrorState(appException: e.toString()));
    }
  }

  void _mapGetGamematchesByLeagueIdTeamId(
      GetGameMatchByLeaguIdTeamIdEvent event,
      Emitter<GamematchState> emit) async {
    emit(GamematchLoadingState());
    try {
      final _response = await gameMatchesRepository.getMatchesByLeagueIdTeamId(
        event.leagueId,
        event.season,
        event.teamId,
      );
      emit(GamematchLoadedState(gameMathes: _response));
    } catch (e) {
      emit(
        GamematchErrorState(appException: e.toString()),
      );
    }
  }

  void _mapGetGameMatchesByLeagueIdAndDate(
      GetGameMatchByLeagueIdAndDateEvent event,
      Emitter<GamematchState> emit) async {
    emit(GamematchLoadingState());
    try {
      final _response = await gameMatchesRepository.getMatchesByLeagueIdAndDate(
        event.leagueId,
        event.season,
      );

        final _group = groupBy(_response, (GameMatch match){
          String _date = formatDateBySlash(match.fixture!.date!);
          return _date;
        });

        List<LeagueGameMatch> _leagueGames = _group.entries.map((entry) => LeagueGameMatch(date: entry.key, games: entry.value)).toList();
      emit(
        LeagueGamematchLoadedState(_leagueGames),
      );
    } catch (e) {
      emit(
        GamematchErrorState(
          appException: e.toString(),
        ),
      );
    }
  }
}

