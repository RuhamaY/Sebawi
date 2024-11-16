import 'package:Sebawi/application/providers/home_provider.dart';
import 'package:Sebawi/application/providers/user_provider.dart';
import 'package:Sebawi/data/models/posts_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../application/providers/posts_provider.dart';

final showFullListProvider = StateProvider<bool>((ref) => false);

class PostsPage extends ConsumerWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPosts = ref.watch(postsProvider);
    final asyncUser = ref.watch(userProvider);
    final showFullList = ref.watch(showFullListProvider);
    return asyncPosts.when(
      data: (posts) {
        int numOfRows = showFullList ? posts!.length : 4;
        double itemHeight = ((MediaQuery.of(context).size.width - 40) / 2) / 3;
        double gridHeight =
            (itemHeight * (numOfRows / 2)) + (5 * ((numOfRows / 2) - 1)) + 20;
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 280,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Colors.green.shade900,
                      Colors.green.shade100,
                    ],
                    tileMode: TileMode.mirror,
                  ),
                ),
                child: Card(
                  color: Colors.green.shade100,
                  margin: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.notifications_none,
                                  color: Colors.green.shade900)
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // First half for text
                          Expanded(
                            flex: 1, // Equal division (50%)
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                asyncUser.when(
                                  data: (user) => Center(
                                    child: Text(
                                      "Hey, ${user!.split(" ")[0]}! ",
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontFamily: "Lindsey",
                                        fontWeight: FontWeight.w800,
                                        color: Colors.green.shade800,
                                      ),
                                    ),
                                  ),
                                  loading: () => const CircularProgressIndicator(),
                                  error: (err, stack) => const Text("Error loading user"),
                                ),
                                const SizedBox(height: 8),
                                Center(
                                  child: Text(
                                    "Let's see who needs \n your help today :)",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green.shade800,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Second half for the image
                          Expanded(
                            flex: 1, // Equal division (50%)
                            child: Container(
                              alignment: Alignment.centerRight, // Align image to the right if needed
                              child: Image.asset(
                                "assets/images/fire.png",
                                fit: BoxFit.contain, // Scale the image to fit the space
                              ),
                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Categories",
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: SizedBox(
                        height: gridHeight,
                        child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          padding: const EdgeInsets.fromLTRB(10, 5, 15, 0),
                          childAspectRatio: 3,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(
                              posts!.length > numOfRows
                                  ? numOfRows
                                  : posts.length, (index) {
                            final colors = [
                              Colors.cyan.shade700,
                              Colors.brown.shade300,
                              Colors.indigo.shade200,
                              Colors.orange.shade800,
                              Colors.blueGrey.shade400,
                              Colors.amber.shade700,
                              Colors.purple.shade300,
                            ];
                            final icons = [
                              ImageIcon(AssetImage("assets/images/icons/volunteer.png"), color: Colors.white,),
                              Icon(Icons.child_friendly_rounded, color: Colors.white,),
                              Icon(Icons.elderly, color: Colors.white,),
                              Icon(Icons.pets, color: Colors.white,),
                            ];
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                    onPressed: () {
                                      final String? postId = posts[index].id;
                                      context.go('/post_details/$postId');
                                    },
                                    style: ButtonStyle(
                                      padding:
                                          WidgetStateProperty.all<EdgeInsets>(
                                              EdgeInsets.zero),
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                              colors[index % colors.length]),
                                      shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child:
                                            icons[index % icons.length],
                                        ),
                                        Flexible(
                                          child: Text(
                                            "${posts[index].name[0].toUpperCase()}${posts[index].name.substring(1).toLowerCase()}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    Consumer(builder: (context, ref, child) {
                      final showFullList = ref.watch(showFullListProvider);

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: GestureDetector(
                          onTap: () {
                            ref.read(showFullListProvider.notifier).state =
                                !showFullList;
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                showFullList
                                    ? "Show less Categories <"
                                    : "Browse all Categories >",
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight
                                        .bold), // Align the text within the container
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Column(
                  children: List.generate(
                    posts.length,
                    (index) {
                      return GestureDetector(
                        onTap: () {
                          final String? postId = posts[index].id;
                          context.go('/post_details/$postId');
                        },
                        child: PostItem(
                          post: posts[index],
                          isMyPost: true,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const Center(child: Text("Error loading posts")),
    );
  }
}

class PostItem extends ConsumerWidget {
  final Post post;
  final bool isMyPost;

  const PostItem({required this.post, required this.isMyPost, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final homeNotifier = ref.read(homeProvider);
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(children: [
                  Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/4.jpg'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "December 15, 2024",
                                  style: TextStyle(
                                      color: Colors.grey.shade300,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                                Text("5:00 PM - 7:00 PM",
                                    style: TextStyle(
                                        color: Colors.grey.shade300,
                                        fontSize: 12))
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.location_on_rounded,
                                    color: Colors.grey.shade300, size: 14),
                                const SizedBox(width: 7),
                                Text("Mt. Entoto",
                                    style: TextStyle(
                                        color: Colors.grey.shade300,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600))
                              ],
                            )
                          ],
                        ),
                      ))
                ]),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${post.name[0].toUpperCase()}${post.name.substring(1).toLowerCase()}",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.green.shade800),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      const SizedBox(height: 0),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Volunteers",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text("14/20",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500)
                                    ),
                                  ],

                                ),
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.82, // Set desired width
                                  height: 10, // Set desired height
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    // Background color for the container
                                    borderRadius:
                                        BorderRadius.circular(8), // Border radius
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    // Border radius for progress
                                    child: LinearProgressIndicator(
                                      value: 0.6,
                                      // Current progress value (from 0.0 to 1.0)
                                      backgroundColor: Colors.grey.shade300,
                                      // Background color of the indicator
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors
                                              .green.shade800), // Progress color
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade600,
                                            width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 10),
                                          Icon(Icons.check_circle,
                                              color: Colors.green.shade800, size: 20),
                                          const SizedBox(width:10),
                                          Text("Love & Care Ethiopia", style:TextStyle(color: Colors.green.shade700)),
                                          const SizedBox(width: 10),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: ImageIcon(const AssetImage("assets/images/icons/volunteer.png"),
                                          color: Colors.green.shade800, size: 20),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            )));
  }
}
