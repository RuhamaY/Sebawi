import 'package:Sebawi/presentation/widgets/calendar_page.dart';
import 'package:Sebawi/presentation/widgets/posts_page.dart';
import 'package:Sebawi/presentation/widgets/search_page.dart';
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
          body: Consumer(
            builder: (context, ref, child) {
              final selectedIndex = ref.watch(bottomNavIndexProvider);
              final List<Widget> pages = [
                const PostsPage(),
                const CalendarPage(),
                const SearchPage(),
              ];
              return (
                  pages[selectedIndex]
              );
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

