import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movie_list/movie_list_state.dart';

class MovieListCubit extends Cubit<MovieListState> {
  final GetNowPlayingMovies fetchNowPlayingAllMovie;
  final GetPopularMovies fetchPopularAllMovie;
  final GetTopRatedMovies fetchTopRatedAllMovie;

  MovieListCubit({
    required this.fetchNowPlayingAllMovie,
    required this.fetchPopularAllMovie,
    required this.fetchTopRatedAllMovie,
  }) : super(MovieListState(
          stateNowPlaying: RequestState.Empty,
          statePopularTvSeries: RequestState.Empty,
          stateTopRatedTvSeries: RequestState.Empty,
          allNowPlayingList: [],
          allPopularList: [],
          allTopRatedList: [],
        ));

  Future<void> fetchNowPlayingMovies() async {
    emit(state.copyWith(
        stateNowPlaying: RequestState.Loading, allNowPlayingList: []));
    final result = await fetchNowPlayingAllMovie.execute();
    result.fold((failure) {
      emit(state.copyWith(stateNowPlaying: RequestState.Error));
    }, (result) {
      emit(state.copyWith(
          stateNowPlaying: RequestState.Loaded, allNowPlayingList: result));
    });
  }

  Future<void> fetchPopularMovies() async {
    emit(state.copyWith(
        statePopularTvSeries: RequestState.Loading, allPopularList: []));
    final result = await fetchPopularAllMovie.execute();
    result.fold((failure) {
      emit(state.copyWith(statePopularTvSeries: RequestState.Error));
    }, (result) {
      emit(state.copyWith(
          statePopularTvSeries: RequestState.Loaded, allPopularList: result));
    });
  }

  Future<void> fetchTopRatedMovies() async {
    emit(state.copyWith(
        stateTopRatedTvSeries: RequestState.Loading, allTopRatedList: []));
    final result = await fetchTopRatedAllMovie.execute();
    result.fold((failure) {
      emit(state.copyWith(stateTopRatedTvSeries: RequestState.Error));
    }, (result) {
      emit(state.copyWith(
          stateTopRatedTvSeries: RequestState.Loaded, allTopRatedList: result));
    });
  }
}
