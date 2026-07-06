import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../core/utils/context_extensions.dart';

class AppPage extends StatelessWidget {
  const AppPage({required this.title, this.child, super.key});

  final String title;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child:
            child ??
            Center(child: Text(title, style: context.textTheme.headlineMedium)),
      ),
    );
  }
}
