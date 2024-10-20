import 'package:Sebawi/presentation/widgets/calendar_page.dart';
import 'package:Sebawi/presentation/widgets/posts_page.dart';
import 'package:Sebawi/presentation/widgets/search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/services/api_path.dart';

final bottomNavIndexProvider = StateProvider<int>((ref) => 0);
class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
         Scaffold(
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
          ),
          body: Consumer(
            builder: (context, ref, child) {
              final selectedIndex = ref.watch(bottomNavIndexProvider);
              final List<Widget> pages = [
                const PostsPage(),
                const CalendarPage(),
                const SearchPage(),
              ];
              return pages[selectedIndex];
            }
          ),
          bottomNavigationBar: Consumer(
            builder: (context, ref, child){
              final selectedIndex = ref.watch(bottomNavIndexProvider);
              return BottomNavigationBar(
                currentIndex: selectedIndex,
                onTap: (index) {
                  ref.read(bottomNavIndexProvider.notifier).state = index;
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage("assets/images/icons/volunteer.png")),
                    label: 'Posts',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_month_sharp),
                    label: 'My Calendar',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Search',

                  ),
                ],
                selectedLabelStyle: TextStyle(
                  color: Colors.green.shade800,
                  fontWeight: FontWeight.bold,
                ),
              );
            }
          )
        ),
      theme: ThemeData(
        fontFamily: "FigTree",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade800),
      ),
    );
  }
}

