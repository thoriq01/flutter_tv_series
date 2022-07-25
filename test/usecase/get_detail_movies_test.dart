import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/domain/entities/movie_detail.dart';
import 'package:dicoding_tv_series/domain/usecase/get_detail_movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../dummy_data/dummy_objects.dart';
import '../helpers/test_helper.mocks.dart';

void main() {
  late GetDetailMovie getDetailMovie;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    getDetailMovie = GetDetailMovie(mockMovieRepository);
  });
  final int id = 1;
  test('should get top rated movie from the repository', () async {
    // arrange
    when(mockMovieRepository.getMovieDetail(id)).thenAnswer((_) async => Right(testMovieDetail));
    // act
    final result = await getDetailMovie.execute(id);
    // assert
    expect(result, Right(testMovieDetail));
  });
  final testMovie = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  test("Test movie detail to movie", () {
    final result = Movie.fromEntity(MovieDetail(
      adult: false,
      backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
      genres: [],
      id: 557,
      originalTitle: 'Spider-Man',
      overview:
          'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
      posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
      releaseDate: '2002-05-01',
      runtime: 2,
      title: 'Spider-Man',
      voteAverage: 7.2,
      voteCount: 13507,
    ));
    expect(result, testMovie);
  });
  test("Bingung test apa ini", () {
    var movie = MovieDetail(
      adult: false,
      backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
      genres: [],
      id: 557,
      originalTitle: "",
      overview:
          'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
      posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
      releaseDate: "",
      title: 'Spider-Man',
      voteAverage: 0,
      voteCount: 0,
      runtime: 0,
    );
    final data = testMovie.movie();
    expect(data, movie);
  });
}
