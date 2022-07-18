import 'package:bloc/bloc.dart';
import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/domain/usecase/get_top_rated_movie.dart';
import 'package:equatable/equatable.dart';

part 'movie_top_rated_event.dart';
part 'movie_top_rated_state.dart';

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {
  final GetTopRatedMovie getPopularMovie;

  MovieTopRatedBloc(this.getPopularMovie) : super(MovieTopRatedInitial()) {
    on<LoadMovieTopRated>(_loadMovieTopRated);
  }
  _loadMovieTopRated(MovieTopRatedEvent event, Emitter<MovieTopRatedState> emit) async {
    emit(MovieTopRatedLoading());
    final result = await getPopularMovie.execute();
    result.fold((l) {
      emit(MovieTopRatedError(l.message));
    }, (r) {
      emit(MovieTopRatedLoaded(r));
    });
  }
}
