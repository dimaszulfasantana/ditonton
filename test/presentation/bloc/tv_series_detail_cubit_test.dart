import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_details.dart';
import 'package:ditonton/domain/entities/tv_genre.dart';
import 'package:ditonton/domain/entities/tv_season.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_tv_series_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_series_watchlist.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_cubit.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_cubit_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesDetail,
  SaveTvSeriesWatchlist,
  RemoveTvSeriesWatchlist,
  GetTvSeriesWatchlistStatus,
  GetTvSeriesRecommendations,
])
void main() {
  late TvSeriesDetailCubit bloc;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockSaveTvSeriesWatchlist mockSaveTvSeriesWatchlist;
  late MockRemoveTvSeriesWatchlist mockRemoveTvSeriesWatchlist;
  late MockGetTvSeriesWatchlistStatus mockGetTvSeriesWatchlistStatus;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockSaveTvSeriesWatchlist = MockSaveTvSeriesWatchlist();
    mockRemoveTvSeriesWatchlist = MockRemoveTvSeriesWatchlist();
    mockGetTvSeriesWatchlistStatus = MockGetTvSeriesWatchlistStatus();
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    bloc = TvSeriesDetailCubit(
      getTvSeriesDetail: mockGetTvSeriesDetail,
      saveWatchlist: mockSaveTvSeriesWatchlist,
      deleteFromWatchList: mockRemoveTvSeriesWatchlist,
      getWatchListStatus: mockGetTvSeriesWatchlistStatus,
      fetchTvSeriesRecommendationsData: mockGetTvSeriesRecommendations,
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

  final emptyDetail = TvDetails(
    adult: false,
    backdropPath: "",
    createdBy: [],
    episodeRunTime: [],
    genres: [],
    homepage: "",
    id: 0,
    inProduction: false,
    languages: [],
    name: "",
    numberOfEpisodes: 0,
    numberOfSeasons: 0,
    originCountry: [],
    originalLanguage: "",
    originalName: "",
    overview: "",
    popularity: 0,
    posterPath: "",
    productionCountries: [],
    seasons: [],
    status: "",
    tagline: "",
    type: "",
    voteAverage: 0,
    voteCount: 0,
  );

  void _arrangeUsecase() {
    when(mockGetTvSeriesDetail.execute(id))
        .thenAnswer((_) async => Right(testTvSeriesDetail));
    when(mockGetTvSeriesRecommendations.execute(id))
        .thenAnswer((_) async => Right(tvSeriesList));
  }

  group('Get Tv Series Detail', () {
    blocTest<TvSeriesDetailCubit, TvSeriesDetailState>(
      'should get data from the usecase',
      build: () {
        _arrangeUsecase();
        return bloc;
      },
      act: (cubit) => cubit.fetchTvSeriesDetail(id),
      verify: (bloc) {
        mockGetTvSeriesDetail.execute(id);
        mockGetTvSeriesRecommendations.execute(id);
      },
    );

    blocTest<TvSeriesDetailCubit, TvSeriesDetailState>(
      'should change tv series detail and recommendations state to Loading then Loaded when usecase is called',
      build: () {
        _arrangeUsecase();
        return bloc;
      },
      act: (cubit) => cubit.fetchTvSeriesDetail(id),
      expect: () => [
        bloc.state.copyWith(
          tvSeriesDetailState: RequestState.Loading,
          recommendationsState: RequestState.Empty,
          tvSeriesDetail: emptyDetail,
          tvSeriesRecommendations: [],
        ),
        bloc.state.copyWith(
          recommendationsState: RequestState.Loading,
          tvSeriesDetailState: RequestState.Loaded,
          tvSeriesDetail: testTvSeriesDetail,
          tvSeriesRecommendations: [],
        ),
        bloc.state.copyWith(
          recommendationsState: RequestState.Loaded,
          tvSeriesDetailState: RequestState.Loaded,
          tvSeriesDetail: testTvSeriesDetail,
          tvSeriesRecommendations: tvSeriesList,
        ),
      ],
    );

    blocTest<TvSeriesDetailCubit, TvSeriesDetailState>(
        'should return error when get detail or recommendation tv series failed',
        build: () {
          when(mockGetTvSeriesDetail.execute(id))
              .thenAnswer((_) async => Left(ServerFailure('Failed')));
          when(mockGetTvSeriesRecommendations.execute(id))
              .thenAnswer((_) async => Left(ServerFailure('Failed')));
          return bloc;
        },
        act: (cubit) => cubit.fetchTvSeriesDetail(id),
        expect: () => [
              bloc.state.copyWith(
                tvSeriesDetailState: RequestState.Loading,
                message: '',
              ),
              bloc.state.copyWith(
                tvSeriesDetailState: RequestState.Error,
                message: 'Failed',
              ),
            ]);
  });

  group('Watchlist', () {
    blocTest<TvSeriesDetailCubit, TvSeriesDetailState>(
      'should get the watchlist status',
      build: () {
        when(mockGetTvSeriesWatchlistStatus.execute(id))
            .thenAnswer((_) async => true);
        return bloc;
      },
      act: (cubit) => cubit.loadWatchlistStatus(id),
      expect: () => [bloc.state.copyWith(isAddedToWatchlist: true)],
    );

    blocTest<TvSeriesDetailCubit, TvSeriesDetailState>(
      'should execute save watchlist when function called',
      build: () {
        when(mockSaveTvSeriesWatchlist.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Right('Success'));
        when(mockGetTvSeriesWatchlistStatus.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => true);
        return bloc;
      },
      act: (cubit) => cubit.addWatchlist(testTvSeriesDetail),
      verify: (cubit) => mockSaveTvSeriesWatchlist.execute(testTvSeriesDetail),
    );

    blocTest<TvSeriesDetailCubit, TvSeriesDetailState>(
      'should execute remove watchlist when function called',
      build: () {
        when(mockRemoveTvSeriesWatchlist.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Right('Removed'));
        when(mockGetTvSeriesWatchlistStatus.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (cubit) => cubit.removeFromWatchlist(testTvSeriesDetail),
      verify: (cubit) =>
          mockRemoveTvSeriesWatchlist.execute(testTvSeriesDetail),
    );

    blocTest<TvSeriesDetailCubit, TvSeriesDetailState>(
      'should update watchlist status when add watchlist success',
      build: () {
        when(mockSaveTvSeriesWatchlist.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        when(mockGetTvSeriesWatchlistStatus.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => true);
        return bloc;
      },
      act: (cubit) => cubit.addWatchlist(testTvSeriesDetail),
      verify: (cubit) =>
          mockGetTvSeriesWatchlistStatus.execute(testTvSeriesDetail.id),
      expect: () => [
        bloc.state.copyWith(
          isAddedToWatchlist: false,
          watchlistMessage: 'Added to Watchlist',
        ),
        bloc.state.copyWith(
          isAddedToWatchlist: true,
          watchlistMessage: 'Added to Watchlist',
        )
      ],
    );

    blocTest<TvSeriesDetailCubit, TvSeriesDetailState>(
      'should update watchlist status when add watchlist failed',
      build: () {
        when(mockSaveTvSeriesWatchlist.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(mockGetTvSeriesWatchlistStatus.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (cubit) => cubit.addWatchlist(testTvSeriesDetail),
      verify: (cubit) =>
          mockGetTvSeriesWatchlistStatus.execute(testTvSeriesDetail.id),
      expect: () => [
        bloc.state.copyWith(
          isAddedToWatchlist: false,
          watchlistMessage: 'Failed',
        ),
      ],
    );
  });
}
