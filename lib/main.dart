import 'package:bg_image/screens/book.dart';
import 'package:bg_image/utils/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BG",
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            bgImage,
            width: size.width,
            height: size.height,
            fit: BoxFit.cover,
          ),
          Positioned(
            child: Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white60, Colors.white38],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topLeft,
                ),
              ),
            ),
          ),
          BookDescription(
            book: Book(
              title: "A Journey of a Student in Germany",
              author: "F. Alec Budomo",
              imageUrls: [image1, image2, image3],
              description:
                  "Stepping into a new country is more than a change of place, it’s a transformation of self."
                  "\n\nIn A Journey of a Student in Germany, follow the true story of a student’s path from uncertainty to confidence while adjusting to life in a foreign land. From the first moments at the airport to navigating daily life, this memoir provides a personal look at the realities of studying abroad."
                  "\n\nInside this book, you’ll discover:"
                  "\n\nFirst impressions of German cities and student life"
                  "\n\nThe struggles of learning a new language and culture"
                  "\n\nInsights into university experiences as an international student"
                  "\n\nThe emotional balance between homesickness and growth"
                  "\n\nHow courage, curiosity, and resilience lead to personal transformation"
                  "\n\nWhether you’re preparing for your own study abroad journey, reflecting on your past experiences, or simply curious about life in Germany, this book offers a warm, relatable, and inspiring perspective.\n\n"
                  "“A heartfelt narrative about courage, adaptation, and discovery.”",
            ),
          ),
        ],
      ),
    );
  }
}
