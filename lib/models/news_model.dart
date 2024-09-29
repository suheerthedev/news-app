class NewsModel {
  final String sourceName;
  final String author;
  final String title;
  final String description;
  final String content;
  final String imageUrl;
  final String publishedAt;

  NewsModel(
      {required this.author,
      required this.title,
      required this.description,
      required this.content,
      required this.imageUrl,
      required this.publishedAt,
      required this.sourceName});

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      sourceName: json['source']['name'],
      author: json['author'],
      title: json['title'],
      description: json['description'],
      content: json['content'],
      imageUrl: json['urlToImage'],
      publishedAt: json['publishedAt'],
    );
  }
}
