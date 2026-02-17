import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sys_ltd_movies_flutter/core/translations/locale_keys.g.dart';
import 'package:sys_ltd_movies_flutter/core/utils/app_padding.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({
    super.key,
    this.message,
    this.icon,
    this.iconSize,
    this.onRetry,
  });

  final String? message;
  final IconData? icon;
  final double? iconSize;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: AppPadding.all(AppPadding.p16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.inbox_outlined,
              size: iconSize ?? 64.sp,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            16.verticalSpace,
            Text(
              message ?? LocaleKeys.noMoviesFound.tr(),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              16.verticalSpace,
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(LocaleKeys.retry.tr()),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
