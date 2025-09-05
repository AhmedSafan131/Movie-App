import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/UI/Screen/home/tabs/profile_tab/history_tab.dart';
import 'package:movie_app/UI/Screen/home/tabs/profile_tab/watch_list_tab.dart';
import 'package:movie_app/UI/widgets/navigate_wdget.dart';
import 'package:movie_app/UI/widgets/tab_bar_wdget.dart';
import 'package:movie_app/UI/widgets/user_data_widget.dart';
import 'package:movie_app/blocs/profile_cubit/profile_state.dart';
import 'package:movie_app/blocs/profile_cubit/profile_view_model.dart';
import 'package:movie_app/utils/app_colors.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  int selectedTabIndex = 0;
  late ProfileViewModel viewModel;
  @override
  void initState() {
    super.initState();
    viewModel = ProfileViewModel();
    viewModel.getProfileAndFavorites();
  }

  @override
  void dispose() {
    viewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocBuilder<ProfileViewModel, ProfileState>(
        bloc: viewModel,
        builder: (context, state) {
          if (state is ProfileError) {
            return Center(child: Text(state.message));
          } else if (state is ProfileSuccess) {
            return DefaultTabController(
              length: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.025),
                child: Column(
                  children: [
                    Container(
                      color: AppColors.darkGray,
                      child: Column(
                        children: [
                          UserDataWidget(
                              userModel: state.user,
                              wishListMovies: state.favoritesMovies,
                              historyMovies: state.favoritesMovies),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          NavigateWidget(viewModel: viewModel),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          const TabBarWidget()
                        ],
                      ),
                    ),
                     Expanded(
                        child: TabBarView(
                      children: [WatchListTab(watchList: state.favoritesMovies,), const HistoryTab()],
                    ))
                  ],
                ),
              ),
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.yellowColor,
            ));
          }
        });
  }
}
