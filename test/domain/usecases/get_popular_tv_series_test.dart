import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvSeries fetchPopularTvSeriesData;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    fetchPopularTvSeriesData =
        GetPopularTvSeries(tvSeriesRepository: mockTvSeriesRepository);
  });

  List<TvSeries> popularTvSeries = [];

  test('should return popular tv series list when get from repository',
      () async {
    // arrange
    when(mockTvSeriesRepository.fetchPopularTvSeriesData())
        .thenAnswer((_) async => Right(popularTvSeries));
    // act
    final result = await fetchPopularTvSeriesData.execute();
    // assert
    expect(result, Right(popularTvSeries));
  });
}
