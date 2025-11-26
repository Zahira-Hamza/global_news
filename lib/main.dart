import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/config/dependecy_injection/di.dart';

import 'core/cache/shared_pref_utils.dart'; // Note: You have 'cache' here, but earlier it was 'cashe' – ensure consistency
import 'core/utils/app_routes.dart';
import 'core/utils/app_theme.dart';
import 'features/presentation/Home/Language_Bloc/language_bloc.dart';
import 'features/presentation/Home/Language_Bloc/language_state.dart'; // Added for LanguageState
import 'features/presentation/Home/Theme_Bloc/theme_bloc.dart';
import 'features/presentation/Home/Theme_Bloc/theme_state.dart';
import 'features/presentation/Home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences
  await SharedPrefUtils.init();

  // Initialize EasyLocalization
  await EasyLocalization.ensureInitialized();

  // Initialize Dependency Injection
  configureDependencies();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852), //  design size
      minTextAdapt: true,
      builder: (context, child) {
        // child is null here
        return MultiBlocProvider(
          providers: [
            BlocProvider<ThemeBloc>(
              create: (_) => ThemeBloc(),
            ),
            BlocProvider<LanguageBloc>(
              create: (_) => LanguageBloc(),
            ),
          ],
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              ThemeMode themeMode = ThemeMode.system;
              if (themeState is ThemeLoaded) {
                themeMode = themeState.themeMode;
              }

              return BlocBuilder<LanguageBloc, LanguageState>(
                // Added for dynamic locale
                builder: (context, languageState) {
                  Locale locale = const Locale('en'); // Default
                  if (languageState is LanguageLoaded) {
                    locale = languageState.locale;
                  }

                  return MaterialApp(
                    debugShowCheckedModeBanner: false,

                    // Localization
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: locale, // Now dynamic from BLoC

                    // Themes
                    theme: AppTheme.lightTheme,
                    darkTheme: AppTheme.darkTheme,
                    themeMode: themeMode,

                    // Routes
                    initialRoute: AppRoutes.homeRouteName,
                    routes: {
                      AppRoutes.homeRouteName: (context) => HomeScreen(),
                    },
                  );
                },
              );
            },
          ),
        );
      },
      child: null, // Set to null since builder returns the app
    );
  }
}
