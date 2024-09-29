import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:news_app/utils/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List<String> tabsTitle = [
      'Popular',
      'All',
      'Politics',
      'Tech',
      'Health',
      'Science',
      'Imran Jani',
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
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: TabBar(
                  isScrollable: true,
                  indicatorColor: AppColors.surfaceColor,
                  labelColor: AppColors.textPrimaryColor,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 1),
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
            )
          ],
        ),
      ),
    );
  }
}
