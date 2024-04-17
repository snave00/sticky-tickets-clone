import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/helpers/shared/helper_func.dart';
import '../../cubit/home_cubit.dart';
import 'home_page.dart';

class HomePageWrapper extends StatelessWidget {
  const HomePageWrapper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<HomeCubit, HomeState>(
      listener: (ctx, state) {
        _handleHomeProductsStatus(context: ctx, theme: theme, state: state);
        _handleHomePromosStatus(context: ctx, theme: theme, state: state);
      },
      child: const HomePage(),
    );
  }

  void _handleHomeProductsStatus({
    required BuildContext context,
    required ThemeData theme,
    required HomeState state,
  }) async {
    switch (state.homeProductsStatus) {
      case HomeProductsStatus.initial:
        return;
      case HomeProductsStatus.getProductsLoading:
        return;
      case HomeProductsStatus.getProductsSuccess:
        return;
      case HomeProductsStatus.failure:
        showSnackBar(
          context: context,
          theme: theme,
          isSuccess: false,
          message: state.errorMessage ?? '',
        );
        return;
    }
  }

  void _handleHomePromosStatus({
    required BuildContext context,
    required ThemeData theme,
    required HomeState state,
  }) async {
    switch (state.homePromosStatus) {
      case HomePromosStatus.initial:
        return;
      case HomePromosStatus.getPromosLoading:
        return;
      case HomePromosStatus.getPromosSuccess:
        return;
      case HomePromosStatus.failure:
        showSnackBar(
          context: context,
          theme: theme,
          isSuccess: false,
          message: state.errorMessage ?? '',
        );
        return;
    }
  }
}
