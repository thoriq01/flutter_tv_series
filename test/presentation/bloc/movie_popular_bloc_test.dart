import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/domain/usecase/get_popular_movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_popular_bloc/movie_popular_bloc_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

@GenerateMocks([GetPopularMovie])
void main() {
  late MockMovieRepository mockMovieRepository;
  late GetPopularMovie _mockGetPopularMovie;
  setUp(() {
    mockMovieRepository = MockMovieRepository();
    _mockGetPopularMovie = GetPopularMovie(mockMovieRepository);
  });

  group("Movie Popular Bloc", () {
    final data = <Movie>[testMovie];

    test("Should emit MoviePopularLoaded", () async* {
      when(_mockGetPopularMovie.execute()).thenAnswer((_) async => Right(data));

      final bloc = MoviePopularBlocBloc(_mockGetPopularMovie);

      bloc.add(LoadPopularMovie());

      expectLater(bloc.state, emitsInOrder([MoviePopularLoaded(data)]));
    });

    test("Should emit MoviePopularError", () async* {
      final message = "Error";
      when(_mockGetPopularMovie.execute()).thenAnswer((_) async => Left(ServerFailure(message)));

      final bloc = MoviePopularBlocBloc(_mockGetPopularMovie);

      bloc.add(LoadPopularMovie());

      expectLater(bloc.state, emitsInOrder([MoviePopularError(message)]));
    });

    blocTest<MoviePopularBlocBloc, MoviePopularBlocState>(
      "Test Bloc",
      build: () {
        when(_mockGetPopularMovie.execute()).thenAnswer((_) async => Right(data));
        return MoviePopularBlocBloc(_mockGetPopularMovie);
      },
      act: (bloc) => bloc.add((LoadPopularMovie())),
      expect: () => [MoviePopularBlocInitial(), MoviePopularLoading(), MoviePopularLoaded(data)],
    );
    final message = "Error";

    blocTest<MoviePopularBlocBloc, MoviePopularBlocState>(
      "Test Bloc",
      build: () {
        when(_mockGetPopularMovie.execute()).thenAnswer((_) async => Left(ServerFailure(message)));
        return MoviePopularBlocBloc(_mockGetPopularMovie);
      },
      act: (bloc) => bloc.add((LoadPopularMovie())),
      expect: () => [isA<MoviePopularBlocInitial>(), isA<MoviePopularLoading>(), isA<MoviePopularError>()],
    );
  });
  test("Test Event", () {
    final event = LoadPopularMovie();

    expect(event.props, []);
  });

  test("Test State", () {
    final state = LoadPopularMovie();

    expect(state.props, []);
  });
}
