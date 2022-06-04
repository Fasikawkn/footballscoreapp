import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:footballscoreapp/src/models/league.dart';
import 'package:footballscoreapp/src/services/repositories/repositories.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

part 'league_event.dart';
part 'league_state.dart';

class LeagueBloc extends Bloc<LeagueEvent, LeagueState> {
  final LeaguesRepository leaguesRepository;
  LeagueBloc({required this.leaguesRepository}) : super(LeagueInitialState()) {
    on<LeagueEvent>(_mapgetLeaguesEvent);
    on<GetLeaguesByCountryNameEvent>(_mapGetLeaguByCountryName);
  }
  void _mapgetLeaguesEvent(LeagueEvent event,Emitter<LeagueState> emit) async{
    emit (LeagueLoadingState());

    try {
      final _leagues = await leaguesRepository.getAllLeaguesData();
      emit(LeagueLoadedState(_leagues));
      
    } catch (e) {
      emit(LeagueErrorState(e.toString()));
    }
  }

  void _mapGetLeaguByCountryName(GetLeaguesByCountryNameEvent event,Emitter<LeagueState> emit) async{
    emit(LeagueLoadingState());
    try {
      final _leaguesByCountry = await leaguesRepository.getLeagueByCountryName(event.name);
      emit(LeagueLoadedState(_leaguesByCountry));
      
    } catch (e) {
      emit(LeagueErrorState(e.toString()));
    }
  }
}
