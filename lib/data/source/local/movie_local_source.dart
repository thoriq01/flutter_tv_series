import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/data/models/movie_table.dart';
import 'package:dicoding_tv_series/data/source/local/movies_local_data_source.dart';

abstract class MovieLocalDataSource {
  Future<String> insertWatchlist(MovieTable movie);
  Future<String> removeWatchlist(MovieTable movie);
  Future<MovieTable?> getMovieById(int id);
  Future<List<MovieTable>> getWatchlistMovies();
}

class MovieLocalSource implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalSource(this.databaseHelper);

  @override
  Future<MovieTable?> getMovieById(int id) async {
    final response = await databaseHelper.getMovieById(id);
    try {
      if (response != null) {
        return MovieTable.fromMap(response);
      }
      return null;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<MovieTable>> getWatchlistMovies() async {
    final response = await databaseHelper.getWatchlistMovies();
    try {
      return response.map((e) => MovieTable.fromMap(e)).toList();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> insertWatchlist(MovieTable movie) async {
    try {
      await databaseHelper.insertWatchlist(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(MovieTable movie) async {
    try {
      await databaseHelper.removeWatchlist(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
