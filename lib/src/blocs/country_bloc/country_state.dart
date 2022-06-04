part of 'country_bloc.dart';

abstract class CountryState extends Equatable {
  const CountryState();
  
  @override
  List<Object> get props => [];
}

class CountryInitial extends CountryState {}

class CountryLoading extends CountryState {}

class CountryLoaded extends CountryState{
  final List<Country> countries;
  const CountryLoaded( this.countries);
}

class CountryError extends CountryState{
  final String errorMessage;
  const CountryError(this.errorMessage);
}
