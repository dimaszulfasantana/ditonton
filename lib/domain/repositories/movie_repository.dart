import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/common/failure.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> fetchNowPlayingAllMovie();
  Future<Either<Failure, List<Movie>>> fetchPopularAllMovie();
  Future<Either<Failure, List<Movie>>> fetchTopRatedAllMovie();
  Future<Either<Failure, MovieDetail>> fetchMovieDataDetail(int id);
  Future<Either<Failure, List<Movie>>> fetchMovieDataRecommendations(int id);
  Future<Either<Failure, List<Movie>>> findAllMovies(String query);
  Future<Either<Failure, String>> saveWatchlist(MovieDetail movie);
  Future<Either<Failure, String>> deleteFromWatchList(MovieDetail movie);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<Movie>>> fetchWatchListAllMovie();
}
