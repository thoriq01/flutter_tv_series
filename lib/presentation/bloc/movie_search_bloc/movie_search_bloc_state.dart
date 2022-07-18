part of 'movie_search_bloc.dart';

abstract class MovieSearchBlocState extends Equatable {
  const MovieSearchBlocState();

  @override
  List<Object> get props => [];
}

class MovieSearchBlocInitial extends MovieSearchBlocState {}

class MovieSearchBlocLoading extends MovieSearchBlocState {}

class MovieSearchBlocLoaded extends MovieSearchBlocState {
  final List<Movie> movies;

  MovieSearchBlocLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class MovieSearchBlocError extends MovieSearchBlocState {
  final String message;

  MovieSearchBlocError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieSearchBlocEmpty extends MovieSearchBlocState {}
