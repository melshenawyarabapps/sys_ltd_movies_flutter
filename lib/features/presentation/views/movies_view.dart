import 'package:flutter/material.dart';
import 'package:sys_ltd_movies_flutter/features/presentation/views/widgets/custom_app_bar.dart';

class MoviesView extends StatelessWidget {
  const MoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(),
    );
  }
}
