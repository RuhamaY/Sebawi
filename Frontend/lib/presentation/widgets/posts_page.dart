import 'package:Sebawi/application/providers/home_provider.dart';
import 'package:Sebawi/data/models/posts_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../application/providers/posts_provider.dart';

class PostsPage extends ConsumerWidget {
  const PostsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPosts = ref.watch(postsProvider);
    return asyncPosts.when(
      data: (posts) =>
          ListView.builder(
            itemCount: posts?.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      final String? postId = posts[index].id;
                      context.go('/post_details/$postId');
                    },
                    child: PostItem(
                      post: posts![index],
                      isMyPost: true,
                    ),
                  ),
                  Divider(
                    height: 10,
                    thickness: 1,
                    color: Colors.grey.shade200,
                  ),
                ],
              );
            },
          ),
      loading: () =>
      const Center(child: CircularProgressIndicator()),
      error: (err, stack) =>
      const Center(child: Text("Error loading posts")),
    );
  }
}

class PostItem extends ConsumerWidget {
  final Post post;
  final bool isMyPost;

  const PostItem({required this.post, required this.isMyPost, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeNotifier = ref.read(homeProvider);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.grey.shade200,
              Colors.grey.shade100,
            ],
          ),
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Text(
              "${post.name[0].toUpperCase()}${post.name.substring(1).toLowerCase()}",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.green.shade800,
              ),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.phone_android,
                      size: 14, color: Colors.green.shade800),
                  const Text(
                    " Contact: ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(post.contact),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.medical_services,
                      size: 14, color: Colors.green.shade800),
                  const Center(
                    child: Text(
                      " Service Type",
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Text(post.description),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (isMyPost) ...[
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                          WidgetStateProperty.all(Colors.green.shade800),
                          shape:
                          WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Sign Me Up',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            helpText: "Choose a date to volunteer",
                            confirmText: "Done",
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 1),
                          ).then((pickedDate) {
                            if (pickedDate != null) {
                              homeNotifier.addToCalendar(
                                pickedDate.toString().split(" ")[0],
                                post.id.toString(),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Calendar event added for ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        pickedDate.toString().split(" ")[0],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  duration: const Duration(milliseconds: 1000),
                                ),
                              );
                            }
                          });
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}