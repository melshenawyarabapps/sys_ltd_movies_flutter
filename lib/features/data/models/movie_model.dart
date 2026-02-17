import 'package:equatable/equatable.dart';
import 'package:sys_ltd_movies_flutter/features/domain/entities/movie.dart';

class MovieModel extends Equatable {
  const MovieModel({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
  });

  final int id;
  final String title;
  final String overview;
  final String? posterPath;

  @override
  List<Object?> get props => [id, title, overview, posterPath];

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
    );
  }
}

extension MovieModelExtension on MovieModel {
  Movie get toEntity =>
      Movie(id: id, title: title, overview: overview, posterPath: posterPath);
}
