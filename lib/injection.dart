import 'package:ditonton/common/ssl_pinning.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv_series_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_tv_series_watchlist.dart';
import 'package:ditonton/domain/usecases/get_tv_series_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_series_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_cubit.dart';
import 'package:ditonton/presentation/bloc/movie_list/movie_list_cubit.dart';
import 'package:ditonton/presentation/bloc/now_playing_tv_series/now_playing_tv_series_cubit.dart';
import 'package:ditonton/presentation/bloc/popular_movies/popular_movies_cubit.dart';
import 'package:ditonton/presentation/bloc/popular_tv_series/popular_tv_series_cubit.dart';
import 'package:ditonton/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/search_tv_series/search_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_series/top_rated_tv_series_cubit.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_cubit.dart';
import 'package:ditonton/presentation/bloc/tv_series_list/tv_series_list_cubit.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';

final locator = GetIt.instance;

Future<void> init() async {
  await _ioClient();
  _registerDomains();
}

Future<void> _ioClient() async {
  // ssl pinning
  IOClient ioClient = await SslPinning.ioClient;
  locator.registerLazySingleton<IOClient>(() => ioClient);
}

void _registerDomains() {
  // provider
  locator.registerFactory(
    () => MovieListCubit(
      fetchNowPlayingAllMovie: locator(),
      fetchPopularAllMovie: locator(),
      fetchTopRatedAllMovie: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesCubit(
      fetchPopularAllMovie: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesCubit(
      fetchTopRatedAllMovie: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailCubit(
      fetchMovieDataDetail: locator(),
      fetchMovieDataRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      deleteFromWatchList: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchMovieBloc(
      findAllMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesListCubit(
      fetchNowPlayingTvSeriesData: locator(),
      fetchPopularTvSeriesData: locator(),
      fetchTopRatedTvSeriesData: locator(),
    ),
  );
  locator.registerFactory(
    () => NowPlayingTvSeriesCubit(
      fetchNowPlayingTvSeriesData: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvSeriesCubit(
      fetchPopularTvSeriesData: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvSeriesCubit(
      fetchTopRatedTvSeriesData: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesDetailCubit(
      getTvSeriesDetail: locator(),
      fetchTvSeriesRecommendationsData: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      deleteFromWatchList: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchTvSeriesBloc(
      searchTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistCubit(
      getAllWatchListMovie: locator(),
      getAllTvSeriesWatchlist: locator(),
    ),
  );

  // use case
  // Movies
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  // TV Series
  locator.registerLazySingleton(
      () => GetNowPlayingTvSeries(tvSeriesRepository: locator()));
  locator.registerLazySingleton(
      () => GetPopularTvSeries(tvSeriesRepository: locator()));
  locator.registerLazySingleton(
      () => GetTopRatedTvSeries(tvSeriesRepository: locator()));
  locator.registerLazySingleton(
      () => GetTvSeriesDetail(tvSeriesRepository: locator()));
  locator.registerLazySingleton(
      () => SearchTvSeries(tvSeriesRepository: locator()));
  locator.registerLazySingleton(
      () => GetTvSeriesRecommendations(tvSeriesRepository: locator()));
  locator.registerLazySingleton(
      () => GetTvSeriesWatchlist(tvSeriesRepository: locator()));
  locator.registerLazySingleton(
      () => RemoveTvSeriesWatchlist(tvSeriesRepository: locator()));
  locator.registerLazySingleton(
      () => SaveTvSeriesWatchlist(tvSeriesRepository: locator()));
  locator.registerLazySingleton(
      () => GetTvSeriesWatchlistStatus(tvSeriesRepository: locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      tvSeriesRemoteDataSource: locator(),
      tvSeriesLocalDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
    () => TvSeriesLocalDataSourceImpl(
      databaseHelper: locator(),
    ),
  );

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
