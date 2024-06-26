import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/cubit/user_cubit.dart';
import '../../../../utils/helpers/shared/helper_state.func.dart';
import 'initial_page.dart';

class InitialPageWrapper extends StatelessWidget {
  const InitialPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<UserCubit, UserState>(
          listener: (ctx, state) {
            handleUserState(context: context, theme: theme, state: state);
          },
        ),
      ],
      child: const InitialPage(),
    );
  }
}
