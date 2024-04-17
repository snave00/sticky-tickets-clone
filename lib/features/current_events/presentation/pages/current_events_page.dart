import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/appbar/custom_app_bar.dart';
import '../../../../core/presentation/widgets/pull_refresh/custom_pull_refresh.dart';
import '../../../../core/presentation/widgets/spacing/spacing.dart';
import '../../../../utils/constants/string_const.dart';
import '../cubit/cubit/current_events_cubit.dart';

class CurrentEventsPage extends StatelessWidget {
  const CurrentEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        hasBackButton: true,
        title: Text(StringConst.currentEvents),
      ),
      body: SafeArea(
        child: CustomPullRefresh(
          onRefresh: () async {
            return context.read<CurrentEventsCubit>().init();
          },
          child: const CustomScrollView(
            slivers: [
              // search bar
              // HomeSearch(),
              Spacing.vertical(size: SpacingSize.l, isSliver: true),

              // current events list
              // HomeProductCategories(),
              Spacing.vertical(size: SpacingSize.l, isSliver: true),
            ],
          ),
        ),
      ),
    );
  }
}
