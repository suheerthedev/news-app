import 'package:flutter/material.dart';
import 'package:news_app/models/news_model.dart';
import 'package:intl/intl.dart';

class ArticleDetailsScreen extends StatelessWidget {
  const ArticleDetailsScreen({super.key, required this.article});
  final ArticleModel article;

  String formatDateTime(String? dateTimeString) {
  if (dateTimeString == null) return "Unknown Publishing Date";
  try {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
  } catch (e) {
    return "Invalid Date";
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top image of the article
                Image.network(
                  article.imageUrl!, // Replace with your image URL
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 250,
                      color: Colors.grey,
                      child: const Icon(
                        Icons.broken_image,
                        color: Colors.white,
                      ),
                    );
                  },
                ),

                // Date and Title container
                const SizedBox(height: 100),

                // Article content
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Expanded(
                        child: SizedBox(
                      child: Text(article.content ?? "Content Unavailable"),
                    ))),
              ],
            ),
          ),
          Positioned(
            top: 180,
            right: 20,
            left: 20,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.red.withOpacity(0.9),
                        Colors.black.withOpacity(1)
                      ]),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formatDateTime(article.publishedAt),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      article.title ?? "No Title Available",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'by ${article.author}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 15,
            child: IconButton(
              icon: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.black)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
