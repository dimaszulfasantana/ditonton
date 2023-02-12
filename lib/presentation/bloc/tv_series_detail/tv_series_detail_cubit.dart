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
          tvSeriesDetailState: RequestState.Empty,
          tvSeriesDetail: TvDetails(
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
          isAddedToWatchlist: false,
          tvSeriesRecommendations: [],
          recommendationsState: RequestState.Empty,
          watchlistMessage: "",
          message: "",
        ));

  Future<void> fetchTvSeriesDetail(int id) async {
    emit(state.copyWith(tvSeriesDetailState: RequestState.Loading));
    final detailResult = await getTvSeriesDetail.execute(id);
    final recommendationsResult =
        await fetchTvSeriesRecommendationsData.execute(id);
    detailResult.fold((failure) {
      emit(state.copyWith(
          tvSeriesDetailState: RequestState.Error, message: failure.message));
    }, (detailResult) {
      emit(state.copyWith(
        recommendationsState: RequestState.Loading,
        tvSeriesDetailState: RequestState.Loaded,
        tvSeriesDetail: detailResult,
      ));
      recommendationsResult.fold((failure) {
        emit(state.copyWith(recommendationsState: RequestState.Error));
      }, (recommendationsResult) {
        emit(state.copyWith(
          recommendationsState: RequestState.Loaded,
          tvSeriesRecommendations: recommendationsResult,
        ));
      });
    });
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    emit(state.copyWith(isAddedToWatchlist: result));
  }

  Future<void> addWatchlist(TvDetails tvSeries) async {
    final result = await saveWatchlist.execute(tvSeries);
    result.fold((failure) {
      emit(state.copyWith(watchlistMessage: failure.message));
    }, (result) {
      emit(state.copyWith(watchlistMessage: result));
    });

    await loadWatchlistStatus(tvSeries.id);
  }

  Future<void> removeFromWatchlist(TvDetails tvSeries) async {
    final result = await deleteFromWatchList.execute(tvSeries);
    result.fold((failure) {
      emit(state.copyWith(watchlistMessage: failure.message));
    }, (result) {
      emit(state.copyWith(watchlistMessage: result));
    });

    await loadWatchlistStatus(tvSeries.id);
  }
}
