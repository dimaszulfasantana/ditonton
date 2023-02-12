import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_watchlist.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_cubit.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_movie_cubit_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies, GetTvSeriesWatchlist])
void main() {
  late WatchlistCubit bloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetTvSeriesWatchlist mockGetTvSeriesWatchlist;
  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetTvSeriesWatchlist = MockGetTvSeriesWatchlist();
    bloc = WatchlistCubit(
        fetchWatchListAllMovie: mockGetWatchlistMovies,
        getTvSeriesWatchlist: mockGetTvSeriesWatchlist);
  });

  final id = 1;

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: id,
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
  final tMovieList = <Movie>[tMovie];

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

  group('movies watchlist', () {
    blocTest<WatchlistCubit, WatchlistState>('should return data from usecase',
        build: () {
          when(mockGetWatchlistMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));
          return bloc;
        },
        act: (cubit) => cubit.fetchMoviesWatchlist(),
        verify: (cubit) {
          mockGetWatchlistMovies.execute();
        });

    blocTest<WatchlistCubit, WatchlistState>(
        'should change state to loading then loaded when success',
        build: () {
          when(mockGetWatchlistMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));
          return bloc;
        },
        act: (cubit) => cubit.fetchMoviesWatchlist(),
        expect: () => [
              bloc.state.copyWith(
                watchlistMovieState: RequestState.Loading,
                movieList: [],
              ),
              bloc.state.copyWith(
                watchlistMovieState: RequestState.Loaded,
                movieList: tMovieList,
              ),
            ]);

    blocTest<WatchlistCubit, WatchlistState>(
        'should change state to error when failed',
        build: () {
          when(mockGetWatchlistMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure('Failed')));
          return bloc;
        },
        act: (cubit) => cubit.fetchMoviesWatchlist(),
        expect: () => [
              bloc.state.copyWith(
                watchlistMovieState: RequestState.Loading,
                message: '',
              ),
              bloc.state.copyWith(
                watchlistMovieState: RequestState.Error,
                message: 'Failed',
              ),
            ]);
  });

  group('tv series watchlist', () {
    blocTest<WatchlistCubit, WatchlistState>('should return data from usecase',
        build: () {
          when(mockGetTvSeriesWatchlist.execute())
              .thenAnswer((_) async => Right(tvSeriesList));
          return bloc;
        },
        act: (cubit) => cubit.fetchTvSeriesWatchlist(),
        verify: (cubit) {
          mockGetTvSeriesWatchlist.execute();
        });

    blocTest<WatchlistCubit, WatchlistState>(
        'should change state to loading then loaded when success',
        build: () {
          when(mockGetTvSeriesWatchlist.execute())
              .thenAnswer((_) async => Right(tvSeriesList));
          return bloc;
        },
        act: (cubit) => cubit.fetchTvSeriesWatchlist(),
        expect: () => [
              bloc.state.copyWith(
                watchlistTvSeriesState: RequestState.Loading,
                tvSeriesList: [],
              ),
              bloc.state.copyWith(
                watchlistTvSeriesState: RequestState.Loaded,
                tvSeriesList: tvSeriesList,
              ),
            ]);

    blocTest<WatchlistCubit, WatchlistState>(
        'should change state to error when failed',
        build: () {
          when(mockGetTvSeriesWatchlist.execute())
              .thenAnswer((_) async => Left(ServerFailure('Failed')));
          return bloc;
        },
        act: (cubit) => cubit.fetchTvSeriesWatchlist(),
        expect: () => [
              bloc.state.copyWith(
                watchlistTvSeriesState: RequestState.Loading,
                message: '',
              ),
              bloc.state.copyWith(
                watchlistTvSeriesState: RequestState.Error,
                message: 'Failed',
              ),
            ]);
  });
}
