import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/popular_movies/popular_movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  final GetPopularMovies fetchPopularAllMovie;

  PopularMoviesCubit({
    required this.fetchPopularAllMovie,
  }) : super(PopularMoviesState(
          statePopularAllMoviesData: RequestState.Empty,
          allPopularMoviesData: [],
          message: "",
        ));

  Future<void> fetchPopularMovies() async {
    emit(state.copyWith(
        statePopularAllMoviesData: RequestState.Loading,
        allPopularMoviesData: []));
    final result = await fetchPopularAllMovie.execute();
    result.fold((failure) {
      emit(state.copyWith(
          statePopularAllMoviesData: RequestState.Error,
          message: failure.message));
    }, (result) {
      emit(state.copyWith(
          statePopularAllMoviesData: RequestState.Loaded,
          allPopularMoviesData: result));
    });
  }
}
