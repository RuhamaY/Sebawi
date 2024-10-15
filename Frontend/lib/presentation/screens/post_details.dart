import 'package:Sebawi/application/providers/post_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PostDetailsPage extends ConsumerWidget {
  final String postId;

  const PostDetailsPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body:
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 200.0,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/4.jpg"),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                  SafeArea(
                    child: SizedBox(
                      child: AppBar(
                        backgroundColor: Colors.transparent,
                        leading: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            context.go("/agency_home");
                          },
                        ),
                        title: const Text('Post Details'),
                      ),
                    ),
                  ),
                ],
              ),
              Consumer(
                builder: (context, ref, child) {
                  final postAsyncValue = ref.watch(postDetailProvider(postId));
                  return postAsyncValue.when(
                    data: (post) {
                      return Column(
                        children: [
                          Text(post!.name,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
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
            ],
          ),

    );
  }
}
