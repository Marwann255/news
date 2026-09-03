import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_c19/api/api_manager.dart';
import 'package:news_c19/model/response/article_dm.dart';
import 'package:news_c19/model/response/sources_response.dart';
import 'package:news_c19/ui/utils/app_colors.dart';
import 'package:news_c19/ui/utils/build_context_extensions.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class ArticleList extends StatefulWidget {
  final SourceDM sourceDM;
  final String searchtext;

  const ArticleList(
      {super.key, required this.sourceDM, required this.searchtext});

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  late Future<List<ArticleDM>> _articlesFuture;
  @override
  void initState() {
    super.initState();
    _articlesFuture = ApiManager.loadArticles(widget.sourceDM.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ArticleDM>>(
          future: _articlesFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(
                snapshot.error.toString(),
                style: TextStyle(color: Colors.red),
              );
            } else if (snapshot.hasData) {
              final filtered = _search(snapshot.data!);
              return buildArticlesList(filtered);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  List<ArticleDM> _search(List<ArticleDM> articles) {
    final searchText = widget.searchtext.trim().toUpperCase();
    if (searchText.isEmpty) return articles;

    return articles.where((article) {
      final title = (article.title ?? "").toUpperCase();
      final author = (article.author ?? "").toUpperCase();
      return title.contains(searchText) || author.contains(searchText);
    }).toList();
  }

  void textField() => setState(() {
        TextButton(onPressed: () => _search, child: Text("Search"));
      });

  Widget buildArticlesList(List<ArticleDM> list) {
    if (list.isEmpty) {
      return Center(child: Text("No articles found in this source"));
    }
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) =>
            buildArticleItem(context, list[index]));
  }

  Widget buildArticleItem(BuildContext context, ArticleDM article) {
    var theme = context.theme;
    var dateTime = DateTime.parse(article.publishedAt!);

    return InkWell(
      onTap: () {
        showArticleBottomSheet(context, article);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.secondaryColor, width: 1),
        ),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: article.urlToImage ?? "",
              height: context.height * .25,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Text(article.title ?? "Unknown"),
            Row(
              children: [
                if (article.author != null)
                  Expanded(
                      child: Text("By: ${article.author}",
                          style: theme.textTheme.displayMedium)),
                if (article.publishedAt != null)
                  Text(
                    timeago.format(dateTime),
                    style: theme.textTheme.displayMedium,
                  )
              ],
            )
          ],
        ),
      ),
    );
  }

  void showArticleBottomSheet(BuildContext context, ArticleDM article) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // lets the sheet expand beyond half screen
      backgroundColor: Colors.transparent,
      builder: (context) => ArticleBottomSheet(context, article),
    );
  }

  Widget ArticleBottomSheet(BuildContext context, ArticleDM article) {
    return Container(
      height: MediaQuery.of(context).size.height * .5,
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: article.urlToImage ?? "",
              height: context.height * .26,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Text(
              article.description ?? "",
              style: TextStyle(color: AppColors.black),
            ),
            const SizedBox(
              height: 4,
            ),
            SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .08,
                child: FilledButton(
                    onPressed: () {
                      _openUrl(article.url.toString());
                    },
                    child: Text("View Full Artical")))
          ],
        ),
      ),
    );
  }

  Future<void> _openUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
