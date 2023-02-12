import 'package:ditonton/data/models/tvseries/tv_series_results.dart';
import 'package:equatable/equatable.dart';

class TvSeriesResponse extends Equatable {
  final int page;
  final List<TvSeriesResults> results;
  final int totalPages;
  final int totalResults;

  TvSeriesResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TvSeriesResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesResponse(
        page: json["page"],
        results: List<TvSeriesResults>.from(
            json["results"].map((x) => TvSeriesResults.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };

  @override
  List<Object?> get props => [
        page,
        results,
        totalPages,
        totalResults,
      ];
}
