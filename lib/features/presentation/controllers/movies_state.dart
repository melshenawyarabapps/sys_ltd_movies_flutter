import 'package:equatable/equatable.dart';
import 'package:sys_ltd_movies_flutter/core/enums/api_enums.dart';
import 'package:sys_ltd_movies_flutter/features/domain/entities/movie.dart';

class MoviesState extends Equatable {
  final List<Movie> movies;
  final RequestStatus status;
  final String errorMessage;
  final int currentPage;
  final int totalPages;
  final bool hasReachedMax;

  const MoviesState({
    this.movies = const [],
    this.status = RequestStatus.initial,
    this.errorMessage = '',
    this.currentPage = 0,
    this.totalPages = 1,
    this.hasReachedMax = false,
  });

  MoviesState copyWith({
    List<Movie>? movies,
    RequestStatus? status,
    String? errorMessage,
    int? currentPage,
    int? totalPages,
    bool? hasReachedMax,
  }) {
    return MoviesState(
      movies: movies ?? this.movies,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [movies, status, errorMessage, currentPage, totalPages, hasReachedMax];
}
