import 'package:bloc/bloc.dart';
import 'package:dicoding_tv_series/domain/entities/movie_detail.dart';
import 'package:dicoding_tv_series/domain/usecase/get_detail_movie.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetDetailMovie _repository;
  MovieDetailBloc(this._repository) : super(MovieDetailInitial()) {
    on<LoadMovieDetail>(_loadMovieDetail);
  }

  _loadMovieDetail(LoadMovieDetail event, Emitter<MovieDetailState> emit) async {
    emit(MovieDetailLoading());
    final result = await _repository.execute(event.id);
    result.fold((l) {
      emit(MovieDetailError(l.message));
    }, (r) {
      emit(MovieDetailLoaded(r));
    });
  }
}
