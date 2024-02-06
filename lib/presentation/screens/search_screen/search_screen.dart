// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:anime_red/config/config.dart';
import 'package:anime_red/presentation/bloc/anime_search/anime_search_bloc.dart';
import 'package:anime_red/presentation/screens/search_screen/widgets/idle_view.dart';
import 'package:anime_red/presentation/screens/search_screen/widgets/search_appbar.dart';
import 'package:anime_red/presentation/widgets/gap.dart';
import 'package:anime_red/utils/debouncer/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/search_result_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController textController;
  late final FocusNode focusNode;
  late final Debouncer debouncer;

  @override
  void initState() {
    textController = TextEditingController();
    focusNode = FocusNode();
    debouncer = Debouncer();
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    focusNode.dispose();

    final bloc = context.read<AnimeSearchBloc>();
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Padding(
          padding: AppPadding.normalScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchAppBarWidget(
                controller: textController,
                node: focusNode,
                onChanged: (text) {
                  debouncer.run(() {
                    if (text.trim().isNotEmpty) {
                      context.read<AnimeSearchBloc>().add(
                            AnimeSearchQuery(text.trim()),
                          );
                    }

                    if (text.trim().isEmpty) {
                      focusNode.unfocus();
                    }

                    textController.notifyListeners();
                  });
                },
              ),
              const Gap(H: 10),
              ValueListenableBuilder(
                  valueListenable: textController,
                  builder: (context, text, child) {
                    if (text.text.trim().isEmpty) {
                      return const SearchScreenIdleViewWidget();
                    } else {
                      return SearchScreenResultViewWidget(
                        queryController: textController,
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
