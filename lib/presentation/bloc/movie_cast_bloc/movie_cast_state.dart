part of 'movie_cast_bloc.dart';

abstract class MovieCastState extends Equatable {
  const MovieCastState();

  @override
  List<Object> get props => [];
}

class MovieCastInitial extends MovieCastState {}

class MovieCastLoading extends MovieCastState {}

class MovieCastLoaded extends MovieCastState {
  final List<MovieCastEntities> movieCast;

  MovieCastLoaded(this.movieCast);

  @override
  List<Object> get props => [movieCast];
}

class MovieCastError extends MovieCastState {
  final String message;

  MovieCastError(this.message);

  @override
  List<Object> get props => [message];
}
