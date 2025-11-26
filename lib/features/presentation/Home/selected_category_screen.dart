import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/dependecy_injection/di.dart'; // Your getIt instance
import '../Sources/Bloc/category_sources_bloc.dart';
import '../Sources/Bloc/category_sources_event.dart';
import '../Sources/Bloc/category_sources_state.dart';
import '../Sources/source_tab_widget.dart';
import 'Categories/category_widget.dart';

class SelectedCategoryScreen extends StatefulWidget {
  final CategoryWidget category;
  const SelectedCategoryScreen({super.key, required this.category});

  @override
  State<SelectedCategoryScreen> createState() => _SelectedCategoryScreenState();
}

class _SelectedCategoryScreenState extends State<SelectedCategoryScreen> {
  bool _isSearching = false;
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CategorySourcesBloc>()
        ..add(GetSourcesEvent(widget.category.id)), // Updated BLoC and event
      child: Scaffold(
        appBar: AppBar(
          title: _isSearching
              ? SizedBox(
                  height: 40.h,
                  child: TextField(
                    autofocus: true,
                    cursorColor: Theme.of(context).primaryColor,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(
                      hintText: "Search...".tr(),
                      hintStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      prefixIcon: const Icon(Icons.search, color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                )
              : Text(
                  widget.category.title.tr(),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
          actions: [
            IconButton(
              icon: Icon(_isSearching ? Icons.close : Icons.search),
              onPressed: () {
                setState(() {
                  _isSearching = !_isSearching;
                  _searchQuery = "";
                });
              },
            ),
          ],
        ),
        body: BlocBuilder<CategorySourcesBloc, CategorySourcesState>(
          // Updated BLoC and state
          builder: (context, state) {
            if (state is CategorySourcesLoading) {
              // Updated state
              return const Center(
                child: CircularProgressIndicator(color: Colors.grey),
              );
            } else if (state is CategorySourcesError) {
              // Updated state
              return Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.errorMessage, // Updated field
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12.h),
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        context.read<CategorySourcesBloc>().add(GetSourcesEvent(
                            widget.category.id)); // Updated event
                      },
                      child: Text(
                        'Try again'.tr(),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is CategorySourcesSuccess) {
              // Updated state
              return SourceTabWidget(
                sourcesList: state.sourcesList, // Updated field
                searchQuery: _searchQuery,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
