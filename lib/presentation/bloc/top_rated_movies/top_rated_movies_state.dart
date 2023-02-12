import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

class TopRatedMoviesState extends Equatable {
  final RequestState topRatedMoviesState;
  final List<Movie> topRatedMovies;
  final String message;

  TopRatedMoviesState({
    required this.topRatedMoviesState,
    required this.topRatedMovies,
    required this.message,
  });

  TopRatedMoviesState copyWith({
    RequestState? topRatedMoviesState,
    List<Movie>? topRatedMovies,
    String? message,
  }) {
    return TopRatedMoviesState(
      topRatedMoviesState: topRatedMoviesState ?? this.topRatedMoviesState,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        topRatedMoviesState,
        topRatedMovies,
        message,
      ];
}
