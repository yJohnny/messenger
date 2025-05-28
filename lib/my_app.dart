import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:messenger/constants/app_colors.dart';
import 'package:messenger/constants/app_text_styles.dart';
import 'package:messenger/features/chats/chats_cubit.dart';
import 'package:messenger/features/users/users_cubit.dart';
import 'package:messenger/router/router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(500, 1000),
      minTextAdapt: true,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => UsersCubit()),
            BlocProvider(create: (_) => ChatsCubit()),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                backgroundColor: AppColors.darkGreen,
                centerTitle: true,
                titleTextStyle: AppTextStyles.s20.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                iconTheme: IconThemeData(color: Colors.white),
              ),
            ),
            routerConfig: router,
          ),
        );
      },
    );
  }
}
