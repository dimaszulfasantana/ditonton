import 'dart:io';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_series_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/data/models/tvseries/tv_series_table.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_details.dart';
import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class TvSeriesRepositoryImpl extends TvSeriesRepository {
  final TvSeriesRemoteDataSource tvSeriesRemoteDataSource;
  final TvSeriesLocalDataSource tvSeriesLocalDataSource;
  TvSeriesRepositoryImpl({
    required this.tvSeriesRemoteDataSource,
    required this.tvSeriesLocalDataSource,
  });

  @override
  Future<Either<Failure, List<TvSeries>>> fetchNowPlayingTvSeriesData() async {
    try {
      final result =
          await tvSeriesRemoteDataSource.fetchNowPlayingTvSeriesData();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(ServerFailure('Certification not valid ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> fetchPopularTvSeriesData() async {
    try {
      final result = await tvSeriesRemoteDataSource.fetchPopularTvSeriesData();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(ServerFailure('Certification not valid ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> fetchSearchTvSeriesData(
      String query) async {
    try {
      final result =
          await tvSeriesRemoteDataSource.fetchSearchTvSeriesData(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(ServerFailure('Certification not valid ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> fetchTopRatedTvSeriesData() async {
    try {
      final result = await tvSeriesRemoteDataSource.fetchTopRatedTvSeriesData();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(ServerFailure('Certification not valid ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, TvDetails>> fetchTvSeriesDataDetails(
      int seriesId) async {
    try {
      final result =
          await tvSeriesRemoteDataSource.fetchTvSeriesDataDetails(seriesId);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(ServerFailure('Certification not valid ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> fetchTvSeriesRecommendationsData(
      int seriesId) async {
    try {
      final result = await tvSeriesRemoteDataSource
          .fetchTvSeriesRecommendationsData(seriesId);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(ServerFailure('Certification not valid ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> fetchWatchListTvDataSeries() async {
    final result = await tvSeriesLocalDataSource.fetchWatchListTvDataSeries();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<Either<Failure, String>> addToWatchList(TvDetails tvSeries) async {
    try {
      final result = await tvSeriesLocalDataSource
          .addToWatchList(TvSeriesTable.fromEntity(tvSeries));
      return Right(result);
    } on DatabaseException catch (e) {
      return left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await tvSeriesLocalDataSource.fetchTvSeriesDataById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> deleteFromWatchList(
      TvDetails tvSeries) async {
    try {
      final result = await tvSeriesLocalDataSource
          .deleteFromWatchList(TvSeriesTable.fromEntity(tvSeries));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
