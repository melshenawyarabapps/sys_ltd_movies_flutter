import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sys_ltd_movies_flutter/core/utils/app_padding.dart';
import 'package:sys_ltd_movies_flutter/core/widgets/loading_widget.dart';
import 'package:sys_ltd_movies_flutter/features/domain/entities/movie.dart';
import 'package:sys_ltd_movies_flutter/features/presentation/controllers/movies_bloc.dart';
import 'package:sys_ltd_movies_flutter/features/presentation/controllers/movies_event.dart';
import 'package:sys_ltd_movies_flutter/features/presentation/views/widgets/movie_card_widget.dart';

class MoviesListWidget extends StatefulWidget {
  const MoviesListWidget({
    super.key,
    required this.movies,
    required this.isLoadingMore,
  });

  final List<Movie> movies;
  final bool isLoadingMore;

  @override
  State<MoviesListWidget> createState() => _MoviesListWidgetState();
}

class _MoviesListWidgetState extends State<MoviesListWidget> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isNearBottom) {
      context.read<MoviesBloc>().add(const MoviesEvent.loadMore());
    }
  }

  bool get _isNearBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    return _scrollController.offset >= maxScroll * 0.9;
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = widget.movies.length + (widget.isLoadingMore ? 1 : 0);
    return ListView.builder(
      controller: _scrollController,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index >= widget.movies.length) {
          return Padding(
            padding: AppPadding.all(AppPadding.p16),
            child: const LoadingWidget(),
          );
        }
        return MovieCardWidget(movie: widget.movies[index]);
      },
    );
  }
}
