
import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/api_service.dart';

class PostViewModel extends ChangeNotifier {
  List<Post> _posts = [];
  List<Post> get posts => _posts;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _error = '';
  String get error => _error;

  Future<void> fetchPosts() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _posts = await ApiService.fetchPosts();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
