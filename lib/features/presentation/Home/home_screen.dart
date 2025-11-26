// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
//
// import 'Categories/category_fragment.dart';
// import 'Categories/category_widget.dart';
// import 'drawer/home_drawer.dart';
//
// class HomeScreen extends StatefulWidget {
//   HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   CategoryWidget? selectedCategory;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             selectedCategory == null
//                 ? 'Home'.tr()
//                 : selectedCategory!.title.tr(),
//             style: Theme.of(context).textTheme.headlineLarge,
//           ),
//         ),
//         drawer: Drawer(
//           child: HomeDrawer(),
//         ),
//         body: CategoryFragment(
//           onCategorySelected: (category) {
//             setState(() {
//               selectedCategory = category;
//             });
//           },
//         ));
//   }
// }
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/presentation/Home/selected_category_screen.dart';

import 'Categories/category_fragment.dart';
import 'Categories/category_widget.dart';
import 'drawer/home_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryWidget? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedCategory == null ? 'Home'.tr() : selectedCategory!.title.tr(),
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      drawer: const Drawer(
        child: HomeDrawer(),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: selectedCategory == null
            ? CategoryFragment(
                onCategorySelected: (category) {
                  setState(() {
                    selectedCategory = category;
                  });
                },
              )
            : SelectedCategoryScreen(
                category: selectedCategory!,
              ),
      ),
    );
  }
}
