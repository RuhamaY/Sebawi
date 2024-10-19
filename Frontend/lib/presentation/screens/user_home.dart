import 'package:Sebawi/application/providers/home_provider.dart';
import 'package:Sebawi/data/models/calendars.dart';
import 'package:Sebawi/data/models/posts_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/providers/posts_provider.dart';
import '../../application/providers/calendar_provider.dart';
import '../../data/services/api_path.dart';

class UserHomePage extends ConsumerWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 8.0),
              child: Text('Sebawi',
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
                  iconSize: 30,
                ),
              )
            ],
            bottom: TabBar(
              tabs: const [
                Tab(
                    child: Column(
                  children: [
                    Icon(Icons.list),
                    Text(
                      "Posts",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
                Tab(
                    child: Column(
                  children: [
                    Icon(Icons.calendar_month_sharp),
                    Text(
                      "My Calendar",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
                Tab(
                  child: Column(
                    children: [
                      Icon(Icons.search),
                      Text(
                        "Search",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
              onTap: (index) {
                if (index == 1) {
                  // Assuming the calendar tab is the first one
                  ref.read(calendarsProvider.notifier).refresh();
                } else if (index == 0) {
                  ref.read(postsProvider.notifier).refresh();
                }
              },
              labelColor: Colors.green.shade800,
              unselectedLabelColor: Colors.grey.shade800,
              indicatorColor: Colors.green.shade800,
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
                },
              ),
              Consumer(
                builder: (context, ref, child) {
                  final asyncCalendars = ref.watch(calendarsProvider);
                  return asyncCalendars.when(
                    data: (calendars) => ListView.builder(
                      itemCount: calendars?.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            CalendarItem(
                              calendar: calendars![index],
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
                        const Center(child: Text("Error loading Calendar")),
                  );
                },
              ),
              SingleChildScrollView(
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
                          Icon(Icons.filter_list_rounded, color: Colors.grey),
                          // Example of adding an icon
                        ],
                      ),
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        final asyncPosts = ref.watch(postsProvider);
                        return asyncPosts.when(
                          data: (posts) {
                            int numOfRows = 6;
                            double itemHeight =
                                ((MediaQuery.of(context).size.width - 40) / 2) /
                                    2.5;
                            double gridHeight = (itemHeight * (numOfRows / 2)) +
                                (5 * ((numOfRows / 2) - 1)) +
                                20;
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
                                  onTap: () {},
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      // Align text to the right
                                      child: Text(
                                        "more",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontWeight: FontWeight
                                                .bold), // Align the text within the container
                                      ),
                                    ),
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
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
                                        20, 20, 20, 20),
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
                                                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(Icons.home, size: 14, color: Colors.grey.shade700),
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
              )
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Add Post',
              ),
            ],
            onTap: (index) {
              if (index == 1) {
                context.go('/add_post');
              }
            },
          ),
        ),
      ),
      theme: ThemeData(
        fontFamily: "FigTree",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade800),
      ),
    );
  }
}

class CalendarItem extends ConsumerWidget {
  final Calendar calendar;

  const CalendarItem({required this.calendar, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${calendar.name[0].toUpperCase()}${calendar.name.substring(1).toLowerCase()}",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.green.shade800,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.medical_services,
                        size: 14, color: Colors.green.shade800),
                    const Center(
                      child: Text(
                        " Service Type: ",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(calendar.description),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Scheduled to ${calendar.date}'),
                    ],
                  ),
                ),
              ],
            ),
            leading: Icon(
              Icons.calendar_today,
              size: 40,
              color: Colors.green.shade700,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    ref
                        .read(homeProvider.notifier)
                        .deleteCalendar(calendar.id!);
                    ref.read(calendarsProvider.notifier).refresh();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Calendar Entry Deleted"),
                        duration: Duration(milliseconds: 1000),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      helpText: "Choose new date for volunteering",
                      confirmText: "Update",
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(DateTime.now().year + 1),
                    ).then((pickedDate) {
                      if (pickedDate != null) {
                        ref.read(homeProvider.notifier).updateCalendar(
                            pickedDate.toString().split(" ")[0], calendar.id!);
                        ref.read(calendarsProvider.notifier).refresh();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "Calendar event updated to",
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
            )),
      ),
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
