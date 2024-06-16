import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:dot_com/client/screens/filter/filter_screen.dart';
import 'package:flutter/material.dart';

import '../profile/my_account.dart';
import 'client_home_page.dart';

class ClientHome extends StatefulWidget {
  const ClientHome({super.key});

  @override
  State<ClientHome> createState() => _ClientHomeState();
}

class _ClientHomeState extends State<ClientHome> {
  final _pageController = PageController(initialPage: 0);
  final _controller = NotchBottomBarController(index: 0);
  int maxCount = 3;
  List<Widget> bottomBarPages = [];

  @override
  void initState() {
    super.initState();
    bottomBarPages = [
      ClientPage(),
      Container(), // Placeholder for Page 2 content
      MyAccountWrapper(),
    ];
  }

  void _closeFilterScreen() {
    _pageController.jumpToPage(0);
    setState(() {
      _controller.index = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(bottomBarPages.length, (index) => bottomBarPages[index]),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedNotchBottomBar(
              /// Provide NotchBottomBarController
              notchBottomBarController: _controller,
              color: Color(0xffFC5D5D),
              showLabel: false,
              shadowElevation: 5,
              kBottomRadius: 28.0,
              notchColor: Color(0xffFFF5E1),
              removeMargins: false,
              bottomBarWidth: 500,
              showShadow: false,
              durationInMilliSeconds: 300,
              elevation: 1,
              bottomBarItems: const [
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                  ),
                  activeItem: Icon(
                    Icons.home_outlined,
                    color: Color(0xffFC5D5D),
                  ),
                  itemLabel: 'Home',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.apps_outlined,
                    color: Colors.white,
                  ),
                  activeItem: Icon(
                    Icons.apps_outlined,
                    color: Color(0xffFC5D5D),
                  ),
                  itemLabel: 'Page 2',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.people_alt_outlined,
                    color: Colors.white,
                  ),
                  activeItem: Icon(
                    Icons.people_alt_outlined,
                    color: Colors.pink,
                  ),
                  itemLabel: 'Page 3',
                ),
              ],
              onTap: (index) {
                if (index == 1) {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return WillPopScope(
                          onWillPop: () async {
                            _closeFilterScreen();
                            return true;
                          },
                          child: FilterScreen(
                            onClose: _closeFilterScreen,
                          ));
                    },
                  );
                } else {
                  _pageController.jumpToPage(index);
                }
              },
              kIconSize: 24.0,
            ),
          ),
        ],
      ),
    );
  }
}
