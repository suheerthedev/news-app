import 'package:flutter/material.dart';
import 'package:news_app/models/news_model.dart';

class ArticleDetailsScreen extends StatelessWidget {

  const ArticleDetailsScreen({super.key});

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
                'https://media.wired.com/photos/66c5ecc5724cee849e3104da/191:100/w_1280,c_limit/WIRED_BTC_EC_B-Elena-Chudoba.jpg', // Replace with your image URL
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
              
              // Date and Title container
             SizedBox(height: 100),
        
              // Article content
             const Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LONDON — Cryptocurrencies “have no intrinsic value” and people who invest in them should be prepared to lose all their money, Bank of England Governor Andrew Bailey said.',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Digital currencies like bitcoin, ether and even dogecoin have been on a tear this year, reminding some investors of the 2017 crypto bubble in which bitcoin blasted toward \$20,000, only to sink as low as \$3,122 a year later.',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Asked at a press conference Thursday about the rising value of cryptocurrencies, Bailey said that they have no intrinsic value. That doesn’t mean that people don’t put value on them, because they can have extrinsic value. But they have no intrinsic value.”',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                    // Add more text content as needed...
                  ],
                ),
              ),
            ],
          ),
        ),
         Positioned(
                top: 180,
                right: 20,
                left: 20,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Container(
                    // padding: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.red.withOpacity(0.9),Colors.black.withOpacity(0.9)]),
                  borderRadius: BorderRadius.circular(15),
                ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sunday, 9 May 2021', // Date
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Crypto investors should be prepared to lose all their money, BOE governor says', // Title
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Published by Ryan Browne', // Author name
                          style: TextStyle(
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
                color: Colors.white.withOpacity(0.9),
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
