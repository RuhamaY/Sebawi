import 'package:Sebawi/application/providers/myPosts_provider.dart';
import 'package:Sebawi/application/providers/post_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class PostDetailsPage extends ConsumerWidget {
  final String postId;

  const PostDetailsPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
      ),
      body:
      Consumer(
        builder: (context, ref, child) {
        final post = ref.watch(postDataProvider);
        return post.when(
          data: (post) {
            return Column(
              children: [
                Text(post!.name),
                Text(post.description),
                Text(post.contact),
              ],
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
        );
      },

      ),
    );
  }
}
