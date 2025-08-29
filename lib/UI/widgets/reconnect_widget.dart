import 'package:flutter/material.dart';
import 'package:movie_app/blocs/search_cubit/search_state.dart';
import 'package:movie_app/blocs/search_cubit/search_view_model.dart';
import 'package:movie_app/utils/app_colors.dart';

class ReconnectWidget extends StatelessWidget {
  const ReconnectWidget({
    super.key,
    required this.viewModel,
    required this.searchController,
    required this.state,
  });

  final SearchViewModel viewModel;
  final TextEditingController searchController;
  final SearchError  state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          state.message,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.darkGray,
          ),
          onPressed: () {
            viewModel.getMovie(searchController.text);
          },
          child: Text(
            'Try Again',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ],
    );
  }
}
