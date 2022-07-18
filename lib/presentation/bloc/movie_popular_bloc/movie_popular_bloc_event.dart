part of 'movie_popular_bloc_bloc.dart';

abstract class MoviePopularBlocEvent extends Equatable {
  const MoviePopularBlocEvent();

  @override
  List<Object> get props => [];
}

class LoadPopularMovie extends MoviePopularBlocEvent {}
