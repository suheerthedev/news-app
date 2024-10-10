class ArticleModel {
  final String? sourceName;
  final String? author;
  final String? title;
  final String? description;
  final String? content;
  final String? imageUrl;
  final String? publishedAt;

  ArticleModel(
      {required this.author,
      required this.title,
      required this.description,
      required this.content,
      required this.imageUrl,
      required this.publishedAt,
      required this.sourceName});

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      sourceName: json['source']['name'],
      author: json['author'] ?? "Unknown Author",
      title: json['title'] ?? "No Title Available",
      description: json['description'] ?? "No Description Available",
      content: json['content'],
      imageUrl: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'],
    );
  }
}

class NewsResponse {
  final String status;
  final int totalResults;
  final List<ArticleModel> articles;

  NewsResponse({
    required this.status, 
    required this.totalResults, 
    required this.articles
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json){
    var articlesJson = json['articles'] as List;
    List<ArticleModel> articlesList = [];
    for (var eachArticle in articlesJson){
      articlesList.add(ArticleModel.fromJson(eachArticle));
    }

    return NewsResponse(
      status: json['status'], 
      totalResults: json['totalResults'], 
      articles: articlesList);
  }
}
