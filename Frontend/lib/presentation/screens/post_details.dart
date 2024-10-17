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
      body: Consumer(
        builder: (context, ref, child) {
          final postAsyncValue = ref.watch(postDetailProvider(postId));
          return postAsyncValue.when(
            data: (post) {
              return Center(
                child: Column(
                  children: [
                    AppBar(
                      backgroundColor: Colors.transparent,
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          context.go("/user_home");
                        },
                      ),
                      title: Text(
                        post!.name,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 26),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        children: [

                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            // Sets the border radius
                            child: Image.asset(
                              "assets/images/4.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.phone, color: Colors.green.shade800,),
                                Text(post.contact)
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Text(
                                post.description,
                                style: TextStyle(fontSize: 17, color: Colors.grey.shade700, fontWeight: FontWeight.w500),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
