import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies/top_rated_movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedMoviesCubit extends Cubit<TopRatedMoviesState> {
  final GetTopRatedMovies fetchTopRatedAllMovie;

  TopRatedMoviesCubit({
    required this.fetchTopRatedAllMovie,
  }) : super(TopRatedMoviesState(
          topRatedMoviesState: RequestState.Empty,
          topRatedMovies: [],
          message: "",
        ));

  Future<void> fetchTopRatedMovies() async {
    emit(state.copyWith(
        topRatedMoviesState: RequestState.Loading, topRatedMovies: []));
    final result = await fetchTopRatedAllMovie.execute();
    result.fold((failure) {
      emit(state.copyWith(
          topRatedMoviesState: RequestState.Error, message: failure.message));
    }, (result) {
      emit(state.copyWith(
          topRatedMoviesState: RequestState.Loaded, topRatedMovies: result));
    });
  }
}
