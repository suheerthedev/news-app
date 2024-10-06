import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/news_service.dart';
import 'package:news_app/utils/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<NewsResponse> futureNews;

  @override
  void initState() {
    super.initState();
    futureNews = NewsService().fetchNews('popular');
  }

  void updateNews (String topicName){
    setState(() {
      futureNews = NewsService().fetchNews(topicName);
    });
  }
  @override
  Widget build(BuildContext context) {
    List<String> tabsTitle = [
      'Popular',
      'All',
      'Politics',
      'Tech',
      'Health',
      'Science',
      'Bitcoin',
      'Zardari'
    ];
    return DefaultTabController(
      length: tabsTitle.length,
      child: Scaffold(
        drawer: Container(
            margin: const EdgeInsets.only(left: 20),
            child: const Icon(Iconsax.menu)),
        appBar: AppBar(
          // automaticallyImplyLeading: false,
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              alignment: Alignment.centerLeft,
              child: const Text("Recommendation", style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 26),)),
              
            Container(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              alignment: Alignment.centerLeft,
              child: TabBar(
                  isScrollable: true,
                  indicatorColor: AppColors.surfaceColor,
                  labelColor: AppColors.textPrimaryColor,
                  labelPadding: const EdgeInsets.only(right: 10),
                  tabs: [
                    Tab(
                      text: tabsTitle[0],
                    ),
                    Tab(
                      text: tabsTitle[1],
                    ),
                    Tab(
                      text: tabsTitle[2],
                    ),
                    Tab(
                      text: tabsTitle[3],
                    ),
                    Tab(
                      text: tabsTitle[4],
                    ),
                    Tab(
                      text: tabsTitle[5],
                    ),
                    Tab(
                      text: tabsTitle[6],
                    ),
                    Tab(
                      text: tabsTitle[7],
                    ),
                  ]),
            ),
            FutureBuilder(future: futureNews, builder:(context, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              }else if(snapshot.hasError) {
                return  Center(child: Text('Error: ${snapshot.error}'));
              }else if (snapshot.hasData){
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data?.articles.length ?? 0,
                    itemBuilder: (context, index){
                      var article = snapshot.data!.articles[index];
                      return Container(
                        child: Column(

                        ),
                      );
                    },
                  ),
                );
              }else{
                return const Center(child: Text("No Data Available"),);
              }
              
            })
          ],
        ),
      ),
    );
  }
}
