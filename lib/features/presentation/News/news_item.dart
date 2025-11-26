import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/features/presentation/News/web_view.dart';

import '../../../api/models/news_articles.dart';

class NewsItem extends StatelessWidget {
  final NewsArticles articles;
  const NewsItem({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Theme.of(context).primaryColor,
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          isScrollControlled: true,
          builder: (context) {
            return Padding(
              padding: EdgeInsets.all(16.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: CachedNetworkImage(
                        imageUrl: articles.urlToImage ?? '',
                        fit: BoxFit.cover,
                        width: 1.sw, // full screen width
                        height: 0.25.sh, // 25% of screen height
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.broken_image, size: 40),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      articles.title ?? 'No title'.tr(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      articles.description ??
                          articles.content ??
                          "No description available".tr(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => WebView(url: articles.url ?? ""),
                          ),
                        );
                      },
                      child: Text(
                        "View Full Article".tr(),
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 1.0,
          ),
        ),
        width: 1.sw,
        margin: EdgeInsets.all(8.w),
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: CachedNetworkImage(
                  imageUrl: articles.urlToImage ?? '',
                  fit: BoxFit.fill,
                  width: 1.sw,
                  height: 0.2.sh, // 20% of screen height
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.broken_image, size: 40),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                articles.title ?? 'unknown',
                style: Theme.of(context).textTheme.headlineSmall,
                maxLines: 2,
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "By: ${articles.author ?? ''}",
                      style: Theme.of(context).textTheme.titleSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    articles.publishedAt ?? '',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
