part of 'movie_now_playing_bloc.dart';

abstract class MovieNowPlayingState extends Equatable {
  const MovieNowPlayingState();

  @override
  List<Object> get props => [];
}

class MovieNowPlayingInitial extends MovieNowPlayingState {}

class MovienowPlayingLoading extends MovieNowPlayingState {}

class MovieNowPlayingLoaded extends MovieNowPlayingState {
  final List<Movie> movies;

  MovieNowPlayingLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class MovieNowPlayingError extends MovieNowPlayingState {
  final String message;

  MovieNowPlayingError(this.message);

  @override
  List<Object> get props => [message];
}
