import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/bloc/search_movie/search_movie_event.dart';
import 'package:ditonton/presentation/bloc/search_movie/search_movie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovies findAllMovies;
  SearchMovieBloc({
    required this.findAllMovies,
  }) : super(SearchMovieState(
          stateSearchMovieDataState: RequestState.Empty,
          allMovieList: [],
          message: '',
        )) {
    on<SearchMovieFetchEvent>(_fetchSearchedMovies);
  }

  Future<void> _fetchSearchedMovies(
      SearchMovieEvent event, Emitter<SearchMovieState> emit) async {
    if (event is SearchMovieFetchEvent) {
      emit(state.copyWith(stateSearchMovieDataState: RequestState.Loading));
      final result = await findAllMovies.execute(event.query);
      result.fold((failure) {
        emit(state.copyWith(
            stateSearchMovieDataState: RequestState.Error,
            message: failure.message));
      }, (result) {
        emit(state.copyWith(
            stateSearchMovieDataState: RequestState.Loaded,
            allMovieList: result));
      });
    }
  }
}
