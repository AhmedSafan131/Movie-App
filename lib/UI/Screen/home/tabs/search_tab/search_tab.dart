import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/UI/Screen/home/tabs/search_tab/search_movie.dart';
import 'package:movie_app/UI/widgets/custom_text_field.dart';
import 'package:movie_app/UI/widgets/reconnect_widget.dart';
import 'package:movie_app/blocs/search_cubit/search_state.dart';
import 'package:movie_app/blocs/search_cubit/search_view_model.dart';
import 'package:movie_app/l10n/app_localizations.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/assets_manager.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  late TextEditingController searchController;
  SearchViewModel viewModel = SearchViewModel();
  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    viewModel.getMovie(searchController.text);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.03, vertical: height * 0.01),
      child: SafeArea(
        child: Column(
          children: [
            CustomTextField(
              prefixIcon: ImageIcon(
                const AssetImage(AssetsManager.searchIcon),
                color: AppColors.white,
                size: width * 0.1,
              ),
              hintText: AppLocalizations.of(context)!.search,
              onChanged: (value) {
                viewModel.getMovie(value);
              },
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Expanded(
                child: BlocBuilder<SearchViewModel, SearchState>(
              bloc: viewModel,
              builder: (context, state) {
                if (state is SearchError) {
                  return ReconnectWidget(
                    viewModel: viewModel,
                    searchController: searchController,
                    state: state,
                  );
                } else if (state is SearchSuccess) {
                  return state.movies.isEmpty
                      ? Center(
                          child: Image.asset(AssetsManager.emptyIcon),
                        )
                      : SearchMovie(
                          searchMoviesList: state.movies,
                          movieOnClick: () {
                            FocusScope.of(context).unfocus();
                          },
                        );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.white),
                  );
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
