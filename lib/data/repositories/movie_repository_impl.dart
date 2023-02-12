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
  Future<Either<Failure, List<Movie>>> fetchNowPlayingAllMovie() async {
    try {
      final result = await remoteDataSource.fetchNowPlayingAllMovie();
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
  Future<Either<Failure, MovieDetail>> fetchMovieDataDetail(int id) async {
    try {
      final result = await remoteDataSource.fetchMovieDataDetail(id);
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
  Future<Either<Failure, List<Movie>>> fetchMovieDataRecommendations(
      int id) async {
    try {
      final result = await remoteDataSource.fetchMovieDataRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> fetchPopularAllMovie() async {
    try {
      final result = await remoteDataSource.fetchPopularAllMovie();
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
  Future<Either<Failure, List<Movie>>> fetchTopRatedAllMovie() async {
    try {
      final result = await remoteDataSource.fetchTopRatedAllMovie();
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
  Future<Either<Failure, List<Movie>>> findAllMovies(String query) async {
    try {
      final result = await remoteDataSource.findAllMovies(query);
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
  Future<Either<Failure, String>> saveWatchlist(MovieDetail movie) async {
    try {
      final result =
          await localDataSource.addToWatchList(MovieTable.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, String>> deleteFromWatchList(MovieDetail movie) async {
    try {
      final result = await localDataSource
          .deleteFromWatchList(MovieTable.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.fetchMovieDataById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<Movie>>> fetchWatchListAllMovie() async {
    final result = await localDataSource.fetchWatchListAllMovie();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
