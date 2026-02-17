import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sys_ltd_movies_flutter/core/translations/locale_keys.g.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(LocaleKeys.popularMovies.tr()),
      leading: IconButton(
        onPressed: () {
          SystemNavigator.pop();
        },
        icon: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
