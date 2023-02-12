import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

class SearchMovieState extends Equatable {
  final RequestState searchMovieState;
  final List<Movie> moviesList;
  final String message;

  SearchMovieState({
    required this.searchMovieState,
    required this.moviesList,
    required this.message,
  });

  SearchMovieState copyWith({
    RequestState? searchMovieState,
    List<Movie>? moviesList,
    String? message,
  }) {
    return SearchMovieState(
      searchMovieState: searchMovieState ?? this.searchMovieState,
      moviesList: moviesList ?? this.moviesList,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        searchMovieState,
        moviesList,
        message,
      ];
}
