import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_series_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource =
        TvSeriesLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('insert tv series watchlist', () {
    test('should return success message when insert to database', () async {
      // arrange
      when(mockDatabaseHelper.insertTvWatchlist(testTvSeriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.addToWatchList(testTvSeriesTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test(
        'should throw ErrorDatabaseFoundException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTvWatchlist(testTvSeriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.addToWatchList(testTvSeriesTable);
      // assert
      expect(() => call, throwsA(isA<ErrorDatabaseFoundException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTvWatchlist(testTvSeriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.deleteFromWatchList(testTvSeriesTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test(
        'should throw ErrorDatabaseFoundException when remove to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTvWatchlist(testTvSeriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.deleteFromWatchList(testTvSeriesTable);
      // assert
      expect(() => call, throwsA(isA<ErrorDatabaseFoundException>()));
    });
  });

  group('get tv series by id', () {
    final id = 1;

    test('should return tv series detail when data is found', () async {
      // arrange
      when(mockDatabaseHelper.fetchTvSeriesDataById(id))
          .thenAnswer((_) async => testTvSeriesMap);
      // act
      final result = await dataSource.fetchTvSeriesDataById(id);
      // assert
      expect(result, testTvSeriesTable);
    });

    test('should return null if data not found in database', () async {
      // arrange
      when(mockDatabaseHelper.fetchTvSeriesDataById(id))
          .thenAnswer((_) async => null);
      // act
      final result = await dataSource.fetchTvSeriesDataById(id);
      // assert
      expect(result, null);
    });
  });

  group('get tv series watchlist', () {
    test('should return list of TvSeriesTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getTvWatchlistMovies())
          .thenAnswer((_) async => [testTvSeriesMap]);
      // act
      final result = await dataSource.fetchWatchListTvDataSeries();
      // assert
      expect(result, [testTvSeriesTable]);
    });
  });
}
