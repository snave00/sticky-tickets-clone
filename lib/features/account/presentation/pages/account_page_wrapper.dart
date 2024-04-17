import '../../../../core/presentation/widgets/icon/app_logo.dart';
import 'package:flutter/material.dart';

class AccountPageWrapper extends StatelessWidget {
  const AccountPageWrapper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Accounts'),
            Text('Test'),
            AppLogo(appLogoType: AppLogoType.logoOnly),
          ],
        ),
      ),
    );
  }
}
