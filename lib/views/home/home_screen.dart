import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:structure_example/app_localizations.dart';
import 'package:structure_example/resource/colors_data.dart';
import 'package:structure_example/resource/icons_data.dart';
import 'package:structure_example/service/message_service.dart';

import 'package:structure_example/widgets/floating_shopping_cart.dart';

class HomeInheritedWidget extends InheritedWidget {
  final PageController pageController;
  HomeInheritedWidget({Widget child, this.pageController}) : super(child: child);
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static HomeInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<HomeInheritedWidget>();
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = new PageController(initialPage: 0);
  int _currentIndex = 0;
  List _listBNBar = [
    [IconsData.ic_home, "home"],
    [IconsData.ic_product, "new"],
    [IconsData.ic_handbook, "handbook"],
    [IconsData.ic_person, "another"]
  ];
  @override
  void initState() {
    super.initState();
    new FcmService();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: HomeInheritedWidget(
          pageController: _pageController,
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: [
              Container(),
              Container(),
              Container(),
              Container(),
              // HomePage(),
              // ProductPage(),
              // HandbookPage(),
              // AnotherPage(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
              _currentIndex = index;
            });
          },
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: List.generate(
            _listBNBar.length,
            (index) {
              return BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  _listBNBar[index][0],
                  color: _currentIndex == index ? ColorsData.selected : ColorsData.unselected.withOpacity(0.3),
                ),
                label: translate(context, _listBNBar[index][1]),
              );
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingShoppingCart(),
      ),
    );
  }
}
