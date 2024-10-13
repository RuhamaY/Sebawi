import 'package:Sebawi/application/providers/agency_provider.dart';
import 'package:Sebawi/application/providers/posts_form_provider.dart';
import 'package:Sebawi/data/models/posts_model.dart';
import 'package:Sebawi/data/services/api_path.dart';
import 'package:Sebawi/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';

import '../../application/providers/myPosts_provider.dart';
import '../../application/providers/posts_provider.dart';

class AgencyHomePage extends ConsumerWidget {
  const AgencyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 8.0),
            child: Text("Sebawi",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Colors.green.shade800)),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, right: 16.0),
              child: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'logout') {
                    SharedPreferenceService sharedPrefService =
                    SharedPreferenceService();
                    sharedPrefService.writeCache(key: "token", value: "");
                    context.go("/");
                  } else if (value == 'update_profile') {
                    context.go('/user_update');
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(
                      value: 'update_profile',
                      child: Row(
                        children: [
                          Icon(Icons.edit, color: Colors.green.shade800),
                          const SizedBox(width: 8),
                          const Text('Update Profile'),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'logout',
                      child: Row(
                        children: [
                          Icon(Icons.logout, color: Colors.green.shade800),
                          const SizedBox(width: 8),
                          const Text('Logout'),
                        ],
                      ),
                    ),
                  ];
                },
                icon: const Icon(Icons.account_circle),
                color: const Color.fromARGB(255, 255, 255, 255),
                iconSize: 27,
              ),
            )
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  "All Posts",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800),
                ),
              ),
              Tab(
                child: Text(
                  "My Posts",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800),
                ),
              ),
              Tab(
                child: Text(
                  "Add Post",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800),
                ),
              ),
            ],
            onTap: (index) {
              if (index == 0) {
                // Assuming the calendar tab is the first one
                ref.read(postsProvider.notifier).refresh();
              } else if (index == 1) {
                ref.read(myPostsProvider.notifier).refresh();
              }
            },
            labelColor: const Color.fromARGB(255, 255, 255, 255),
            unselectedLabelColor: const Color.fromARGB(255, 255, 255, 255),
            indicatorColor: const Color.fromARGB(255, 147, 176, 149),
          ),
        ),
        body: TabBarView(
          children: [
            Consumer(
              builder: (context, ref, child) {
                final asyncPosts = ref.watch(postsProvider);
                return asyncPosts.when(
                  data: (posts) => ListView.builder(
                    itemCount: posts?.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          PostItem(
                            post: posts![index],
                            isMyPost: false,
                            onDelete: () {
                              // No action for delete in "All Posts"
                            },
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
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                final asyncMyCalendars = ref.watch(myPostsProvider);
                return asyncMyCalendars.when(
                  data: (myPosts) => ListView.builder(
                    itemCount: myPosts?.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              final String? postId = myPosts[index].id;
                                GoRouter.of(context).go('/post_details/$postId');
                            },
                            child:
                                PostItem(
                                  post: myPosts![index],
                                  isMyPost: true,
                                  onDelete: () {
                                    // Add your delete logic here
                                  },
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
                      const Center(child: Text("Error loading Posts")),
                );
              },
            ),
            const AddPostForm(),
          ],
        ),
      ),
    );
  }
}

class AddPostForm extends ConsumerWidget {
  const AddPostForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(postFormProvider);
    final formNotifier = ref.read(postFormProvider.notifier);
    final agencyNotifier = ref.read(agencyProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration:  InputDecoration(
                  labelText: 'Name',
                labelStyle: TextStyle(
                  fontSize: 14, // Change the font size
                  color: Colors.grey.shade600, // Change the font color
                ),
              ),
              onChanged: (value) => formNotifier.updateName(value),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            TextFormField(
              decoration:  InputDecoration(labelText: 'Description',labelStyle: TextStyle(
                fontSize: 14, // Change the font size
                color: Colors.grey.shade600, // Change the font color
              ),),
              onChanged: (value) => formNotifier.updateDescription(value),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            TextFormField(
              decoration:  InputDecoration(labelText: 'Contact',labelStyle: TextStyle(
                fontSize: 14, // Change the font size
                color: Colors.grey.shade600, // Change the font color
              ),),
              onChanged: (value) => formNotifier.updateContact(value),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your contact';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
                buttonText: 'Post',
                buttonColor: const Color.fromARGB(255, 255, 255, 255),
                buttonTextColor: const Color.fromARGB(255, 33, 94, 35),
                buttonAction: () async {
                  final newPost = Post(
                      name: formState.name,
                      contact: formState.contact,
                      description: formState.description);
                  try {
                    await agencyNotifier.addPost(newPost);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Post Created!"),
                        duration: Duration(milliseconds: 1000),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Failed to add post: ${e.toString()}')),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}

// Widget for displaying a single post
class PostItem extends StatelessWidget {
  final Post post;
  final bool isMyPost;
  final VoidCallback onDelete;

  const PostItem({
    required this.post,
    required this.isMyPost,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              post.name,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.green.shade800),
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
                      " Service Type: ",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(post.description),
                ],
              ),
              if (isMyPost)
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.grey.shade900,
                        ),
                        onPressed: () {
                          openDialog(context);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red.shade700,
                        ),
                        onPressed: onDelete,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future openDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Edit Post',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Agency Name',
                  hintText: 'Enter the name of the agency',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Contact Info',
                  hintText: 'Enter the contact information',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Service Type',
                  hintText: 'Enter the type of service',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all(Colors.redAccent.shade700),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Border radius
                  ),
                ),
              ),
              child: const Text(
                'Discard',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.green.shade800),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Border radius
                  ),
                ),
              ),
              child: const Text(
                'Save Changes',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
}
