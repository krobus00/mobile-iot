import 'package:flutter/material.dart';
import 'package:mobile_iot/pages/home_page.dart';
import 'package:mobile_iot/pages/node_page.dart';
import 'package:mobile_iot/pages/sample_page.dart';
import 'package:mobile_iot/providers/page_provider.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    PageProvider _pageProvider = Provider.of<PageProvider>(context);

    Widget _customBottomNav() {
      return BottomNavigationBar(
        currentIndex: _pageProvider.currentIndex,
        onTap: (value) {
          setState(() {
            _pageProvider.currentIndex = value;
          });
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: "Explore",
          ),
        ],
      );
    }

    Widget body() {
      switch (_pageProvider.currentIndex) {
        case 0:
          return const SamplePage();
        case 1:
          return const NodePage();
        default:
          return const HomePage();
      }
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF5B82E4),
            Color(0xFF8610FB),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: _customBottomNav(),
        body: body(),
      ),
    );
  }
}
