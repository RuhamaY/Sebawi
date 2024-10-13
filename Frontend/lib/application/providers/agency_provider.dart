import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Sebawi/data/services/api_path.dart'; 
import 'package:Sebawi/data/models/posts_model.dart'; 

class AgencyProvider extends ChangeNotifier {
  final List<Post> _posts = [];
  bool _isLoading = false;
  String? _errorMessage;
  final RemoteService _remoteService = RemoteService();

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> addPost(Post post) async {
    _isLoading = true;
    notifyListeners();
    SharedPreferenceService sharedPrefService = SharedPreferenceService();
    String? userId = await sharedPrefService.readCache(key: "uId");
    if (userId == null) {
      return;
    }
    Post updatedPost = Post(
      name: post.name,
      description: post.description,
      contact: post.contact,
      user: userId,
    );
    try {
      final statusCode = await _remoteService.addPost(json.encode(updatedPost.toJson()));
      if (statusCode == 200 || statusCode == 201) {
        _posts.add(post);
      } else {
        _errorMessage = "Failed to add post";
      }
    } catch (e) {
      print(e.toString());
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updatePost(int index, Post updatedPost) async {
    _isLoading = true;
    notifyListeners();

    try {
      final statusCode = await _remoteService.editPost(updatedPost.id, updatedPost.toJson());
      if (statusCode == 200) {
        _posts[index] = updatedPost;
      } else {
        _errorMessage = "Failed to update post";
      }
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> deletePost(int index) async {
    _isLoading = true;
    notifyListeners();

    try {
      final statusCode = await _remoteService.deletePost(_posts[index].id);
      if (statusCode == 200) {
        _posts.removeAt(index);
      } else {
        _errorMessage = "Failed to delete post";
      }
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}

// Provider definition
final agencyProvider = ChangeNotifierProvider((ref) => AgencyProvider());
