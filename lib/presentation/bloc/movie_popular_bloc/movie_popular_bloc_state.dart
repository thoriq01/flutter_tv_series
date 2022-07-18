part of 'movie_popular_bloc_bloc.dart';

abstract class MoviePopularBlocState extends Equatable {
  const MoviePopularBlocState();

  @override
  List<Object> get props => [];
}

class MoviePopularBlocInitial extends MoviePopularBlocState {}

class MoviePopularLoading extends MoviePopularBlocState {}

class MoviePopularLoaded extends MoviePopularBlocState {
  final List<Movie> movies;

  MoviePopularLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class MoviePopularError extends MoviePopularBlocState {
  final String message;

  MoviePopularError(this.message);

  @override
  List<Object> get props => [message];
}
