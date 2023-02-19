import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_details.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_tv_series_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_series_watchlist.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvSeriesDetailCubit extends Cubit<TvSeriesDetailState> {
  static final watchlistAddSuccessMessage = 'Added to Watchlist';
  static final watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendations fetchTvSeriesRecommendationsData;
  final GetTvSeriesWatchlistStatus getWatchListStatus;
  final SaveTvSeriesWatchlist saveWatchlist;
  final RemoveTvSeriesWatchlist deleteFromWatchList;

  TvSeriesDetailCubit({
    required this.getTvSeriesDetail,
    required this.fetchTvSeriesRecommendationsData,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.deleteFromWatchList,
  }) : super(TvSeriesDetailState(
          stateAllTvSeriesDetail: RequestState.Empty,
          allTvSeriesDetail: TvDetails(
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
          ),
          isAddedToWatchListorNot: false,
          allTvSeriesRecommendations: [],
          stateAllRecommendationTvSeries: RequestState.Empty,
          allWatchedListMessage: "",
          message: "",
        ));

  Future<void> fetchTvSeriesDetail(int id) async {
    emit(state.copyWith(stateAllTvSeriesDetail: RequestState.Loading));
    final detailResult = await getTvSeriesDetail.execute(id);
    final recommendationsResult =
        await fetchTvSeriesRecommendationsData.execute(id);
    detailResult.fold((failure) {
      emit(state.copyWith(
          stateAllTvSeriesDetail: RequestState.Error,
          message: failure.message));
    }, (detailResult) {
      emit(state.copyWith(
        stateAllRecommendationTvSeries: RequestState.Loading,
        stateAllTvSeriesDetail: RequestState.Loaded,
        allTvSeriesDetail: detailResult,
      ));
      recommendationsResult.fold((failure) {
        emit(
            state.copyWith(stateAllRecommendationTvSeries: RequestState.Error));
      }, (recommendationsResult) {
        emit(state.copyWith(
          stateAllRecommendationTvSeries: RequestState.Loaded,
          allTvSeriesRecommendations: recommendationsResult,
        ));
      });
    });
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    emit(state.copyWith(isAddedToWatchListorNot: result));
  }

  Future<void> addWatchlist(TvDetails tvSeries) async {
    final result = await saveWatchlist.execute(tvSeries);
    result.fold((failure) {
      emit(state.copyWith(allWatchedListMessage: failure.message));
    }, (result) {
      emit(state.copyWith(allWatchedListMessage: result));
    });

    await loadWatchlistStatus(tvSeries.id);
  }

  Future<void> removeFromWatchlist(TvDetails tvSeries) async {
    final result = await deleteFromWatchList.execute(tvSeries);
    result.fold((failure) {
      emit(state.copyWith(allWatchedListMessage: failure.message));
    }, (result) {
      emit(state.copyWith(allWatchedListMessage: result));
    });

    await loadWatchlistStatus(tvSeries.id);
  }
}
