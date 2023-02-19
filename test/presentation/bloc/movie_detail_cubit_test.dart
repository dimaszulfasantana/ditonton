import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_cubit.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_cubit_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailCubit bloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    bloc = MovieDetailCubit(
        fetchMovieDataDetail: mockGetMovieDetail,
        fetchMovieDataRecommendations: mockGetMovieRecommendations,
        getWatchListStatus: mockGetWatchlistStatus,
        saveWatchlist: mockSaveWatchlist,
        deleteFromWatchList: mockRemoveWatchlist);
  });

  final tId = 1;

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovies = <Movie>[tMovie];
  final emptyDetail = MovieDetail(
    adult: false,
    backdropPath: "",
    genres: [],
    id: 0,
    originalTitle: "",
    overview: "",
    posterPath: "",
    releaseDate: "",
    runtime: 0,
    title: "",
    voteAverage: 0,
    voteCount: 0,
  );

  void _arrangeUsecase() {
    when(mockGetMovieDetail.execute(tId))
        .thenAnswer((_) async => Right(testMovieDetail));
    when(mockGetMovieRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tMovies));
  }

  group('Get Movie Detail', () {
    blocTest<MovieDetailCubit, MovieDetailState>(
      'should get data from the usecase',
      build: () {
        _arrangeUsecase();
        return bloc;
      },
      act: (cubit) => cubit.fetchMovieDetails(tId),
      verify: (bloc) {
        mockGetMovieDetail.execute(tId);
        mockGetMovieRecommendations.execute(tId);
      },
    );

    blocTest<MovieDetailCubit, MovieDetailState>(
      'should change movie detail and recommendations state to Loading then Loaded when usecase is called',
      build: () {
        _arrangeUsecase();
        return bloc;
      },
      act: (cubit) => cubit.fetchMovieDetails(tId),
      expect: () => [
        bloc.state.copyWith(
          movieDetailState: RequestState.Loading,
          stateAllRecommendationTvSeries: RequestState.Empty,
          movieDetail: emptyDetail,
          movieRecommendations: [],
        ),
        bloc.state.copyWith(
          stateAllRecommendationTvSeries: RequestState.Loading,
          movieDetailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
          movieRecommendations: [],
        ),
        bloc.state.copyWith(
          stateAllRecommendationTvSeries: RequestState.Loaded,
          movieDetailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
          movieRecommendations: tMovies,
        ),
      ],
    );

    blocTest<MovieDetailCubit, MovieDetailState>(
        'should return error when get detail or recommendation movies failed',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => Left(FailureServerException('Failed')));
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => Left(FailureServerException('Failed')));
          return bloc;
        },
        act: (cubit) => cubit.fetchMovieDetails(tId),
        expect: () => [
              bloc.state.copyWith(
                movieDetailState: RequestState.Loading,
                message: '',
              ),
              bloc.state.copyWith(
                movieDetailState: RequestState.Error,
                message: 'Failed',
              ),
            ]);
  });

  group('Watchlist', () {
    blocTest<MovieDetailCubit, MovieDetailState>(
      'should get the watchlist status',
      build: () {
        when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
        return bloc;
      },
      act: (cubit) => cubit.loadWatchlistStatus(tId),
      expect: () => [bloc.state.copyWith(isAddedToWatchListorNot: true)],
    );

    blocTest<MovieDetailCubit, MovieDetailState>(
      'should execute save watchlist when function called',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Success'));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return bloc;
      },
      act: (cubit) => cubit.addWatchlist(testMovieDetail),
      verify: (cubit) => mockSaveWatchlist.execute(testMovieDetail),
    );

    blocTest<MovieDetailCubit, MovieDetailState>(
      'should execute remove watchlist when function called',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Removed'));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (cubit) => cubit.removeFromWatchlist(testMovieDetail),
      verify: (cubit) => mockRemoveWatchlist.execute(testMovieDetail),
    );

    blocTest<MovieDetailCubit, MovieDetailState>(
      'should update watchlist status when add watchlist success',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return bloc;
      },
      act: (cubit) => cubit.addWatchlist(testMovieDetail),
      verify: (cubit) => mockGetWatchlistStatus.execute(testMovieDetail.id),
      expect: () => [
        bloc.state.copyWith(
          isAddedToWatchListorNot: false,
          allWatchedListMessage: 'Added to Watchlist',
        ),
        bloc.state.copyWith(
          isAddedToWatchListorNot: true,
          allWatchedListMessage: 'Added to Watchlist',
        )
      ],
    );

    blocTest<MovieDetailCubit, MovieDetailState>(
      'should update watchlist status when add watchlist failed',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(FailureDatabaseException('Failed')));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (cubit) => cubit.addWatchlist(testMovieDetail),
      verify: (cubit) => mockGetWatchlistStatus.execute(testMovieDetail.id),
      expect: () => [
        bloc.state.copyWith(
          isAddedToWatchListorNot: false,
          allWatchedListMessage: 'Failed',
        ),
      ],
    );
  });
}
