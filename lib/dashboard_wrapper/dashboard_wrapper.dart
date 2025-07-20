import 'package:flutter/material.dart';
import 'package:movemate/constants/app_colors.dart';
import 'package:movemate/constants/app_text_styles.dart';
import 'package:movemate/home/home_page.dart';
import 'package:movemate/calculate/calculate_page.dart';
import 'package:movemate/shipment/shipment_page.dart';

class DashboardWrapper extends StatefulWidget {
  const DashboardWrapper({super.key});

  @override
  State<DashboardWrapper> createState() => _DashboardWrapperState();
}

class _DashboardWrapperState extends State<DashboardWrapper> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          HomePage(),
          CalculatePage(onBack: () {
            setState(() {
              _currentIndex = 0;
              _pageController.jumpToPage(0);
            });
          }), // Pass callback to navigate to home
          ShipmentPage(onBack: () {
            setState(() {
              _currentIndex = 0;
              _pageController.jumpToPage(0);
            });
          }), // Replaced placeholder with ShipmentPage
          Center(child: Text('Profile Page')),
        ],
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: Stack(
        children: [
          BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                _pageController.jumpToPage(index);
              });
            },
            selectedItemColor: AppColors.primary,
            unselectedItemColor: Colors.grey[400],
            selectedLabelStyle: AppTextStyles.caption.copyWith(color: AppColors.primary),
            unselectedLabelStyle: AppTextStyles.caption,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calculate),
                label: 'Calculate',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'Shipment',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: _currentIndex * (MediaQuery.of(context).size.width / 4),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: MediaQuery.of(context).size.width / 4,
              height: 2,
              color: AppColors.primary, // Indicator bar color
            ),
          ),
        ],
      ),
    );
  }
} 