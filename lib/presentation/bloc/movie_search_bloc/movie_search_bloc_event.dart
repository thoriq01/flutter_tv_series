part of 'movie_search_bloc.dart';

abstract class MovieSearchBlocEvent extends Equatable {
  const MovieSearchBlocEvent();

  @override
  List<Object> get props => [];
}

class SearchMovieEvent extends MovieSearchBlocEvent {
  final String query;

  SearchMovieEvent(this.query);

  @override
  List<Object> get props => [query];
}

class RemoveSearchMovieEvent extends MovieSearchBlocEvent {}
