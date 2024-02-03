import 'package:anime_red/config/config.dart';
import 'package:anime_red/presentation/router/router.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchAppBarWidget extends StatelessWidget {
  const SearchAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "home_search_bar",
      child: Material(
        type: MaterialType.transparency,
        child: SizedBox(
          height: 40,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  AppNavigator.pop(context);
                },
                child: const SearchScreenBackButtonWidget(),
              ),
              const Gap(W: 10),
              Expanded(
                child: AppCustomTextFieldWidget(
                  controller: TextEditingController(),
                  focusNode: FocusNode(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchScreenBackButtonWidget extends StatelessWidget {
  const SearchScreenBackButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: const Icon(
        Icons.keyboard_arrow_left_outlined,
        color: AppColors.white,
        size: 25,
      ),
    );
  }
}

class AppCustomTextFieldWidget extends StatelessWidget {
  const AppCustomTextFieldWidget({
    super.key,
    this.onChanged,
    this.onTapOutside,
    required this.focusNode,
    required this.controller,
  });

  final void Function(String)? onChanged;
  final void Function()? onTapOutside;

  final FocusNode focusNode;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      focusNode: focusNode,
      onTapOutside: (event) {
        onTapOutside?.call();
        focusNode.unfocus();
      },
      style: const TextStyle(
        color: AppColors.white,
        fontWeight: AppFontWeight.bold,
        fontSize: AppFontSize.medium,
      ),
      textAlignVertical: TextAlignVertical.center,
      maxLines: 1,
      cursorColor: AppColors.silver,
      decoration: InputDecoration(
        hintText: "Search anime...",
        hintStyle: const TextStyle(
          color: AppColors.grey,
          fontWeight: AppFontWeight.bold,
          fontSize: AppFontSize.medium,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: AppColors.grey,
            width: 1,
          ),
        ),
        prefixIcon: const Icon(
          CupertinoIcons.search,
          color: AppColors.grey,
          size: 20,
        ),
        focusColor: Colors.transparent,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: AppColors.grey,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: AppColors.silver,
            width: 1,
          ),
        ),
      ),
    );
  }
}
