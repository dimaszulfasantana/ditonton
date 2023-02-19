import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/tvseries/tv_series_table.dart';

abstract class TvSeriesLocalDataSource {
  Future<String> addToWatchList(TvSeriesTable tvSeries);
  Future<String> deleteFromWatchList(TvSeriesTable tvSeries);
  Future<TvSeriesTable?> fetchTvSeriesDataById(int id);
  Future<List<TvSeriesTable>> fetchWatchListTvDataSeries();
}

class TvSeriesLocalDataSourceImpl implements TvSeriesLocalDataSource {
  final DatabaseHelper databaseHelper;
  TvSeriesLocalDataSourceImpl({
    required this.databaseHelper,
  });

  @override
  Future<TvSeriesTable?> fetchTvSeriesDataById(int id) async {
    final result = await databaseHelper.fetchTvSeriesDataById(id);
    if (result != null) {
      return TvSeriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvSeriesTable>> fetchWatchListTvDataSeries() async {
    final result = await databaseHelper.getTvWatchlistMovies();
    return result.map((data) => TvSeriesTable.fromMap(data)).toList();
  }

  @override
  Future<String> addToWatchList(TvSeriesTable tvSeries) async {
    try {
      await databaseHelper.insertTvWatchlist(tvSeries);
      return 'Added to Watchlist';
    } catch (error) {
      throw ErrorDatabaseFoundException(error.toString());
    }
  }

  @override
  Future<String> deleteFromWatchList(TvSeriesTable tvSeries) async {
    try {
      await databaseHelper.removeTvWatchlist(tvSeries);
      return 'Removed from Watchlist';
    } catch (error) {
      throw ErrorDatabaseFoundException(error.toString());
    }
  }
}
