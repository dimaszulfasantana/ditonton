import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/popular_movies/popular_movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  final GetPopularMovies fetchPopularAllMovie;

  PopularMoviesCubit({
    required this.fetchPopularAllMovie,
  }) : super(PopularMoviesState(
          popularMoviesState: RequestState.Empty,
          popularMovies: [],
          message: "",
        ));

  Future<void> fetchPopularMovies() async {
    emit(state
        .copyWith(popularMoviesState: RequestState.Loading, popularMovies: []));
    final result = await fetchPopularAllMovie.execute();
    result.fold((failure) {
      emit(state.copyWith(
          popularMoviesState: RequestState.Error, message: failure.message));
    }, (result) {
      emit(state.copyWith(
          popularMoviesState: RequestState.Loaded, popularMovies: result));
    });
  }
}
