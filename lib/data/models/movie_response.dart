import 'package:ditonton/data/models/movie_model.dart';
import 'package:equatable/equatable.dart';

class MovieResponse extends Equatable {
  final List<MovieModel> allMovie;

  MovieResponse({required this.allMovie});

  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
        allMovie: List<MovieModel>.from((json["results"] as List)
            .map((x) => MovieModel.fromJson(x))
            .where((element) => element.posterPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(allMovie.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [allMovie];
}
