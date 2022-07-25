import 'package:bloc/bloc.dart';
import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/domain/usecase/get_recomendation_movie.dart';
import 'package:equatable/equatable.dart';

part 'movie_recomendation_event.dart';
part 'movie_recomendation_state.dart';

class MovieRecomendationBloc extends Bloc<MovieRecomendationEvent, MovieRecomendationState> {
  final GetRecomendation getRecomendation;
  MovieRecomendationBloc(this.getRecomendation) : super(MovieRecomendationInitial()) {
    on<LoadMovieRecomendation>(_loadMovieRecomendation);
  }
  _loadMovieRecomendation(LoadMovieRecomendation event, Emitter<MovieRecomendationState> emit) async {
    emit(MovieRecomendationInitial());
    emit(MovieRecomendationLoading());
    final result = await getRecomendation.execute(event.movieId);
    result.fold((l) => emit(MovieRecomendationError(l.toString())), (r) => emit(MovieRecomendationLoaded(r)));
  }
}
