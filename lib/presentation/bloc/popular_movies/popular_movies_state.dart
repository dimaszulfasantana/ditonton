import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

class PopularMoviesState extends Equatable {
  final RequestState statePopularAllMoviesData;
  final List<Movie> allPopularMoviesData;
  final String message;

  PopularMoviesState({
    required this.statePopularAllMoviesData,
    required this.allPopularMoviesData,
    required this.message,
  });

  PopularMoviesState copyWith({
    RequestState? statePopularAllMoviesData,
    List<Movie>? allPopularMoviesData,
    String? message,
  }) {
    return PopularMoviesState(
      statePopularAllMoviesData:
          statePopularAllMoviesData ?? this.statePopularAllMoviesData,
      allPopularMoviesData: allPopularMoviesData ?? this.allPopularMoviesData,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        statePopularAllMoviesData,
        allPopularMoviesData,
        message,
      ];
}
