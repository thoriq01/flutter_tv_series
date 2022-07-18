import 'package:dicoding_tv_series/data/source/local/movie_local_source.dart';
import 'package:dicoding_tv_series/data/source/local/movies_local_data_source.dart';
import 'package:dicoding_tv_series/data/source/online/movie_online_data_source.dart';
import 'package:dicoding_tv_series/domain/repositories/movie_repositorie.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  MovieDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
