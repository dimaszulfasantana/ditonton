import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:ditonton/presentation/bloc/now_playing_tv_series/now_playing_tv_series_cubit.dart';
import 'package:ditonton/presentation/bloc/now_playing_tv_series/now_playing_tv_series_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'now_playing_tv_series_cubit_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingTvSeries,
])
void main() {
  late NowPlayingTvSeriesCubit bloc;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
  setUp(() {
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    bloc = NowPlayingTvSeriesCubit(
      fetchNowPlayingTvSeriesData: mockGetNowPlayingTvSeries,
    );
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

  group('Now Playing Tv Series', () {
    blocTest<NowPlayingTvSeriesCubit, NowPlayingTvSeriesState>(
      'should return data from usecase',
      build: () {
        when(mockGetNowPlayingTvSeries.execute())
            .thenAnswer((_) async => Right(tvSeriesList));
        return bloc;
      },
      act: (cubit) => cubit.fetchNowPlayingTvSeries(),
      verify: (cubit) {
        mockGetNowPlayingTvSeries.execute();
      },
    );

    blocTest<NowPlayingTvSeriesCubit, NowPlayingTvSeriesState>(
        'should change state to loading then loaded when function called',
        build: () {
          when(mockGetNowPlayingTvSeries.execute())
              .thenAnswer((_) async => Right(tvSeriesList));
          return bloc;
        },
        act: (cubit) => cubit.fetchNowPlayingTvSeries(),
        expect: () => [
              bloc.state.copyWith(
                nowPlayingState: RequestState.Loading,
                nowPlayingList: [],
              ),
              bloc.state.copyWith(
                nowPlayingState: RequestState.Loaded,
                nowPlayingList: tvSeriesList,
              )
            ]);

    blocTest<NowPlayingTvSeriesCubit, NowPlayingTvSeriesState>(
        'should return failure and error state when fetch now playing failed',
        build: () {
          when(mockGetNowPlayingTvSeries.execute())
              .thenAnswer((_) async => Left(ServerFailure('Failed')));
          return bloc;
        },
        act: (cubit) => cubit.fetchNowPlayingTvSeries(),
        expect: () => [
              bloc.state.copyWith(
                nowPlayingState: RequestState.Loading,
                message: '',
              ),
              bloc.state.copyWith(
                nowPlayingState: RequestState.Error,
                message: 'Failed',
              )
            ]);
  });
}
