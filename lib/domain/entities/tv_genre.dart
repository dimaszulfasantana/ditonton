import 'package:equatable/equatable.dart';

class TvGenre extends Equatable {
  int id;
  String name;

  TvGenre({required this.id, required this.name});

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
