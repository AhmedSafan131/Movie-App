import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'tabs/home_tab.dart';
import 'tabs/search_tab.dart';
import 'tabs/details_tab.dart';
import 'tabs/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      body: _buildBody(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 58,
          decoration: BoxDecoration(
            color: AppColors.darkGray,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, 'assets/images/home_icon.png', 'Home'),
              _buildNavItem(1, 'assets/images/search_icon.png', 'Search'),
              _buildNavItem(2, 'assets/images/explore.png', 'Details'),
              _buildNavItem(3, 'assets/images/Profiel.png', 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return const HomeTab();
      case 1:
        return const SearchTab();
      case 2:
        return const DetailsTab();
      case 3:
        return const ProfileTab();
      default:
        return const HomeTab();
    }
  }

  Widget _buildNavItem(int index, String iconPath, String label) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Image.asset(
          iconPath,
          width: 24,
          height: 24,
          color: isSelected
              ? AppColors.accentYellow
              : AppColors.white.withValues(alpha: 0.7),
          errorBuilder: (context, error, stackTrace) {
            // Fallback to default icons if custom icons fail to load
            IconData fallbackIcon;
            switch (index) {
              case 0:
                fallbackIcon = Icons.home;
                break;
              case 1:
                fallbackIcon = Icons.search;
                break;
              case 2:
                fallbackIcon = Icons.explore;
                break;
              case 3:
                fallbackIcon = Icons.person;
                break;
              default:
                fallbackIcon = Icons.home;
            }
            return Icon(
              fallbackIcon,
              color: isSelected
                  ? AppColors.accentYellow
                  : AppColors.white.withValues(alpha: 0.7),
              size: 24,
            );
          },
        ),
      ),
    );
  }
}
