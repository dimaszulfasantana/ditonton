import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/common/failure.dart';

abstract class MovieRepository {
  Future<Either<FailureException, List<Movie>>> fetchNowPlayingAllMovie();
  Future<Either<FailureException, List<Movie>>> fetchPopularAllMovie();
  Future<Either<FailureException, List<Movie>>> fetchTopRatedAllMovie();
  Future<Either<FailureException, MovieDetail>> fetchMovieDataDetail(int id);
  Future<Either<FailureException, List<Movie>>> fetchMovieDataRecommendations(
      int id);
  Future<Either<FailureException, List<Movie>>> findAllMovies(String query);
  Future<Either<FailureException, String>> saveWatchlist(MovieDetail movie);
  Future<Either<FailureException, String>> deleteFromWatchList(
      MovieDetail movie);
  Future<bool> isAddedToWatchListorNot(int id);
  Future<Either<FailureException, List<Movie>>> getAllWatchListMovie();
}
