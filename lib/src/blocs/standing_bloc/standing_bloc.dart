import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:footballscoreapp/src/models/team_table_data.dart';
import 'package:footballscoreapp/src/services/repositories/standings.dart';

part 'standing_event.dart';
part 'standing_state.dart';

class StandingBloc extends Bloc<StandingEvent, StandingState> {
  final StandingsRepository repository;
  StandingBloc({
    required this.repository,
  }) : super(StandingInitialState()) {
    on<GetStandingDataEvent>(_mapGetStandingDataEvent);
    on<GetStandingDataForTeamEvent>(_mapGetStandingForTeamEvent);
  }

  void _mapGetStandingDataEvent(GetStandingDataEvent event, Emitter<StandingState> emit) async{
    emit(StandingLoadingState());
    try {
      final _response = await repository.getStandingInfo(event.leagueId, event.season);
      emit(StandingLoadedState(_response));
      
    } catch (e) {
      emit(StandingErrorState(e.toString()));
    }
  }
  

  void _mapGetStandingForTeamEvent(GetStandingDataForTeamEvent event, Emitter<StandingState> emit) async{
    emit(StandingLoadingState());

    try {
      final _response = await repository.getStateDataForTeam(event.leagueId, event.season, event.teamId);
      emit(StandingTeamLoadedState(_response));
      
    } catch (e) {
      emit(StandingErrorState(e.toString()));
    }
  }
}
