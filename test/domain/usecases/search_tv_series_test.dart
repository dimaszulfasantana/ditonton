import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvSeries searchTvSeries;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    searchTvSeries = SearchTvSeries(tvSeriesRepository: mockTvSeriesRepository);
  });

  final query = 'Drama';
  final tvSeriesList = <TvSeries>[];

  test('should return popular tv series list when get from repository',
      () async {
    // arrange
    when(mockTvSeriesRepository.fetchSearchTvSeriesData(query))
        .thenAnswer((_) async => Right(tvSeriesList));
    // act
    final result = await searchTvSeries.execute(query);
    // assert
    expect(result, Right(tvSeriesList));
  });
}
