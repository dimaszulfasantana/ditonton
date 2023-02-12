import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_details.dart';
import 'package:ditonton/domain/entities/tv_series.dart';

abstract class TvSeriesRepository {
  // Remote
  Future<Either<Failure, List<TvSeries>>> fetchNowPlayingTvSeriesData();
  Future<Either<Failure, List<TvSeries>>> fetchPopularTvSeriesData();
  Future<Either<Failure, List<TvSeries>>> fetchTopRatedTvSeriesData();
  Future<Either<Failure, TvDetails>> fetchTvSeriesDataDetails(int seriesId);
  Future<Either<Failure, List<TvSeries>>> fetchSearchTvSeriesData(String query);
  Future<Either<Failure, List<TvSeries>>> fetchTvSeriesRecommendationsData(
      int seriesId);
  // Local
  Future<Either<Failure, String>> addToWatchList(TvDetails tvSeries);
  Future<Either<Failure, String>> deleteFromWatchList(TvDetails tvSeries);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<TvSeries>>> fetchWatchListTvDataSeries();
}
