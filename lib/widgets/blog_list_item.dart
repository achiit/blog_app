import 'package:blog_app/model/blog_model.dart';
import 'package:blog_app/views/blog_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';
import 'package:blog_app/provider/blog_notifier.dart'; // Import the BlogNotifier

class BlogListItem extends StatefulWidget {
  final Blog blog;

  BlogListItem({required this.blog});

  @override
  _BlogListItemState createState() => _BlogListItemState();
}

class _BlogListItemState extends State<BlogListItem> {
  bool isFavorite = false; // Initially not marked as favorite.

  @override
  Widget build(BuildContext context) {
    final blogNotifier = Provider.of<BlogNotifier>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () {
          // Use BlogNotifier to select the blog
          blogNotifier.selectBlog(widget.blog);

          // Navigate to BlogDetailPage
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BlogDetailPage(),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.grey[200],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CachedNetworkImage for displaying the image with a placeholder.
              Container(
                width: double.infinity,
                height: 200.0, // Adjust the height as needed.
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      12.0), // Adjust the border radius as needed.
                  child: Image.network(
                    widget.blog.imageUrl,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            color: Colors.white,
                          ),
                        );
                      }
                    },
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Icon(Icons.error);
                    },
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              // Wrap the title in an Expanded widget to prevent overflow.
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, left: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.blog.title,
                        style: GoogleFonts.poppins(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    // Favorite icon button.
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : null,
                      ),
                      onPressed: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
