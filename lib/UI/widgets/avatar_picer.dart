import 'package:flutter/material.dart';
import 'package:movie_app/UI/widgets/bottom_sheet_widget.dart';
import 'package:movie_app/utils/app_colors.dart';

class AvatarPicker extends StatefulWidget {
  final PageController pageController;
  final int selectedAvatar;
  final ValueChanged<int> onAvatarSelected;

  const AvatarPicker({
    super.key,
    required this.pageController,
    required this.selectedAvatar,
    required this.onAvatarSelected,
  });

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  late int _currentAvatar;

  @override
  void initState() {
    super.initState();
    _currentAvatar = widget.selectedAvatar;
  }

  void _onAvatarChanged(int index) {
    setState(() {
      _currentAvatar = index;
    });
    widget.onAvatarSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return SizedBox(
    height: height * 0.15,
      child: PageView.builder(
        controller: widget.pageController,
        itemCount: BottomSheetWidget.avatar.length,
        onPageChanged: _onAvatarChanged,
        itemBuilder: (context, index) {
          bool isSelected = _currentAvatar == index;

          return GestureDetector(
            onTap: () {
              _onAvatarChanged(index);
              widget.pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: Transform.scale(
              scale: isSelected ? 1 : 0.8,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                child: SizedBox(
                  child: CircleAvatar(
                      backgroundColor: AppColors.transparentColor,
                      backgroundImage: AssetImage(
                        BottomSheetWidget.avatar[index],
                      ),
                     
                      ),
                      
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
