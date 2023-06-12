import 'package:flutter/material.dart';
import 'package:movie/ui/pages/explore_page/explore_page.dart';
import 'package:movie/ui/pages/move_db_body/move_db_body.dart';
import 'package:movie/ui/pages/my_list_page/favourite_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List<Widget> screens = [
    const MovieDbBody(),
    const ExplorePage(),
    const FavouritePage(),
  ];
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(
      length: screens.length,
      vsync: this,
      initialIndex: 0,
    );

    return Scaffold(
      body: TabBarView(
        controller: tabController,
        children: screens,
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 70,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          color: Colors.white,
        ),
        child: BottomNavBarItem(tabController: tabController),
      ),
    );
  }
}

class BottomNavBarItem extends StatelessWidget {
  const BottomNavBarItem({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TabBar(
            enableFeedback: true,
            labelColor: Colors.red,
            unselectedLabelColor: Colors.grey,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            indicatorColor: Colors.transparent,
            controller: tabController,
            tabs: const [
              Tab(
                icon: Icon(
                  Icons.home_filled,
                  size: 28,
                ),
                text: 'Home',
              ),
              Tab(
                icon: Icon(
                  Icons.explore,
                  size: 28,
                ),
                text: 'Explore',
              ),
              Tab(
                icon: Icon(
                  Icons.bookmark_border,
                  size: 28,
                ),
                text: 'My List',
              ),
            ],
          ),
        )
      ],
    );
  }
}
