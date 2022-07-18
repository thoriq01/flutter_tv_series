import 'package:bloc_test/bloc_test.dart';
import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/domain/usecase/get_popular_movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_popular_bloc/movie_popular_bloc_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import '../../dummy_data/dummy_objects.dart';
import 'get_popular_movies_bloc.mocks.dart';

class BlocGetPopularMovies extends MockBloc<MoviePopularBlocEvent, MoviePopularBlocState> implements MoviePopularBlocBloc {}

@GenerateMocks([GetPopularMovie])
void main() {
  late MockGetPopularMovie getPopularMovie;
  late BlocGetPopularMovies bloc;
  final st = <Movie>[testMovie];
  setUp(() {
    getPopularMovie = MockGetPopularMovie();
    // bloc = BlocGetPopularMovies()..add(LoadPopularMovie());
    bloc = BlocGetPopularMovies()..add(LoadPopularMovie());
  });

  whenListen(bloc, Stream.fromIterable([st]));

  blocTest<MoviePopularBlocBloc, MoviePopularBlocState>("should emit MoviePopularLoaded",
      build: () => bloc, expect: () => MoviePopularLoaded(st), act: (bloc) => bloc.add(LoadPopularMovie()));
}
