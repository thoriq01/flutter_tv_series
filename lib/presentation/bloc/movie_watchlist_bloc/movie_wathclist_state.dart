part of 'movie_wathclist_bloc.dart';

abstract class MovieWathclistState extends Equatable {
  const MovieWathclistState();

  @override
  List<Object> get props => [];
}

class MovieWathclistInitial extends MovieWathclistState {}

class MovieWatchlistLoading extends MovieWathclistState {}

class MovieWatchlistLoaded extends MovieWathclistState {
  final List<Movie> movies;
  MovieWatchlistLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class MovieWatchlistError extends MovieWathclistState {
  final String message;

  MovieWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchlistSuccessAdd extends MovieWathclistState {
  final String message;

  MovieWatchlistSuccessAdd(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchlistSuccessRemoved extends MovieWathclistState {
  final String message;

  MovieWatchlistSuccessRemoved(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchlistIsAdded extends MovieWathclistState {}

class MovieWatchlistIsNotAdded extends MovieWathclistState {}
