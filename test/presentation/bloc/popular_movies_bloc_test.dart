import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/domain/usecase/get_popular_movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_popular_bloc/movie_popular_bloc_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';

class _MockGetPopularMovie extends Mock implements GetPopularMovie {}

@GenerateMocks([GetPopularMovie])
void main() {
  late _MockGetPopularMovie _mockGetPopularMovie;

  setUp(() {
    _mockGetPopularMovie = _MockGetPopularMovie();
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
  });
}
