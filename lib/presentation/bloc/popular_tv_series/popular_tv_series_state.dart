import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class PopularTvSeriesState extends Equatable {
  final RequestState popularState;
  final List<TvSeries> popularList;
  final String message;

  PopularTvSeriesState({
    required this.popularState,
    required this.popularList,
    required this.message,
  });

  PopularTvSeriesState copyWith({
    RequestState? popularState,
    List<TvSeries>? popularList,
    String? message,
  }) {
    return PopularTvSeriesState(
      popularState: popularState ?? this.popularState,
      popularList: popularList ?? this.popularList,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        popularState,
        popularList,
        message,
      ];
}
