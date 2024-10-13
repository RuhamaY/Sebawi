import 'package:Sebawi/data/services/api_path.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Sebawi/data/models/posts_model.dart';

class PostDetailsNotifier extends AsyncNotifier<Post?> {
  late String id;
  @override
  Future <Post?> build() async {
    return await fetchPostDetails(id);
  }

  Future<Post?> fetchPostDetails(String postId) async {
    final service = RemoteService();
    return await service.getPost(postId);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => fetchPostDetails(id));
  }
}

final postDetailProvider = Provider<PostDetailsNotifier>((ref) => PostDetailsNotifier());

final postDataProvider = FutureProvider<Post?>((ref) async {
  return ref.watch(postDetailProvider).fetchPostDetails(ref.read(postDetailProvider).id);
});