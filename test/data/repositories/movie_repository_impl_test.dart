import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/data/models/movie_model.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieRepositoryImpl repository;
  late MockMovieRemoteDataSource mockRemoteDataSource;
  late MockMovieLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockMovieRemoteDataSource();
    mockLocalDataSource = MockMovieLocalDataSource();
    repository = MovieRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tMovieModel = MovieModel(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
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

  final tMovie = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
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

  final tMovieModelList = <MovieModel>[tMovieModel];
  final tMovieList = <Movie>[tMovie];

  group('Now Playing Movies', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.fetchNowPlayingAllMovie())
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.fetchNowPlayingAllMovie();
      // assert
      verify(mockRemoteDataSource.fetchNowPlayingAllMovie());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.fetchNowPlayingAllMovie())
          .thenThrow(ErrorServerFoundException());
      // act
      final result = await repository.fetchNowPlayingAllMovie();
      // assert
      verify(mockRemoteDataSource.fetchNowPlayingAllMovie());
      expect(result, equals(Left(FailureServerException(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.fetchNowPlayingAllMovie())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.fetchNowPlayingAllMovie();
      // assert
      verify(mockRemoteDataSource.fetchNowPlayingAllMovie());
      expect(
          result,
          equals(Left(
              FailureConnectionException('Failed to connect to the network'))));
    });
  });

  group('Popular Movies', () {
    test('should return movie list when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.fetchPopularAllMovie())
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.fetchPopularAllMovie();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.fetchPopularAllMovie())
          .thenThrow(ErrorServerFoundException());
      // act
      final result = await repository.fetchPopularAllMovie();
      // assert
      expect(result, Left(FailureServerException('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.fetchPopularAllMovie())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.fetchPopularAllMovie();
      // assert
      expect(result,
          Left(FailureConnectionException('Failed to connect to the network')));
    });
  });

  group('Top Rated Movies', () {
    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.fetchTopRatedAllMovie())
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.fetchTopRatedAllMovie();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test(
        'should return FailureServerException when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.fetchTopRatedAllMovie())
          .thenThrow(ErrorServerFoundException());
      // act
      final result = await repository.fetchTopRatedAllMovie();
      // assert
      expect(result, Left(FailureServerException('')));
    });

    test(
        'should return FailureConnectionException when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.fetchTopRatedAllMovie())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.fetchTopRatedAllMovie();
      // assert
      expect(result,
          Left(FailureConnectionException('Failed to connect to the network')));
    });
  });

  group('Get Movie Detail', () {
    final tId = 1;
    final tMovieResponse = MovieDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      budget: 100,
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: "https://google.com",
      id: 1,
      imdbId: 'imdb1',
      originalLanguage: 'en',
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      revenue: 12000,
      runtime: 120,
      status: 'Status',
      tagline: 'Tagline',
      title: 'title',
      video: false,
      voteAverage: 1,
      voteCount: 1,
    );

    test(
        'should return Movie data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.fetchMovieDataDetail(tId))
          .thenAnswer((_) async => tMovieResponse);
      // act
      final result = await repository.fetchMovieDataDetail(tId);
      // assert
      verify(mockRemoteDataSource.fetchMovieDataDetail(tId));
      expect(result, equals(Right(testMovieDetail)));
    });

    test(
        'should return Server FailureException when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.fetchMovieDataDetail(tId))
          .thenThrow(ErrorServerFoundException());
      // act
      final result = await repository.fetchMovieDataDetail(tId);
      // assert
      verify(mockRemoteDataSource.fetchMovieDataDetail(tId));
      expect(result, equals(Left(FailureServerException(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.fetchMovieDataDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.fetchMovieDataDetail(tId);
      // assert
      verify(mockRemoteDataSource.fetchMovieDataDetail(tId));
      expect(
          result,
          equals(Left(
              FailureConnectionException('Failed to connect to the network'))));
    });
  });

  group('Get Movie Recommendations', () {
    final tMovieList = <MovieModel>[];
    final tId = 1;

    test('should return data (movie list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.fetchMovieDataRecommendations(tId))
          .thenAnswer((_) async => tMovieList);
      // act
      final result = await repository.fetchMovieDataRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.fetchMovieDataRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tMovieList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.fetchMovieDataRecommendations(tId))
          .thenThrow(ErrorServerFoundException());
      // act
      final result = await repository.fetchMovieDataRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.fetchMovieDataRecommendations(tId));
      expect(result, equals(Left(FailureServerException(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.fetchMovieDataRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.fetchMovieDataRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.fetchMovieDataRecommendations(tId));
      expect(
          result,
          equals(Left(
              FailureConnectionException('Failed to connect to the network'))));
    });
  });

  group('Search Movies', () {
    final tQuery = 'spiderman';

    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.findAllMovies(tQuery))
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.findAllMovies(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test(
        'should return FailureServerException when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.findAllMovies(tQuery))
          .thenThrow(ErrorServerFoundException());
      // act
      final result = await repository.findAllMovies(tQuery);
      // assert
      expect(result, Left(FailureServerException('')));
    });

    test(
        'should return FailureConnectionException when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.findAllMovies(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.findAllMovies(tQuery);
      // assert
      expect(result,
          Left(FailureConnectionException('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.addToWatchList(testMovieTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testMovieDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return FailureDatabaseException when saving unsuccessful',
        () async {
      // arrange
      when(mockLocalDataSource.addToWatchList(testMovieTable))
          .thenThrow(ErrorDatabaseFoundException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testMovieDetail);
      // assert
      expect(result, Left(FailureDatabaseException('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.deleteFromWatchList(testMovieTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.deleteFromWatchList(testMovieDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return FailureDatabaseException when remove unsuccessful',
        () async {
      // arrange
      when(mockLocalDataSource.deleteFromWatchList(testMovieTable))
          .thenThrow(ErrorDatabaseFoundException('Failed to remove watchlist'));
      // act
      final result = await repository.deleteFromWatchList(testMovieDetail);
      // assert
      expect(
          result, Left(FailureDatabaseException('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.fetchMovieDataById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchListorNot(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist movies', () {
    test('should return list of Movies', () async {
      // arrange
      when(mockLocalDataSource.getAllWatchListMovie())
          .thenAnswer((_) async => [testMovieTable]);
      // act
      final result = await repository.getAllWatchListMovie();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistMovie]);
    });
  });
}
