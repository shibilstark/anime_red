import 'package:anime_red/config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppCustomTextFieldWidget extends StatelessWidget {
  const AppCustomTextFieldWidget({
    super.key,
    this.onChanged,
    this.onTapOutside,
    required this.focusNode,
    required this.controller,
    this.hintText,
  });

  final void Function(String)? onChanged;
  final void Function()? onTapOutside;
  final String? hintText;
  final FocusNode focusNode;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
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
        hintText: hintText ?? "Search anime...",
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
