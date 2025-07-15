import 'package:flutter/material.dart';

class Book {
  final String title;
  final String author;
  final List<String> imageUrls; // For book cover images
  final String description;

  Book({
    required this.title,
    required this.author,
    required this.imageUrls,
    required this.description,
  });
}

class BookDescription extends StatefulWidget {
  final Book book;

  const BookDescription({super.key, required this.book});

  @override
  State<BookDescription> createState() => _BookDescriptionState();
}

class _BookDescriptionState extends State<BookDescription> {
  int _currentImage = 0;

  late List<String> images;

  @override
  void initState() {
    super.initState();
    images = widget.book.imageUrls; // Initialize images from the book object
    // Ensure that if imageUrls is empty, it doesn't cause an error
    if (widget.book.imageUrls.isEmpty) {
      // Optionally, add a placeholder image or handle this case
      // For example, add a local asset placeholder
      images = ['assets/bg_image.png'];
    }
  }

  List<Widget> buildPageIndicator() {
    List<Widget> list = [];
    if (widget.book.imageUrls.length <= 1) {
      return list; // Don't show indicators for 0 or 1 image
    }
    for (var i = 0; i < widget.book.imageUrls.length; i++) {
      list.add(buildIndicator(i == _currentImage));
    }
    return list;
  }

  Widget buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      height: 8,
      width: isActive ? 15 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.grey[400], // Theme color
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.book.imageUrls.isNotEmpty)
            Expanded(
              flex: 2,
              child: PageView(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int page) {
                  setState(() {
                    _currentImage = page;
                  });
                },
                children: widget.book.imageUrls.map((path) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Hero(
                      tag: widget.book.title,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(path),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          if (widget.book.imageUrls.length > 1)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: buildPageIndicator(),
              ),
            )
          else
            const SizedBox(height: 12), // Maintain some spacing
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.book.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Theme.of(
                        context,
                      ).textTheme.titleLarge!.fontSize, // Adjusted size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "by ${widget.book.author}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Theme.of(
                        context,
                      ).textTheme.bodySmall!.fontSize, // Adjusted size
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Description",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.fontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.book.description,
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.fontSize,
                      height: 1.5, // Line height for readability
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildDetailRow("Genre", "Adventure"),
                  _buildDetailRow("Published", "2025"),
                ],
              ),
            ),
          ),
          // Optional: Action Button (e.g., Read Now, Add to Library)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Theme color
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {

              },
              child: const Text(
                "Order Now",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            "$title: ",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.black87, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
