import 'package:dio/dio.dart';
import 'package:news_c19/model/response/article_dm.dart';
import 'package:news_c19/model/response/article_response.dart';
import 'package:news_c19/model/response/sources_response.dart';

import '../model/response/sources_response.dart';

abstract final class ApiManager {
  static Dio dio = Dio(BaseOptions(baseUrl: "https://newsapi.org"));
  static const apiKey = "337dc2b5fe7c467aacde1b358cbe785b";
  static const defaultErrorMessage = "Something went wrong!";

  static Future<List<SourceDM>> loadSources(String category) async {
    try {
      Response serverResponse = await dio
          .get("/v2/top-headlines/sources?apiKey=$apiKey&category=$category");
      if (serverResponse.statusCode! >= 200 &&
          serverResponse.statusCode! < 300) {
        Map<String, dynamic> json = serverResponse.data;
        var sourcesResponse = SourcesResponse.fromJson(json);
        return sourcesResponse.sources!;
      }
      print(serverResponse.data);
      throw defaultErrorMessage;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<ArticleDM>> loadArticles(String sourceId) async {
    try {
      print("sourceId: $sourceId");
      Response serverResponse = await dio.get("/v2/everything",
          queryParameters: {"apiKey": apiKey, "sources": sourceId});
      if (serverResponse.statusCode! >= 200 &&
          serverResponse.statusCode! < 300) {
        Map<String, dynamic> json = serverResponse.data;
        var articlesResponse = ArticleResponse.fromJson(json);
        return articlesResponse.articles!;
      }
      throw defaultErrorMessage;
    } catch (e) {
      rethrow;
    }
  }
}
