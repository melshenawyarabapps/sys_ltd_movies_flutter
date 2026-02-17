import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sys_ltd_movies_flutter/core/enums/api_enums.dart';
import 'package:sys_ltd_movies_flutter/core/errors/app_exceptions.dart';
import 'package:sys_ltd_movies_flutter/features/domain/usecases/get_popular_movies.dart';
import 'package:sys_ltd_movies_flutter/features/presentation/controllers/movies_event.dart';
import 'package:sys_ltd_movies_flutter/features/presentation/controllers/movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetPopularMovies _getPopularMovies;

  MoviesBloc(this._getPopularMovies) : super(const MoviesState()) {
    on<MoviesEvent>(_onMoviesEvent);
  }

  Future<void> _onMoviesEvent(
    MoviesEvent event,
    Emitter<MoviesState> emit,
  ) async {
    switch (event.type) {
      case MoviesEventType.fetch:
        await _fetchMovies(emit);
      case MoviesEventType.loadMore:
        await _loadMoreMovies(emit);
    }
  }

  Future<void> _fetchMovies(Emitter<MoviesState> emit) async {
    emit(state.copyWith(status: RequestStatus.loading));
    try {
      final (movies, totalPages) = await _getPopularMovies(1);
      emit(state.copyWith(
        status: RequestStatus.loaded,
        movies: movies,
        currentPage: 1,
        totalPages: totalPages,
        hasReachedMax: 1 >= totalPages,
      ));
    } catch (e) {
      _emitError(emit, e);
    }
  }

  Future<void> _loadMoreMovies(Emitter<MoviesState> emit) async {
    if (state.hasReachedMax || state.status == RequestStatus.loadingMore) return;

    final nextPage = state.currentPage + 1;
    emit(state.copyWith(status: RequestStatus.loadingMore));
    try {
      final (movies, totalPages) = await _getPopularMovies(nextPage);
      emit(state.copyWith(
        status: RequestStatus.loaded,
        movies: [...state.movies, ...movies],
        currentPage: nextPage,
        totalPages: totalPages,
        hasReachedMax: nextPage >= totalPages,
      ));
    } catch (e) {
      _emitError(emit, e);
    }
  }

  void _emitError(Emitter<MoviesState> emit, Object exception) {
    emit(state.copyWith(
      status: RequestStatus.error,
      errorMessage: (exception as AppException).localeKey.tr(),
    ));
  }
}
