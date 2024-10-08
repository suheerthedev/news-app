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

     List<String> topics = [
      'pakistan',
      'popular',
      'technology',
      'sports',
      'politics',
      'crypto',
    ];

     List<String> tabsTitle = [
      'All',
      'Popular',
      'Technology',
      'Sports',
      'Politics',
      'Crypto',
    ];

       List<String> locations = const [
      "Pakistan",
      "United States",
      "United Arab Emirates",
      "United Kingdom",
      "India",
    ];

  @override
  void initState() {
    super.initState();
    futureNews = NewsService().fetchNews(topics[0]);
  }

  void updateNews(String topicName) {
    setState(() {
      futureNews = NewsService().fetchNews(topicName);
    });
  }
  
     String _selectedLocation = "Pakistan";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabsTitle.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffb20710),
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
                  DropdownButton(
                    iconEnabledColor: Colors.white,
                    dropdownColor: const Color(0xffb20710),
                    
                    value: _selectedLocation,
                    onChanged: (String? newValue){
                      setState(() {
                        _selectedLocation = newValue!;
                      });
                    },
                    items: locations.map((String location){
                      return DropdownMenuItem<String>(
                        
                        value: location,
                        child: Text(location, style:const TextStyle(color: Colors.white),) ,
                      );
                    }).toList(),
                    )
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
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 0),
                child: TabBar(
                  tabAlignment: TabAlignment.start,
                  padding: EdgeInsets.zero,
                  isScrollable: true,
                  indicatorColor: const Color(0xffb20710),
                  labelColor: const Color(0xffb20710),
                  unselectedLabelColor: Colors.black,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                  tabs:
                      tabsTitle.map((category) => Tab(text: category)).toList(),
                ),
              ),

              Expanded(
  child: TabBarView(
    children: tabsTitle.asMap().entries.map((entry) {
      int tabIndex = entry.key;

      // Update news when the tab changes
    updateNews(tabsTitle[tabIndex]); // Pass the tab name as a String


      // FutureBuilder to display news for the selected tab
      return FutureBuilder(
        future: futureNews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.articles.length ?? 0,
              itemBuilder: (context, index) {
                var article = snapshot.data!.articles[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey,
                              child: const Icon(
                                Icons.broken_image,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article.title!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              article.description!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
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
              child: Text('No data available'),
            );
          }
        },
      );
    }).toList(),
  ),
),
            ],
          ),
        ),
      ),
    );
  }
}
