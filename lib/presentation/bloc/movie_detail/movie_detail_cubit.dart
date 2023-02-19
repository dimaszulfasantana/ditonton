import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  static final watchlistAddSuccessMessage = 'Added to Watchlist';
  static final watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail fetchMovieDataDetail;
  final GetMovieRecommendations fetchMovieDataRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist deleteFromWatchList;

  MovieDetailCubit({
    required this.fetchMovieDataDetail,
    required this.fetchMovieDataRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.deleteFromWatchList,
  }) : super(MovieDetailState(
          movieDetailState: RequestState.Empty,
          movieDetail: MovieDetail(
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
          ),
          isAddedToWatchListorNot: false,
          movieRecommendations: [],
          stateAllRecommendationTvSeries: RequestState.Empty,
          allWatchedListMessage: "",
          message: "",
        ));

  Future<void> fetchMovieDetails(int id) async {
    emit(state.copyWith(movieDetailState: RequestState.Loading));
    final detailResult = await fetchMovieDataDetail.execute(id);
    final recommendationsResult =
        await fetchMovieDataRecommendations.execute(id);
    detailResult.fold((failure) {
      emit(state.copyWith(
          movieDetailState: RequestState.Error, message: failure.message));
    }, (detailResult) {
      emit(state.copyWith(
        stateAllRecommendationTvSeries: RequestState.Loading,
        movieDetailState: RequestState.Loaded,
        movieDetail: detailResult,
      ));
      recommendationsResult.fold((failure) {
        emit(
            state.copyWith(stateAllRecommendationTvSeries: RequestState.Error));
      }, (recommendationsResult) {
        emit(state.copyWith(
          stateAllRecommendationTvSeries: RequestState.Loaded,
          movieRecommendations: recommendationsResult,
        ));
      });
    });
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    emit(state.copyWith(isAddedToWatchListorNot: result));
  }

  Future<void> addWatchlist(MovieDetail movie) async {
    final result = await saveWatchlist.execute(movie);
    result.fold((failure) {
      emit(state.copyWith(allWatchedListMessage: failure.message));
    }, (result) {
      emit(state.copyWith(allWatchedListMessage: result));
    });

    await loadWatchlistStatus(movie.id);
  }

  Future<void> removeFromWatchlist(MovieDetail movie) async {
    final result = await deleteFromWatchList.execute(movie);
    result.fold((failure) {
      emit(state.copyWith(allWatchedListMessage: failure.message));
    }, (result) {
      emit(state.copyWith(allWatchedListMessage: result));
    });

    await loadWatchlistStatus(movie.id);
  }
}
