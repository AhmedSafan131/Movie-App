import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';

class AvatarSelector extends StatelessWidget {
  final int selectedAvatar;
  final Function(int) onAvatarSelected;

  const AvatarSelector({
    super.key,
    required this.selectedAvatar,
    required this.onAvatarSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Horizontal Scrollable Avatar List with Selected Larger
        SizedBox(
          height: 100,
          width: double.infinity,
          child: PageView.builder(
            itemCount: 9,
            controller: PageController(
              initialPage: selectedAvatar,
              viewportFraction: 0.3,
            ),
            onPageChanged: onAvatarSelected,
            itemBuilder: (context, index) {
              bool isSelected = selectedAvatar == index;
              return GestureDetector(
                onTap: () => onAvatarSelected(index),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: isSelected ? 80 : 60,
                    height: isSelected ? 80 : 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.accentYellow
                            : Colors.transparent,
                        width: isSelected ? 3 : 0,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/avatar${index + 1}.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.darkGray,
                            child: Icon(
                              Icons.person,
                              color: AppColors.white,
                              size: isSelected ? 40 : 30,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        // Avatar indicator dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(9, (index) {
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selectedAvatar == index
                    ? AppColors.accentYellow
                    : AppColors.darkGray,
              ),
            );
          }),
        ),
      ],
    );
  }
}
