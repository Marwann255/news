import 'package:flutter/material.dart';
import 'package:news_c19/model/category_dm.dart';
import 'package:news_c19/model/response/article_dm.dart';
import 'package:news_c19/ui/screens/home/home_screen.dart';
import 'package:news_c19/ui/screens/news/news_screen.dart';

abstract final class AppRoutes {
  static MaterialPageRoute home() =>
      MaterialPageRoute(builder: (_) => HomeScreen());

  static MaterialPageRoute news(
    CategoryDM category,
  ) =>
      MaterialPageRoute(
          builder: (_) => NewsScreen(
                category,
              ));
}
