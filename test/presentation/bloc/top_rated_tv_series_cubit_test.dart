import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_series/top_rated_tv_series_cubit.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_series/top_rated_tv_series_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tv_series_cubit_test.mocks.dart';

@GenerateMocks([
  GetTopRatedTvSeries,
])
void main() {
  late TopRatedTvSeriesCubit bloc;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    bloc = TopRatedTvSeriesCubit(
        fetchTopRatedTvSeriesData: mockGetTopRatedTvSeries);
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

  final tvSeriesList = <TvSeries>[tvSeries];

  group('Top Rated Tv Series', () {
    blocTest<TopRatedTvSeriesCubit, TopRatedTvSeriesState>(
      'should return data from usecase',
      build: () {
        when(mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Right(tvSeriesList));
        return bloc;
      },
      act: (cubit) => cubit.fetchTopRatedTvSeries(),
      verify: (cubit) {
        mockGetTopRatedTvSeries.execute();
      },
    );

    blocTest<TopRatedTvSeriesCubit, TopRatedTvSeriesState>(
        'should change state to loading then loaded when function called',
        build: () {
          when(mockGetTopRatedTvSeries.execute())
              .thenAnswer((_) async => Right(tvSeriesList));
          return bloc;
        },
        act: (cubit) => cubit.fetchTopRatedTvSeries(),
        expect: () => [
              bloc.state.copyWith(
                topRatedState: RequestState.Loading,
                topRatedList: [],
              ),
              bloc.state.copyWith(
                topRatedState: RequestState.Loaded,
                topRatedList: tvSeriesList,
              )
            ]);

    blocTest<TopRatedTvSeriesCubit, TopRatedTvSeriesState>(
        'should return failure and error state when fetch now playing failed',
        build: () {
          when(mockGetTopRatedTvSeries.execute())
              .thenAnswer((_) async => Left(ServerFailure('Failed')));
          return bloc;
        },
        act: (cubit) => cubit.fetchTopRatedTvSeries(),
        expect: () => [
              bloc.state.copyWith(
                topRatedState: RequestState.Loading,
                message: '',
              ),
              bloc.state.copyWith(
                topRatedState: RequestState.Error,
                message: 'Failed',
              )
            ]);
  });
}
