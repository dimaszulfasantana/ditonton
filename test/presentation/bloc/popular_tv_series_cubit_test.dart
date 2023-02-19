import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/presentation/bloc/popular_tv_series/popular_tv_series_cubit.dart';
import 'package:ditonton/presentation/bloc/popular_tv_series/popular_tv_series_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tv_series_cubit_test.mocks.dart';

@GenerateMocks([
  GetPopularTvSeries,
])
void main() {
  late PopularTvSeriesCubit bloc;
  late MockGetPopularTvSeries mockGetPopularTvSeries;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    bloc =
        PopularTvSeriesCubit(fetchPopularTvSeriesData: mockGetPopularTvSeries);
  });

  final id = 1;

  final tvSeries = TvSeries(
      backdropPath: "/8Xs20y8gFR0W9u8Yy9NKdpZtSu7.jpg",
      firstAirDate: "2022-01-28",
      genreIds: [1, 2, 3],
      id: id,
      name: "All of Us Are Dead",
      originCountry: ["KR"],
      originalLanguage: "ko",
      originalName: "test",
      overview: "overview",
      popularity: 1,
      posterPath: "/6zUUtzj7aJzOdoxhpiGzEKYtj1o.jpg",
      voteAverage: 1,
      voteCount: 1);

  final allTvSeriesList = <TvSeries>[tvSeries];

  group('Popular Tv Series', () {
    blocTest<PopularTvSeriesCubit, PopularTvSeriesState>(
      'should return data from usecase',
      build: () {
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Right(allTvSeriesList));
        return bloc;
      },
      act: (cubit) => cubit.fetchPopularTvSeries(),
      verify: (cubit) {
        mockGetPopularTvSeries.execute();
      },
    );

    blocTest<PopularTvSeriesCubit, PopularTvSeriesState>(
        'should change state to loading then loaded when function called',
        build: () {
          when(mockGetPopularTvSeries.execute())
              .thenAnswer((_) async => Right(allTvSeriesList));
          return bloc;
        },
        act: (cubit) => cubit.fetchPopularTvSeries(),
        expect: () => [
              bloc.state.copyWith(
                statePopularTvSeries: RequestState.Loading,
                allPopularList: [],
              ),
              bloc.state.copyWith(
                statePopularTvSeries: RequestState.Loaded,
                allPopularList: allTvSeriesList,
              )
            ]);

    blocTest<PopularTvSeriesCubit, PopularTvSeriesState>(
        'should return failure and error state when fetch now playing failed',
        build: () {
          when(mockGetPopularTvSeries.execute())
              .thenAnswer((_) async => Left(FailureServerException('Failed')));
          return bloc;
        },
        act: (cubit) => cubit.fetchPopularTvSeries(),
        expect: () => [
              bloc.state.copyWith(
                statePopularTvSeries: RequestState.Loading,
                message: '',
              ),
              bloc.state.copyWith(
                statePopularTvSeries: RequestState.Error,
                message: 'Failed',
              )
            ]);
  });
}
