import 'package:flutter/material.dart';
import 'package:news_c19/api/api_manager.dart';
import 'package:news_c19/model/category_dm.dart';
import 'package:news_c19/model/response/article_dm.dart';
import 'package:news_c19/model/response/sources_response.dart';
import 'package:news_c19/ui/screens/news/article_list.dart';
import 'package:news_c19/ui/utils/app_colors.dart';
import 'package:news_c19/ui/utils/build_context_extensions.dart';
import 'package:news_c19/ui/widgets/app_drawer.dart';

class NewsScreen extends StatefulWidget {
  final CategoryDM categoryDM;
  const NewsScreen(
    this.categoryDM, {
    super.key,
  });

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  bool isSearching = false;
  List<ArticleDM> allArticles = [];
  List<ArticleDM> searchableArticle = [];
  String searchText = "";
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        searchText = _searchController.text;
      });
    });
  }

  void _startSearch() {
    setState(() => isSearching = true);
    // wait a frame so the TextField exists before requesting focus
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  void _stopSearch() {
    setState(() {
      isSearching = false;
      _searchController.clear();
      searchableArticle = allArticles;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(showGoToHomeNavigation: true),
      appBar: AppBar(
        title: isSearching
            ? TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search articles',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.white)),
                  hintStyle: TextStyle(color: AppColors.white),
                ),
                style: const TextStyle(color: AppColors.white),
              )
            : Text(widget.categoryDM.name),
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: isSearching ? _stopSearch : _startSearch,
          )
        ],
      ),
      body: FutureBuilder<List<SourceDM>>(
          future: ApiManager.loadSources(widget.categoryDM.name),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else if (snapshot.hasData) {
              return buildTabBar(snapshot.data!, context);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget buildTabBar(List<SourceDM> sources, BuildContext context) {
    var theme = context.theme;
    var tabs = sources
        .map((source) => buildTabItem(
              source,
            ))
        .toList();
    return DefaultTabController(
        length: sources.length,
        child: Column(
          children: [
            TabBar(
                isScrollable: true,
                labelColor: theme.secondaryColor,
                labelStyle: theme.textTheme.bodyMedium,
                unselectedLabelStyle: theme.textTheme.bodySmall,
                tabAlignment: TabAlignment.start,
                tabs: tabs),
            Expanded(
              child: TabBarView(
                  children: sources
                      .map((source) => ArticleList(
                            sourceDM: source,
                            searchtext: searchText,
                          ))
                      .toList()),
            )
          ],
        ));
  }

  Widget buildTabItem(SourceDM source) {
    return Text(source.name ?? "Unknown");
  }
}
