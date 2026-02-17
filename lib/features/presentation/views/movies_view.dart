import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sys_ltd_movies_flutter/core/services/di/di.dart';
import 'package:sys_ltd_movies_flutter/features/presentation/controllers/movies_bloc.dart';
import 'package:sys_ltd_movies_flutter/features/presentation/views/widgets/custom_app_bar.dart';
import 'package:sys_ltd_movies_flutter/features/presentation/views/widgets/movies_body_widget.dart';

class MoviesView extends StatelessWidget {
  const MoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocProvider(
        create: (_) => getIt.get<MoviesBloc>(),
        child: const MoviesBodyWidget(),
      ),
    );
  }
}
