import 'package:bloc/bloc.dart';
import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/domain/usecase/search_movie.dart';
import 'package:equatable/equatable.dart';

part 'movie_search_bloc_event.dart';
part 'movie_search_bloc_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchBlocEvent, MovieSearchBlocState> {
  final SearchMovie _searchMovie;

  MovieSearchBloc(this._searchMovie) : super(MovieSearchBlocInitial()) {
    on<SearchMovieEvent>(_loadMovieSearch);
    on<RemoveSearchMovieEvent>(_emptySearch);
  }
  _loadMovieSearch(SearchMovieEvent event, Emitter<MovieSearchBlocState> emit) async {
    emit(MovieSearchBlocInitial());
    emit(MovieSearchBlocLoading());

    final result = await _searchMovie.execute(event.query);
    result.fold((l) {
      emit(MovieSearchBlocError(l.message));
    }, (r) {
      emit(MovieSearchBlocLoaded(r));
    });
  }

  _emptySearch(RemoveSearchMovieEvent event, Emitter<MovieSearchBlocState> emit) async {
    emit(MovieSearchBlocEmpty());
  }
}
