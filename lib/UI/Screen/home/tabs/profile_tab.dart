import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/UI/widgets/custom_button.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_styles.dart';
import 'package:movie_app/utils/app_routes.dart';
import 'package:movie_app/UI/Screen/profile/update_profile.dart';
import 'package:movie_app/blocs/user/user_bloc.dart';
import 'package:movie_app/blocs/user/user_event.dart';
import 'package:movie_app/blocs/user/user_state.dart';
import 'package:movie_app/models/user_model.dart';
import 'package:movie_app/repositories/watchlist_repository.dart';
import 'package:movie_app/models/movies_response.dart';
import 'package:movie_app/UI/Screen/details_screen/details_screen.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  int selectedTabIndex = 0;
  final WatchlistRepository _watchlistRepository = WatchlistRepository();
  List<Movies> watchlistMovies = [];
  bool isLoadingWatchlist = false;
  int watchlistCount = 0;

  @override
  void initState() {
    super.initState();
    _loadWatchlistData();
  }

  Future<void> _loadWatchlistData() async {
    setState(() {
      isLoadingWatchlist = true;
    });

    try {
      final movies = await _watchlistRepository.getWatchlistMovies();
      final count = await _watchlistRepository.getWatchlistCount();

      setState(() {
        watchlistMovies = movies;
        watchlistCount = count;
        isLoadingWatchlist = false;
      });
    } catch (e) {
      setState(() {
        isLoadingWatchlist = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryBlack,
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.accentYellow),
            );
          }

          if (state is UserError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${state.message}',
                    style: AppStyles.medium16White,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<UserBloc>().add(const LoadUser());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is UserLoaded) {
            return Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  _buildUserInfoSection(state.user),
                  const SizedBox(height: 24),
                  _buildActionButtons(context, state.user),
                  const SizedBox(height: 30),
                  _buildSecondaryTabs(),
                  const SizedBox(height: 20),
                  Expanded(child: _buildContentArea()),
                ],
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(color: AppColors.accentYellow),
          );
        },
      ),
    );
  }

  Widget _buildUserInfoSection(UserModel user) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: ClipOval(
                child: Image.asset(
                  user.avatar,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: AppColors.accentYellow,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: AppColors.primaryBlack,
                        size: 40,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(user.name, style: AppStyles.bold16White),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text('$watchlistCount', style: AppStyles.bold24White),
                      const SizedBox(height: 20),
                      Text(
                        'Wish List',
                        style: AppStyles.bold16White.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text('10', style: AppStyles.bold24White),
                      const SizedBox(height: 20),
                      Text(
                        'History',
                        style: AppStyles.bold16White.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, UserModel user) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: CustomButton(
            text: 'Edit Profile',
            onPressed: () => _onEditProfilePressed(context, user),
            backgroundColor: AppColors.accentYellow,
            textColor: AppColors.primaryBlack,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: CustomButton(
            text: 'Exit',
            onPressed: () => _onExitPressed(context),
            backgroundColor: AppColors.errorRed,
            textColor: AppColors.white,
            icon: const Icon(
              Icons.exit_to_app,
              color: AppColors.white,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  void _onEditProfilePressed(BuildContext context, UserModel user) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UpdateProfile(
          currentName: user.name,
          currentAvatar: user.avatar,
          currentPhone: user.phone,
          onProfileUpdated: (newName, newAvatar, newPhone) {
            context.read<UserBloc>().add(
              UpdateUser(
                user.copyWith(
                  name: newName,
                  avatar: newAvatar,
                  phone: newPhone,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onExitPressed(BuildContext context) {
    _showLogoutDialog(context);
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.darkGray,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text('Exit', style: AppStyles.bold20White),
          content: Text(
            'Are you sure you want to exit?',
            style: AppStyles.medium16White,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: AppStyles.medium16White),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(
                  context,
                ).pushReplacementNamed(AppRoutes.onboarding);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.errorRed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Exit', style: AppStyles.medium16White),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSecondaryTabs() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => selectedTabIndex = 0),
            child: Column(
              children: [
                Icon(
                  Icons.list,
                  color: selectedTabIndex == 0
                      ? AppColors.accentYellow
                      : AppColors.white,
                  size: 24,
                ),
                const SizedBox(height: 8),
                Text(
                  'Watch List',
                  style: AppStyles.medium16White.copyWith(
                    color: selectedTabIndex == 0
                        ? AppColors.accentYellow
                        : AppColors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 3,
                  decoration: BoxDecoration(
                    color: selectedTabIndex == 0
                        ? AppColors.accentYellow
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => selectedTabIndex = 1),
            child: Column(
              children: [
                Icon(
                  Icons.folder,
                  color: selectedTabIndex == 1
                      ? AppColors.accentYellow
                      : AppColors.white,
                  size: 24,
                ),
                const SizedBox(height: 8),
                Text(
                  'History',
                  style: AppStyles.medium16White.copyWith(
                    color: selectedTabIndex == 1
                        ? AppColors.accentYellow
                        : AppColors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 3,
                  decoration: BoxDecoration(
                    color: selectedTabIndex == 1
                        ? AppColors.accentYellow
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContentArea() {
    if (selectedTabIndex == 0) {
      return _buildWatchlistContent();
    } else {
      return _buildHistoryContent();
    }
  }

  Widget _buildWatchlistContent() {
    if (isLoadingWatchlist) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.accentYellow),
      );
    }

    if (watchlistMovies.isEmpty) {
      return _buildEmptyState('No movies in your watch list');
    }

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.7,
      ),
      itemCount: watchlistMovies.length,
      itemBuilder: (context, index) {
        final movie = watchlistMovies[index];
        return _buildMovieCard(movie);
      },
    );
  }

  Widget _buildMovieCard(Movies movie) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MovieDetailsPage(movie: movie),
          ),
        ).then((_) => _loadWatchlistData());
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                movie.mediumCoverImage ?? '',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.darkGray,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.movie,
                      color: AppColors.white,
                      size: 48,
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.transparent,
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      movie.title ?? 'Unknown Title',
                      style: AppStyles.medium14White,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: AppColors.accentYellow,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${movie.rating ?? 'N/A'}',
                          style: AppStyles.medium14White.copyWith(fontSize: 12),
                        ),
                        const Spacer(),
                        Text(
                          '${movie.year ?? ''}',
                          style: AppStyles.medium14White.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () => _removeFromWatchlist(movie),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: AppColors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryContent() {
    return _buildEmptyState('No movies in your history');
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Image.asset(
              'assets/images/Empty.png',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return SizedBox(
                  width: 120,
                  height: 120,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: Container(
                          width: 60,
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [AppColors.accentYellow, AppColors.white],
                              stops: [0.0, 0.5],
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 50,
                          height: 70,
                          decoration: BoxDecoration(
                            color: AppColors.accentYellow,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Text(
            message,
            style: AppStyles.medium16White.copyWith(
              color: AppColors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<void> _removeFromWatchlist(Movies movie) async {
    try {
      await _watchlistRepository.removeFromWatchlist(movie.id!);
      await _loadWatchlistData();
    } catch (e) {
      // Handle error silently or log it if needed
    }
  }
}