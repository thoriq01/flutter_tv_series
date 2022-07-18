import 'package:bloc/bloc.dart';
import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/domain/repositories/movie_repositorie.dart';
import 'package:equatable/equatable.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final MovieRepository _repository;

  MovieListBloc(this._repository) : super(MovieListInitial()) {
    on<LoadMovieList>(_loadMovieList);
  }
  _loadMovieList(MovieListEvent event, Emitter<MovieListState> emit) async {
    emit(MovieListLoading());
    final result = await _repository.getPopularMovies();
    result.fold(
      (failure) => emit(MovieListError(failure.message)),
      (success) => emit(
        MovieListLoaded(success),
      ),
    );
  }
}
