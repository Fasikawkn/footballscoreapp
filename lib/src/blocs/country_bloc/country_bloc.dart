import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:footballscoreapp/src/models/models.dart';
import 'package:footballscoreapp/src/services/repositories/repositories.dart';

part 'country_event.dart';
part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final CountryRepository repository;
  CountryBloc({
    required this.repository,
  }) : super(CountryInitial()) {
    on<FetchAllCountries>(_mapGetAllCountries);
  }

  void _mapGetAllCountries(
      FetchAllCountries event, Emitter<CountryState> emit) async {
    emit(CountryLoading());

    try {
      final _response = await repository.getAllCountries();
      emit(CountryLoaded(_response));
    } catch (e) {
      emit(CountryError(e.toString()));
    }
  }
}
