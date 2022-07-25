import 'package:bloc/bloc.dart';
import 'package:dicoding_tv_series/domain/entities/cast.dart';
import 'package:dicoding_tv_series/domain/usecase/get_cast_movie.dart';
import 'package:equatable/equatable.dart';

part 'movie_cast_event.dart';
part 'movie_cast_state.dart';

class MovieCastBloc extends Bloc<MovieCastEvent, MovieCastState> {
  final GetMovieCast _repository;
  MovieCastBloc(this._repository) : super(MovieCastInitial()) {
    on<LoadMovieCast>(_loadMovieCast);
  }

  _loadMovieCast(LoadMovieCast event, Emitter<MovieCastState> emit) async {
    emit(MovieCastInitial());
    emit(MovieCastLoading());
    final result = await _repository.execute(event.id);
    result.fold((l) {
      emit(MovieCastError(l.message));
    }, (r) {
      emit(MovieCastLoaded(r));
    });
  }
}
