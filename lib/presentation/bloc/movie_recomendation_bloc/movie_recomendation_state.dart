part of 'movie_recomendation_bloc.dart';

abstract class MovieRecomendationState extends Equatable {
  const MovieRecomendationState();

  @override
  List<Object> get props => [];
}

class MovieRecomendationInitial extends MovieRecomendationState {}

class MovieRecomendationLoading extends MovieRecomendationState {}

class MovieRecomendationLoaded extends MovieRecomendationState {
  final List<Movie> movies;

  MovieRecomendationLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class MovieRecomendationError extends MovieRecomendationState {
  final String message;

  MovieRecomendationError(this.message);

  @override
  List<Object> get props => [message];
}
