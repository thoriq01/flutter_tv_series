part of 'movie_recomendation_bloc.dart';

abstract class MovieRecomendationEvent extends Equatable {
  const MovieRecomendationEvent();

  @override
  List<Object> get props => [
        LoadMovieRecomendation,
      ];
}

class LoadMovieRecomendation extends MovieRecomendationEvent {
  final int movieId;

  LoadMovieRecomendation(this.movieId);

  @override
  List<Object> get props => [movieId];
}
