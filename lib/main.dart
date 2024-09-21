import 'package:bill_planner/app_bottom_navbar.dart';
import 'package:bill_planner/features/home/logic/schedule_cubit.dart';
import 'package:bill_planner/features/new_eye_drop/logic/eye_drop_cubit.dart';
import 'package:bill_planner/features/settings/logic/settings_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'common/app_colors.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ScreenUtil.ensureScreenSize();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ScheduleCubit(),
        ),
        BlocProvider(
          create: (context) => EyeDropsCubit(),
        ),
        BlocProvider(
          create: (context) => SettingsCubit(),
        ),
      ],
      child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSwatch().copyWith(
                  secondary: AppColors.secondary,
                  primary: AppColors.primary,
                ),
                scaffoldBackgroundColor: AppColors.white,
                appBarTheme: const AppBarTheme(
                  backgroundColor: AppColors.white,
                  surfaceTintColor: AppColors.white,
                ),
                useMaterial3: true,
              ),
              home: const AppBottomNavbar(),
            );
          }),
    );
  }
}
