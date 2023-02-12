import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

class PopularMoviesState extends Equatable {
  final RequestState popularMoviesState;
  final List<Movie> popularMovies;
  final String message;

  PopularMoviesState({
    required this.popularMoviesState,
    required this.popularMovies,
    required this.message,
  });

  PopularMoviesState copyWith({
    RequestState? popularMoviesState,
    List<Movie>? popularMovies,
    String? message,
  }) {
    return PopularMoviesState(
      popularMoviesState: popularMoviesState ?? this.popularMoviesState,
      popularMovies: popularMovies ?? this.popularMovies,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        popularMoviesState,
        popularMovies,
        message,
      ];
}
