import 'package:anime_red/presentation/widgets/common_back_button.dart';
import 'package:anime_red/presentation/widgets/custom_textfield.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
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
              const CommonBackButtonWidget(),
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
