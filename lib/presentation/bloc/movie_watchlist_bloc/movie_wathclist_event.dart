part of 'movie_wathclist_bloc.dart';

abstract class MovieWathclistEvent extends Equatable {
  const MovieWathclistEvent();

  @override
  List<Object> get props => [];
}

class LoadMovieWatchlist extends MovieWathclistEvent {}

class DeleteMovieWatchlist extends MovieWathclistEvent {
  final MovieDetail movie;

  DeleteMovieWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class AddMovieWatchlist extends MovieWathclistEvent {
  final MovieDetail movie;

  AddMovieWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class RemoveMovieWatchlist extends MovieWathclistEvent {
  final MovieDetail movie;

  RemoveMovieWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class CheckIsAddedMovieWatchlist extends MovieWathclistEvent {
  final int id;

  CheckIsAddedMovieWatchlist(this.id);

  @override
  List<Object> get props => [id];
}
