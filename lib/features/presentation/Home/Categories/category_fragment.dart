import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Theme_Bloc/theme_bloc.dart';
import '../Theme_Bloc/theme_state.dart';
import 'category_item.dart';
import 'category_widget.dart';

typedef OnCategorySelected = void Function(CategoryWidget category);

class CategoryFragment extends StatelessWidget {
  final OnCategorySelected onCategorySelected;
  CategoryFragment({super.key, required this.onCategorySelected});

  List<CategoryWidget> categoryList = [];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        bool isDark = false;
        if (state is ThemeLoaded) {
          isDark = state.themeMode == ThemeMode.dark;
        }
        // ونمرر القيمة الصح
        categoryList = CategoryWidget.getCategoryList(isDark);

        return Padding(
          padding: EdgeInsets.symmetric(
              vertical: height * .02, horizontal: width * .03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '''Good Morning
Here is Some News For You'''
                    .tr(),
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(height: height * .02),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        ///  استدعاء الكولباك لما يضغط على الكاتيجوري
                        onCategorySelected(categoryList[index]);
                      },
                      child: CategoryItem(
                        category: categoryList[index],
                        index: index,
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: height * .02);
                  },
                  itemCount: categoryList.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
