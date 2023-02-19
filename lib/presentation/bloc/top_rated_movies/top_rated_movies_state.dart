import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

class TopRatedMoviesState extends Equatable {
  final RequestState stateTopRatedAllMovies;
  final List<Movie> allTopRatedMovie;
  final String message;

  TopRatedMoviesState({
    required this.stateTopRatedAllMovies,
    required this.allTopRatedMovie,
    required this.message,
  });

  TopRatedMoviesState copyWith({
    RequestState? stateTopRatedAllMovies,
    List<Movie>? allTopRatedMovie,
    String? message,
  }) {
    return TopRatedMoviesState(
      stateTopRatedAllMovies:
          stateTopRatedAllMovies ?? this.stateTopRatedAllMovies,
      allTopRatedMovie: allTopRatedMovie ?? this.allTopRatedMovie,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        stateTopRatedAllMovies,
        allTopRatedMovie,
        message,
      ];
}
