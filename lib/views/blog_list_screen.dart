import 'package:blog_app/model/blog_model.dart';
import 'package:blog_app/provider/blog_provider.dart';
import 'package:blog_app/views/bloglist.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class BlogListScreen extends StatefulWidget {
  @override
  State<BlogListScreen> createState() => _BlogListScreenState();
}

class _BlogListScreenState extends State<BlogListScreen> {
  TextEditingController _textEditingController = TextEditingController();
  bool _showClearIcon = false;
  late bool _isLoading;

  @override
  void initState() {
    _isLoading = true;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
    _textEditingController.addListener(() {
      setState(() {
        _showClearIcon = _textEditingController.text.isNotEmpty;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _clearText() {
    setState(() {
      _textEditingController.clear();
      _showClearIcon = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.menu,
          color: Colors.black,
          size: 30.0,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.search,
              size: 30.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey[200],
              ),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: _showClearIcon
                      ? IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: _clearText,
                        )
                      : null,
                  hintText: 'Search',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureProvider<List<Blog>>(
              create: (_) => context.read<BlogProvider>().fetchBlogs(),
              initialData: [],
              child: _isLoading
                  ? Center(child: Lottie.asset('assets/loading.json'))
                  : BlogList(),
            ),
          ),
        ],
      ),
    );
  }
}
