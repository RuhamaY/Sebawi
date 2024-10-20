import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../application/providers/posts_provider.dart';

final showFullListProvider = StateProvider<bool>((ref) => false);
class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'Find Opportunities',
                      hintStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600),
                      prefixIcon: Icon(Icons.search, size: 18),
                      prefixIconColor: Colors.grey,
                      contentPadding:
                      EdgeInsets.fromLTRB(0, 12, 0, 0),
                    ),
                  ),
                ),
                ImageIcon(AssetImage("assets/images/icons/filter.png"),color: Colors.grey,size: 20,),
                // Example of adding an icon
              ],
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              final asyncPosts = ref.watch(postsProvider);
              final showFullList = ref.watch(showFullListProvider);
              return asyncPosts.when(
                data: (posts) {
                  int numOfRows = showFullList ? posts!.length : 6; // Show all if true
                  double itemHeight = ((MediaQuery.of(context).size.width - 40) / 2) / 2.5;
                  double gridHeight = (itemHeight * (numOfRows / 2)) +
                      (5 * ((numOfRows / 2) - 1)) + 20;
                  return Column(
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: SizedBox(
                          height: gridHeight,
                          child: GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            padding: const EdgeInsets.fromLTRB(
                                15, 5, 15, 0),
                            childAspectRatio: 2.5,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true, // Adjust height based on content
                            children: List.generate(
                                posts!.length > numOfRows
                                    ? numOfRows
                                    : posts.length, (index) {
                              return Stack(
                                children: [
                                  Stack(
                                    children: [
                                      // Background image
                                      Container(
                                        decoration: BoxDecoration(
                                          image:
                                          const DecorationImage(
                                            image: AssetImage(
                                                'assets/images/4.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(
                                              25),
                                        ),
                                      ),

                                      // Dark overlay
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black
                                              .withOpacity(0.2),
                                          // Adjust opacity to darken
                                          borderRadius:
                                          BorderRadius.circular(
                                              25),
                                        ),
                                      ),
                                      // Content on top of the image and overlay
                                      Center(
                                        child: Text(
                                          posts[index].name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight:
                                            FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            }),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          ref.read(showFullListProvider.notifier).state = !showFullList;
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            // Align text to the right
                            child: Text(
                              showFullList
                                  ? "less"
                                  : "more",
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  fontWeight: FontWeight
                                      .bold), // Align the text within the container
                            ),
                          ),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(25, 20, 0, 0),
                          child: Text(
                            "Popular on Sebawi",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(
                              20, 10, 20, 20),
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ClipRRect(
                                    borderRadius:
                                    const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(
                                          15),
                                    ),
                                    child: Image.asset(
                                        'assets/images/5.jpg')),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                                  child: Column(
                                    children: [
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Community Garden Volunteering',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800
                                          ),textAlign: TextAlign.left,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Row(
                                        children: [
                                          Icon(Icons.location_on_rounded, size: 14, color: Colors.grey.shade600),
                                          const SizedBox(width: 5),
                                          Text(
                                            "Mt. Entoto",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600, color: Colors.grey.shade700),
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Wed, 15th July - 9:30 am",  style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600, color: Colors.grey.shade700),),
                                      ),
                                      const SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                ImageIcon(const AssetImage("assets/images/icons/house.png"),color: Colors.grey.shade700,size: 14,),
                                                const SizedBox(width: 5),
                                                Text(
                                                  "Treehearts Foundation",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w600, color: Colors.grey.shade600),
                                                ),
                                              ],
                                            ),
                                            Icon(Icons.add_circle_outline_rounded, color: Colors.grey.shade700,)
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ))
                    ],
                  );
                },
                error: (err, stack) =>
                const Center(child: Text("Error loading posts")),
                loading: () =>
                const Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ],
      ),
    );
  }
}