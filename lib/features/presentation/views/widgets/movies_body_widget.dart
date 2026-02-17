import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sys_ltd_movies_flutter/core/enums/api_enums.dart';
import 'package:sys_ltd_movies_flutter/core/translations/locale_keys.g.dart';
import 'package:sys_ltd_movies_flutter/core/widgets/empty_data_widget.dart';
import 'package:sys_ltd_movies_flutter/core/widgets/error_display_widget.dart';
import 'package:sys_ltd_movies_flutter/core/widgets/loading_widget.dart';
import 'package:sys_ltd_movies_flutter/features/presentation/controllers/movies_bloc.dart';
import 'package:sys_ltd_movies_flutter/features/presentation/controllers/movies_event.dart';
import 'package:sys_ltd_movies_flutter/features/presentation/controllers/movies_state.dart';
import 'package:sys_ltd_movies_flutter/features/presentation/views/widgets/movies_list_widget.dart';

class MoviesBodyWidget extends StatefulWidget {
  const MoviesBodyWidget({super.key});

  @override
  State<MoviesBodyWidget> createState() => _MoviesBodyWidgetState();
}

class _MoviesBodyWidgetState extends State<MoviesBodyWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MoviesBloc>().add(const MoviesEvent.fetch());
    });
  }

  void _onRetry() => context.read<MoviesBloc>().add(const MoviesEvent.fetch());

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state.movies.isNotEmpty) {
          return MoviesListWidget(
            movies: state.movies,
            isLoadingMore: state.status.isLoadingMore,
          );
        }
        return switch (state.status) {
          RequestStatus.loading ||
          RequestStatus.initial => const LoadingWidget(),
          RequestStatus.error => ErrorDisplayWidget(
            message: state.errorMessage,
            onRetry: _onRetry,
          ),
          _ => EmptyDataWidget(
            message: LocaleKeys.noMoviesFound.tr(),
            onRetry: _onRetry,
          ),
        };
      },
    );
  }
}
