import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<FailureException, List<Movie>>>
      fetchNowPlayingAllMovie() async {
    try {
      final result = await remoteDataSource.fetchNowPlayingAllMovie();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ErrorServerFoundException {
      return Left(FailureServerException(''));
    } on SocketException {
      return Left(
          FailureConnectionException('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(
          FailureServerException('Certification not valid ${e.toString()}'));
    }
  }

  @override
  Future<Either<FailureException, MovieDetail>> fetchMovieDataDetail(
      int id) async {
    try {
      final result = await remoteDataSource.fetchMovieDataDetail(id);
      return Right(result.toEntity());
    } on ErrorServerFoundException {
      return Left(FailureServerException(''));
    } on SocketException {
      return Left(
          FailureConnectionException('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(
          FailureServerException('Certification not valid ${e.toString()}'));
    }
  }

  @override
  Future<Either<FailureException, List<Movie>>> fetchMovieDataRecommendations(
      int id) async {
    try {
      final result = await remoteDataSource.fetchMovieDataRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ErrorServerFoundException {
      return Left(FailureServerException(''));
    } on SocketException {
      return Left(
          FailureConnectionException('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<FailureException, List<Movie>>> fetchPopularAllMovie() async {
    try {
      final result = await remoteDataSource.fetchPopularAllMovie();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ErrorServerFoundException {
      return Left(FailureServerException(''));
    } on SocketException {
      return Left(
          FailureConnectionException('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(
          FailureServerException('Certification not valid ${e.toString()}'));
    }
  }

  @override
  Future<Either<FailureException, List<Movie>>> fetchTopRatedAllMovie() async {
    try {
      final result = await remoteDataSource.fetchTopRatedAllMovie();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ErrorServerFoundException {
      return Left(FailureServerException(''));
    } on SocketException {
      return Left(
          FailureConnectionException('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(
          FailureServerException('Certification not valid ${e.toString()}'));
    }
  }

  @override
  Future<Either<FailureException, List<Movie>>> findAllMovies(
      String query) async {
    try {
      final result = await remoteDataSource.findAllMovies(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ErrorServerFoundException {
      return Left(FailureServerException(''));
    } on SocketException {
      return Left(
          FailureConnectionException('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(
          FailureServerException('Certification not valid ${e.toString()}'));
    }
  }

  @override
  Future<Either<FailureException, String>> saveWatchlist(
      MovieDetail movie) async {
    try {
      final result =
          await localDataSource.addToWatchList(MovieTable.fromEntity(movie));
      return Right(result);
    } on ErrorDatabaseFoundException catch (e) {
      return Left(FailureDatabaseException(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<FailureException, String>> deleteFromWatchList(
      MovieDetail movie) async {
    try {
      final result = await localDataSource
          .deleteFromWatchList(MovieTable.fromEntity(movie));
      return Right(result);
    } on ErrorDatabaseFoundException catch (e) {
      return Left(FailureDatabaseException(e.message));
    }
  }

  @override
  Future<bool> isAddedToWatchListorNot(int id) async {
    final result = await localDataSource.fetchMovieDataById(id);
    return result != null;
  }

  @override
  Future<Either<FailureException, List<Movie>>> getAllWatchListMovie() async {
    final result = await localDataSource.getAllWatchListMovie();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
