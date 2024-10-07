import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/news_service.dart';
import 'package:news_app/utils/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<NewsResponse> futureNews;

  @override
  void initState() {
    super.initState();
    futureNews = NewsService().fetchNews('pakistan');
  }

  void updateNews(String topicName) {
    setState(() {
      futureNews = NewsService().fetchNews(topicName);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> tabsTitle = [
      'Healthy',
      'Technology',
      'Finance',
      'Arts',
      'Sports',
      'Science',
      'Bitcoin',
      'Zardari'
    ];

    return DefaultTabController(
      length: tabsTitle.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:const Color(0xffb20710),
          leadingWidth: 45,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 18,
                    color: AppColors.iconPrimaryColor,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "Location",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              Icon(
                Iconsax.notification,
                size: 24,
                color: AppColors.iconPrimaryColor,
              )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Latest News Section
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Top Headlines",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(
                          color: Color(0xffb20710),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xffb20710)),
                    )
                  ],
                ),
              ),

              // Featured Articles (Horizontal Scroll)
              SizedBox(
                height: 200,
                child: FutureBuilder(
                    future: futureNews,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        return Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data?.articles.length ?? 0,
                            itemBuilder: (context, index) {
                              var article = snapshot.data!.articles[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: 300,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(article.imageUrl!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.black.withOpacity(0.9),
                                            Colors.black54
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'by ${article.author}',
                                              style: const TextStyle(
                                                  color: Color(0xffb20710),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              article.title!,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              article.description!,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text("No Data Available"),
                        );
                      }
                    }),
              ),
              const SizedBox(height: 15),
             const Text(
                "Latest News",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              // Category Tabs (Scrollable)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: TabBar(
                  isScrollable: true,
                  indicatorColor: const Color(0xffb20710),
                  labelColor: const Color(0xffb20710),
                  unselectedLabelColor: Colors.black,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                  tabs:
                      tabsTitle.map((category) => Tab(text: category)).toList(),
                ),
              ),

              // News List Section
              Expanded(
                child: FutureBuilder(
                    future: futureNews,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data?.articles.length ?? 0,
                          itemBuilder: (context, index) {
                            var article = snapshot.data!.articles[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      article.imageUrl!,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                          width: 100,
                                          height: 100,
                                          color: Colors
                                              .grey, // Background color for the fallback
                                          child: const Icon(
                                            Icons.broken_image,
                                            color: Colors.white,
                                          ), // Placeholder icon or image
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          article.title!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          article.description!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 14),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          'by ${article.author}, ${article.publishedAt}',
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text("No Data Available"),
                        );
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
