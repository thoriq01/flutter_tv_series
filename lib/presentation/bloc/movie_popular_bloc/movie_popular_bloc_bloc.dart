import 'package:bloc/bloc.dart';
import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/domain/usecase/get_popular_movie.dart';
import 'package:equatable/equatable.dart';

part 'movie_popular_bloc_event.dart';
part 'movie_popular_bloc_state.dart';

class MoviePopularBlocBloc extends Bloc<MoviePopularBlocEvent, MoviePopularBlocState> {
  final GetPopularMovie getPopularMovie;
  MoviePopularBlocBloc(this.getPopularMovie) : super(MoviePopularBlocInitial()) {
    on<LoadPopularMovie>(_loadMoviePopular);
  }

  _loadMoviePopular(LoadPopularMovie event, Emitter<MoviePopularBlocState> emit) async {
    emit(MoviePopularLoading());
    final response = await getPopularMovie.execute();
    response.fold(
      (failure) => emit(MoviePopularError(failure.message)),
      (success) => emit(
        MoviePopularLoaded(success),
      ),
    );
  }
}
