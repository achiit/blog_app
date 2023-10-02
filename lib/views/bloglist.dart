import 'package:blog_app/model/blog_model.dart';
import 'package:blog_app/views/blog_list_screen.dart';
import 'package:blog_app/widgets/blog_list_item.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class BlogList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Blog>? blogs = context.watch<List<Blog>>();

    if (blogs!.isEmpty) {
      // Data loaded but no blogs available.
      return Center(child: Lottie.asset('assets/loading.json'));
    } else {
      // Data loaded, display the list of blogs.
      return ListView.builder(
        itemCount: blogs.length,
        itemBuilder: (context, index) {
          final blog = blogs[index];
          return BlogListItem(blog: blog);
        },
      );
    }
  }
}
