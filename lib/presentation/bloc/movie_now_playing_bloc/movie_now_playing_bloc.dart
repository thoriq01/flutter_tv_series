import 'package:bloc/bloc.dart';
import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/domain/usecase/get_now_playing_movie.dart';
import 'package:equatable/equatable.dart';

part 'movie_now_playing_event.dart';
part 'movie_now_playing_state.dart';

class MovieNowPlayingBloc extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  final GetNowPlaying getNowPlaying;
  MovieNowPlayingBloc(this.getNowPlaying) : super(MovieNowPlayingInitial()) {
    on<LoadMovieNowPlaying>(_loadMovieNowPlaying);
  }

  _loadMovieNowPlaying(LoadMovieNowPlaying event, Emitter<MovieNowPlayingState> emit) async {
    emit(MovieNowPlayingInitial());
    emit(MovienowPlayingLoading());
    final result = await getNowPlaying.execute();
    result.fold((l) => emit(MovieNowPlayingError(l.toString())), (r) => emit(MovieNowPlayingLoaded(r)));
  }
}
