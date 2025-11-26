import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../api/models/sources.dart';
// Updated import
import 'Bloc/news_bloc.dart';
import 'Bloc/news_event.dart';
import 'Bloc/news_state.dart';
import 'news_item.dart';

class NewsWidget extends StatefulWidget {
  final Sources source;
  final String searchQuery;

  const NewsWidget({
    super.key,
    required this.source,
    this.searchQuery = "",
  });

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      // Removed BlocProvider here (handled in SourceTabWidget)
      builder: (context, state) {
        // Handle loading
        if (state.isLoading && state.articles.isEmpty) {
          // Updated to use NewsState fields
          return const Center(
            child: CircularProgressIndicator(color: Colors.grey),
          );
        }

        // Handle error
        if (state.error != null) {
          // Updated to use NewsState.error
          return Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.error!, textAlign: TextAlign.center), // Updated
                SizedBox(height: 12.h),
                ElevatedButton(
                  onPressed: () => context.read<NewsBloc>().add(GetNewsEvent(
                      widget.source.id!,
                      page: 1)), // Updated event
                  child: Text('Try again'.tr()),
                ),
              ],
            ),
          );
        }

        // Handle success + pagination
        final articles = state.articles; // Updated
        final visibleArticles = widget.searchQuery.isEmpty
            ? articles
            : articles
                .where((a) => (a.title ?? '')
                    .toLowerCase()
                    .contains(widget.searchQuery.toLowerCase()))
                .toList();

        if (visibleArticles.isEmpty && widget.searchQuery.isNotEmpty) {
          return Center(child: Text("No results found".tr()));
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            if (scrollInfo.metrics.pixels >=
                    scrollInfo.metrics.maxScrollExtent - 200.h &&
                !state.isLoading &&
                state.hasMore) {
              // Updated to use NewsState fields
              context
                  .read<NewsBloc>()
                  .add(LoadMoreNewsEvent(widget.source.id!)); // Updated event
            }
            return false;
          },
          child: ListView.builder(
            controller: _scrollController,
            itemCount:
                visibleArticles.length + (state.isLoading ? 1 : 0), // Updated
            itemBuilder: (context, index) {
              if (index < visibleArticles.length) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  child: NewsItem(articles: visibleArticles[index]),
                );
              }

              // Pagination loader
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: CircularProgressIndicator(color: Colors.grey),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
