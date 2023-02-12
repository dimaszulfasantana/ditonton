import 'package:equatable/equatable.dart';

abstract class SearchTvSeriesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchTvSeriesFetchEvent extends SearchTvSeriesEvent {
  final String query;
  SearchTvSeriesFetchEvent({
    required this.query,
  });

  @override
  List<Object?> get props => [
        query,
      ];
}
