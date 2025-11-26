import 'package:news_app/core/utils/app_assets.dart';

/////////////class for category types ////////////////

class CategoryWidget {
  String id;
  String title;
  String image;
  CategoryWidget({required this.id, required this.title, required this.image});
  static List<CategoryWidget> getCategoryList(bool isDark) {
    return [
      CategoryWidget(
          id: "general",
          title: "General",
          image: isDark
              ? AppAssets.generalDarkImage
              : AppAssets.generalLightImage),
      CategoryWidget(
          id: "business",
          title: "Business",
          image: isDark
              ? AppAssets.businessDarkImage
              : AppAssets.businessLightImage),
      CategoryWidget(
          id: "entertainment",
          title: "Entertainment",
          image: isDark
              ? AppAssets.entertainmentDarkImage
              : AppAssets.entertainmentLightImage),
      CategoryWidget(
          id: "health",
          title: "Health",
          image:
              isDark ? AppAssets.healthDarkImage : AppAssets.healthLightImage),
      CategoryWidget(
          id: "science",
          title: "Science",
          image: isDark
              ? AppAssets.scienceDarkImage
              : AppAssets.scienceLightImage),
      CategoryWidget(
          id: "technology",
          title: "Technology",
          image: isDark
              ? AppAssets.technologyDarkImage
              : AppAssets.technologyLightImage),
      CategoryWidget(
          id: "sports",
          title: "Sports",
          image:
              isDark ? AppAssets.sportsDarkImage : AppAssets.sportsLightImage),
    ];
  }
}
