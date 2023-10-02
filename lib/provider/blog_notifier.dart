import 'package:flutter/foundation.dart';
import 'package:blog_app/model/blog_model.dart';

class BlogNotifier extends ChangeNotifier {
  Blog? _selectedBlog;

  Blog? get selectedBlog => _selectedBlog;

  void selectBlog(Blog blog) {
    _selectedBlog = blog;
    notifyListeners();
  }

  void clearSelectedBlog() {
    _selectedBlog = null;
    notifyListeners();
  }
}
