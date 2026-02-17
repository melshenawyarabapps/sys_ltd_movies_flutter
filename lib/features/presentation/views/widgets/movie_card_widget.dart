import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sys_ltd_movies_flutter/core/utils/app_constants.dart';
import 'package:sys_ltd_movies_flutter/core/utils/app_padding.dart';
import 'package:sys_ltd_movies_flutter/core/utils/end_points.dart';
import 'package:sys_ltd_movies_flutter/core/widgets/network_image_widget.dart';
import 'package:sys_ltd_movies_flutter/features/domain/entities/movie.dart';

class MovieCardWidget extends StatelessWidget {
  const MovieCardWidget({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: AppPadding.hvPadding(
        width: AppPadding.p16,
        height: AppPadding.p8,
      ),
      child: InkWell(
        onTap: () {
          _onMovieTap(movie.id);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 120.w,
              height: 180.h,
              child: NetworkImageWidget(
                imageUrl: '${EndPoints.imageBaseUrl}${movie.posterPath}',
              ),
            ),
            Expanded(
              child: Padding(
                padding: AppPadding.all(AppPadding.p12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    8.verticalSpace,
                    Text(
                      movie.overview,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 12.sp,
                      ),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onMovieTap(int movieId) async {
    try {
      await const MethodChannel(AppConstants.channelName)
          .invokeMethod(AppConstants.eventName, {'movieId': movieId});
    } on PlatformException catch (_) {
      // Platform channel communication failed - handled silently
    }
  }
}
