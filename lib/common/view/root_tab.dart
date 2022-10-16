import 'package:actual/common/const/colors.dart';
import 'package:actual/common/layout/default_layout.dart';
import 'package:actual/restaurant/view/restaurant_screen.dart';
import 'package:flutter/material.dart';

class RootTab extends StatefulWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  int index = 0;
  late TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 4, vsync: this);
    controller.addListener(
      tabListener,
    );
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.removeListener(
      tabListener,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '282 Delievery',
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          RestaurantScreen(),
          Center(
            child: Container(
              child: Text(
                'food',
              ),
            ),
          ),
          Center(
            child: Container(
              child: Text(
                'order',
              ),
            ),
          ),
          Center(
            child: Container(
              child: Text(
                'profile',
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          controller.animateTo(index);
        },
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.fastfood_outlined,
            ),
            label: 'Food',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.receipt_long_outlined,
            ),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outlined,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
