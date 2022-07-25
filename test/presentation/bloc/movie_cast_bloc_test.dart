import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/domain/entities/cast.dart';
import 'package:dicoding_tv_series/domain/usecase/get_cast_movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_cast_bloc/movie_cast_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  final movieCast = MovieCastEntities(false, 1, 40036, "Acting", "Taraji P. Henson", "Taraji P. Henson", 13.079, "/rxnEvzGlRBsE94s7lC4cMAiLluH.jpg");
  late GetMovieCast _getMovieCast;
  late MockMovieRepository _movieRepository;
  setUp(() {
    _movieRepository = MockMovieRepository();
    _getMovieCast = GetMovieCast(_movieRepository);
  });
  group("", () {
    test("Should emit MovieNowPlayigLoaded", () async* {
      when(_getMovieCast.execute(12)).thenAnswer((_) async => Right([movieCast]));
      final bloc = MovieCastBloc(_getMovieCast)..add(LoadMovieCast(12));
      expect(
          bloc,
          emitsInOrder([
            MovieCastLoaded([movieCast])
          ]));
    });

    test("Should emit MovieNowPlayingError", () async* {
      when(_getMovieCast.execute(58122)).thenAnswer((_) async => Left(ConnectionFailure("Error")));
      final bloc = MovieCastBloc(_getMovieCast)..add(LoadMovieCast(58122));
      expectLater(bloc, emitsInOrder([MovieCastError("Error")]));
    });
  });
  blocTest<MovieCastBloc, MovieCastState>(
    "Test Bloc",
    build: () {
      when(_getMovieCast.execute(58122)).thenAnswer((_) async => Right([movieCast]));
      return MovieCastBloc(_getMovieCast);
    },
    act: (bloc) => bloc.add(LoadMovieCast(58122)),
    expect: () => [
      MovieCastInitial(),
      MovieCastLoading(),
      MovieCastLoaded([movieCast])
    ],
  );
  final message = "Error";

  blocTest<MovieCastBloc, MovieCastState>(
    "Test Bloc",
    build: () {
      when(_getMovieCast.execute(-300)).thenAnswer((_) async => Left(ServerFailure(message)));
      return MovieCastBloc(_getMovieCast);
    },
    act: (bloc) => bloc.add(LoadMovieCast(-300)),
    expect: () => [isA<MovieCastInitial>(), isA<MovieCastLoading>(), isA<MovieCastError>()],
  );

  test("Aku tidak mengerti ini test apa", () {
    final bloc = LoadMovieCast(222);
    expect(bloc.props, [222]);
  });
  test("Aku tidak mengerti ini test apa", () {
    final bloc = LoadMovieCast(222);
    expect(bloc.id, 222);
  });
}
