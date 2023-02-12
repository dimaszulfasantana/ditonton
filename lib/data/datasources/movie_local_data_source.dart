import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/movie_table.dart';

abstract class MovieLocalDataSource {
  Future<String> addToWatchList(MovieTable movie);
  Future<String> deleteFromWatchList(MovieTable movie);
  Future<MovieTable?> fetchMovieDataById(int id);
  Future<List<MovieTable>> fetchWatchListAllMovie();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> addToWatchList(MovieTable movie) async {
    try {
      await databaseHelper.addToWatchList(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> deleteFromWatchList(MovieTable movie) async {
    try {
      await databaseHelper.deleteFromWatchList(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<MovieTable?> fetchMovieDataById(int id) async {
    final result = await databaseHelper.fetchMovieDataById(id);
    if (result != null) {
      return MovieTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<MovieTable>> fetchWatchListAllMovie() async {
    final result = await databaseHelper.fetchWatchListAllMovie();
    return result.map((data) => MovieTable.fromMap(data)).toList();
  }
}
