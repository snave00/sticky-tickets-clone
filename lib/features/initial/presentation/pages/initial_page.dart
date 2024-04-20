import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/button/custom_filled_button.dart';
import '../../../../core/presentation/widgets/icon/app_logo.dart';
import '../../../../core/presentation/widgets/spacing/spacing.dart';
import '../../../../utils/constants/string_const.dart';
import '../../../../utils/constants/widget_const.dart';
import '../../../../utils/router/router_func.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // logo
            _buildLogo(),

            // see current events
            _buildCurrentEventsButton(context: context, theme: theme),
            const Spacing.vertical(size: SpacingSize.s),

            // scan new operator
            _buildScanOperatorButton(theme: theme),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return const Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // logo
          AppLogo(
            appLogoType: AppLogoType.logoOnly,
            size: WidgetSize.s100,
          ),

          // named logo
          AppLogo(
            appLogoType: AppLogoType.nameLogo,
            size: WidgetSize.s72,
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentEventsButton({
    required BuildContext context,
    required ThemeData theme,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: WidgetPadding.paddingM,
      ),
      child: CustomFilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: theme.colorScheme.tertiaryContainer,
          foregroundColor: theme.colorScheme.onTertiaryContainer,
        ),
        onPressedCallback: () {
          RouterFunc.goToEventsPage(context: context);
        },
        child: const Text(StringConst.seeCurrentEvents),
      ),
    );
  }

  Widget _buildScanOperatorButton({required ThemeData theme}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: WidgetPadding.paddingM,
      ),
      child: CustomFilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: theme.colorScheme.onTertiaryContainer,
          foregroundColor: theme.colorScheme.tertiaryContainer,
        ),
        onPressedCallback: () {},
        child: const Text(StringConst.scanNewOperator),
      ),
    );
  }
}
