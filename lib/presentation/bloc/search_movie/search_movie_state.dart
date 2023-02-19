import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

class SearchMovieState extends Equatable {
  final RequestState stateSearchMovieDataState;
  final List<Movie> allMovieList;
  final String message;

  SearchMovieState({
    required this.stateSearchMovieDataState,
    required this.allMovieList,
    required this.message,
  });

  SearchMovieState copyWith({
    RequestState? stateSearchMovieDataState,
    List<Movie>? allMovieList,
    String? message,
  }) {
    return SearchMovieState(
      stateSearchMovieDataState:
          stateSearchMovieDataState ?? this.stateSearchMovieDataState,
      allMovieList: allMovieList ?? this.allMovieList,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        stateSearchMovieDataState,
        allMovieList,
        message,
      ];
}
