import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_list/tv_series_list_cubit.dart';
import 'package:ditonton/presentation/bloc/tv_series_list/tv_series_list_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'now_playing_tv_series_cubit_test.mocks.dart';
import 'popular_tv_series_cubit_test.mocks.dart';
import 'top_rated_tv_series_cubit_test.mocks.dart';

// import 'tv_series_list_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingTvSeries,
  GetPopularTvSeries,
  GetTopRatedTvSeries,
])
void main() {
  late TvSeriesListCubit bloc;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  setUp(() {
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    bloc = TvSeriesListCubit(
      fetchNowPlayingTvSeriesData: mockGetNowPlayingTvSeries,
      fetchPopularTvSeriesData: mockGetPopularTvSeries,
      fetchTopRatedTvSeriesData: mockGetTopRatedTvSeries,
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
    blocTest<TvSeriesListCubit, TvSeriesListState>(
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

    blocTest<TvSeriesListCubit, TvSeriesListState>(
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

    blocTest<TvSeriesListCubit, TvSeriesListState>(
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

  group('Popular Tv Series', () {
    blocTest<TvSeriesListCubit, TvSeriesListState>(
      'should return data from usecase',
      build: () {
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Right(tvSeriesList));
        return bloc;
      },
      act: (cubit) => cubit.fetchPopularTvSeries(),
      verify: (cubit) {
        mockGetPopularTvSeries.execute();
      },
    );

    blocTest<TvSeriesListCubit, TvSeriesListState>(
        'should change state to loading then loaded when function called',
        build: () {
          when(mockGetPopularTvSeries.execute())
              .thenAnswer((_) async => Right(tvSeriesList));
          return bloc;
        },
        act: (cubit) => cubit.fetchPopularTvSeries(),
        expect: () => [
              bloc.state.copyWith(
                popularState: RequestState.Loading,
                popularList: [],
              ),
              bloc.state.copyWith(
                popularState: RequestState.Loaded,
                popularList: tvSeriesList,
              )
            ]);

    blocTest<TvSeriesListCubit, TvSeriesListState>(
        'should return failure and error state when fetch now playing failed',
        build: () {
          when(mockGetPopularTvSeries.execute())
              .thenAnswer((_) async => Left(ServerFailure('Failed')));
          return bloc;
        },
        act: (cubit) => cubit.fetchPopularTvSeries(),
        expect: () => [
              bloc.state.copyWith(
                popularState: RequestState.Loading,
                message: '',
              ),
              bloc.state.copyWith(
                popularState: RequestState.Error,
                message: 'Failed',
              )
            ]);
  });

  group('Top Rated Tv Series', () {
    blocTest<TvSeriesListCubit, TvSeriesListState>(
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

    blocTest<TvSeriesListCubit, TvSeriesListState>(
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

    blocTest<TvSeriesListCubit, TvSeriesListState>(
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
