import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Added for BLoC usage
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Added for responsive sizing

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_routes.dart';
import '../Language_Bloc/language_bloc.dart'; // Added for LanguageBloc
import '../Language_Bloc/language_event.dart'; // Added for LanguageBloc events
import '../Language_Bloc/language_state.dart'; // Added for LanguageBloc states
import '../Theme_Bloc/theme_bloc.dart'; // Added for ThemeBloc
import '../Theme_Bloc/theme_event.dart'; // Added for ThemeBloc events
import '../Theme_Bloc/theme_state.dart'; // Added for ThemeBloc states

class DrawerDropdownField extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const DrawerDropdownField({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    // Removed MediaQuery for height and width, replaced with ScreenUtil for responsive design
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: 10
                .h), // Changed from height * .01 to 10.h for responsive margin
        padding: EdgeInsets.symmetric(
            horizontal: 12
                .w), // Changed from width * .03 to 12.w for responsive padding
        height: 60.h, // Changed from height * .06 to 60.h for responsive height
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              16.r), // Changed to 16.r for responsive radius
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp, // Changed to 18.sp for responsive font size
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(Icons.arrow_drop_down,
                color: Colors.white,
                size: 20.sp), // Changed to 20.sp for responsive icon size
          ],
        ),
      ),
    );
  }
}

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // Removed Provider references for themeProvider and languageProvider
    // Now using BLoC for state management instead of Provider

    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            width: double.infinity,
            color: AppColors.whitePrimaryColor,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "News App".tr(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.sp, // Changed to 24.sp for responsive font size
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            color: AppColors.blackPrimaryColor,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20
                    .h, // Changed from height * .02 to 20.h for responsive padding
                horizontal: 16
                    .w, // Changed from width * .04 to 16.w for responsive padding
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Home Button
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, AppRoutes.homeRouteName);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.home,
                            color: Colors.white,
                            size: 24
                                .sp), // Changed to 24.sp for responsive icon size
                        SizedBox(
                            width:
                                12.w), // Changed to 12.w for responsive width
                        Text(
                          "Go To Home".tr(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                                .sp, // Changed to 18.sp for responsive font size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                      height: 20
                          .h), // Changed from height * .02 to 20.h for responsive height
                  const Divider(color: Colors.white, thickness: 1),
                  SizedBox(
                      height: 20
                          .h), // Changed from height * .02 to 20.h for responsive height

                  /// Theme
                  Row(
                    children: [
                      Icon(Icons.brightness_4_outlined,
                          color: Colors.white,
                          size: 24
                              .sp), // Changed to 24.sp for responsive icon size
                      SizedBox(
                          width: 12.w), // Changed to 12.w for responsive width
                      Text(
                        "Theme".tr(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                              .sp, // Changed to 18.sp for responsive font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(
                      height: 20
                          .h), // Changed from height * .02 to 20.h for responsive height
                  BlocBuilder<ThemeBloc, ThemeState>(
                    // Added BlocBuilder for ThemeBloc to get current theme state
                    builder: (context, state) {
                      String themeText = "Light".tr(); // Default to Light
                      if (state is ThemeLoaded) {
                        themeText = state.themeMode == ThemeMode.dark
                            ? "Dark".tr()
                            : "Light".tr();
                      }
                      return DrawerDropdownField(
                        text: themeText,
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) {
                              return Container(
                                color: AppColors.blackPrimaryColor,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      title: Text(
                                        "Light".tr(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16
                                                .sp), // Changed to 16.sp for responsive font size
                                      ),
                                      onTap: () {
                                        context.read<ThemeBloc>().add(
                                            SetThemeMode(ThemeMode
                                                .light)); // Changed from themeProvider.toggleTheme(false) to BLoC event
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      title: Text(
                                        "Dark".tr(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16
                                                .sp), // Changed to 16.sp for responsive font size
                                      ),
                                      onTap: () {
                                        context.read<ThemeBloc>().add(
                                            SetThemeMode(ThemeMode
                                                .dark)); // Changed from themeProvider.toggleTheme(true) to BLoC event
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),

                  SizedBox(
                      height: 20
                          .h), // Changed from height * .02 to 20.h for responsive height
                  const Divider(color: Colors.white, thickness: 1),
                  SizedBox(
                      height: 20
                          .h), // Changed from height * .02 to 20.h for responsive height

                  /// Language
                  Row(
                    children: [
                      Icon(Icons.language,
                          color: Colors.white,
                          size: 24
                              .sp), // Changed to 24.sp for responsive icon size
                      SizedBox(
                          width: 12.w), // Changed to 12.w for responsive width
                      Text(
                        "Language".tr(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                              .sp, // Changed to 18.sp for responsive font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(
                      height: 20
                          .h), // Changed from height * .02 to 20.h for responsive height
                  BlocBuilder<LanguageBloc, LanguageState>(
                    // Added BlocBuilder for LanguageBloc to get current language state
                    builder: (context, state) {
                      String languageText = "English"; // Default to English
                      if (state is LanguageLoaded &&
                          state.locale.languageCode == 'ar') {
                        languageText = "العربية";
                      }
                      return DrawerDropdownField(
                        text: languageText,
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) {
                              return Container(
                                color: AppColors.blackPrimaryColor,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      title: Text(
                                        "English",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16
                                                .sp), // Changed to 16.sp for responsive font size
                                      ),
                                      onTap: () {
                                        context.read<LanguageBloc>().add(
                                            ChangeLanguage(const Locale(
                                                'en'))); // Changed from languageProvider.setLocale to BLoC event
                                        context.setLocale(const Locale('en'));
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      title: Text(
                                        "العربية",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16
                                                .sp), // Changed to 16.sp for responsive font size
                                      ),
                                      onTap: () {
                                        context.read<LanguageBloc>().add(
                                            ChangeLanguage(const Locale(
                                                'ar'))); // Changed from languageProvider.setLocale to BLoC event
                                        context.setLocale(const Locale('ar'));
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
