import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Sebawi/data/models/posts_model.dart';
import 'package:Sebawi/data/services/api_path.dart';

final postDetailProvider = FutureProvider.family<Post?, String>((ref, postId) async {
  final service = RemoteService();
  final post = await service.getPost(postId);
  if (post == null) {
    throw Exception('Post not found');
  }
    return post;
  });
