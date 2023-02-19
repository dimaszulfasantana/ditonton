import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_details.dart';
import 'package:ditonton/domain/entities/tv_series.dart';

abstract class TvSeriesRepository {
  // Remote
  Future<Either<FailureException, List<TvSeries>>>
      fetchNowPlayingTvSeriesData();
  Future<Either<FailureException, List<TvSeries>>> fetchPopularTvSeriesData();
  Future<Either<FailureException, List<TvSeries>>> fetchTopRatedTvSeriesData();
  Future<Either<FailureException, TvDetails>> fetchTvSeriesDataDetails(
      int seriesId);
  Future<Either<FailureException, List<TvSeries>>> fetchSearchTvSeriesData(
      String query);
  Future<Either<FailureException, List<TvSeries>>>
      fetchTvSeriesRecommendationsData(int seriesId);
  // Local
  Future<Either<FailureException, String>> addToWatchList(TvDetails tvSeries);
  Future<Either<FailureException, String>> deleteFromWatchList(
      TvDetails tvSeries);
  Future<bool> isAddedToWatchListorNot(int id);
  Future<Either<FailureException, List<TvSeries>>> fetchWatchListTvDataSeries();
}
