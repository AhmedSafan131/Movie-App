import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_colors.dart';
import '../../../utils/app_routes.dart';
import 'onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPageData> _pages = [
    OnboardingPageData(
      title: "Find Your Next Favorite Movie Here",
      description:
          "Get access to a huge library of movies to suit all tastes. You will surely like it.",
      image: "assets/images/onbording1.png",
      showBackButton: false,
      primaryButtonText: "Explore Now",
    ),
    OnboardingPageData(
      title: "Discover Movies",
      description:
          "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
      image: "assets/images/onbording2.png",
      showBackButton: true,
      primaryButtonText: "Next",
    ),
    OnboardingPageData(
      title: "Explore All Genres",
      description:
          "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
      image: "assets/images/onbording3.png",
      showBackButton: true,
      primaryButtonText: "Next",
    ),
    OnboardingPageData(
      title: "Create Watchlists",
      description:
          "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
      image: "assets/images/onbording4.png",
      showBackButton: true,
      primaryButtonText: "Next",
    ),
    OnboardingPageData(
      title: "Rate, Review, and Learn",
      description:
          "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
      image: "assets/images/onbording5.png",
      showBackButton: true,
      primaryButtonText: "Next",
    ),
    OnboardingPageData(
      title: "Start Watching Now",
      description:
          "Ready to dive into the world of movies? Start your journey now and discover amazing films.",
      image: "assets/images/onbording6.png",
      showBackButton: true,
      primaryButtonText: "Finish",
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to login screen
      Navigator.of(context).pushReplacementNamed(AppRoutes.login);
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemCount: _pages.length,
        itemBuilder: (context, index) {
          return OnboardingPage(
            data: _pages[index],
            onNext: _nextPage,
            onBack: _previousPage,
            isLastPage: index == _pages.length - 1,
          );
        },
      ),
    );
  }
}
