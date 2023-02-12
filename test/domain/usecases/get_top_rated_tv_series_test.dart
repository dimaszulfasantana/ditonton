import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTvSeries fetchTopRatedTvSeriesData;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    fetchTopRatedTvSeriesData =
        GetTopRatedTvSeries(tvSeriesRepository: mockTvSeriesRepository);
  });

  List<TvSeries> topRatedTvSeries = [];

  test('should return top rated tv series list when get from repository',
      () async {
    // arrange
    when(mockTvSeriesRepository.fetchTopRatedTvSeriesData())
        .thenAnswer((_) async => Right(topRatedTvSeries));
    // act
    final result = await fetchTopRatedTvSeriesData.execute();
    // assert
    expect(result, Right(topRatedTvSeries));
  });
}
