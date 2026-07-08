import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/context_extensions.dart';
import '../../../shared/widgets/primary_action_button.dart';

class _CoffeePreview {
  const _CoffeePreview({
    required this.name,
    required this.place,
    required this.timeLabel,
  });

  final String name;
  final String place;
  final String timeLabel;
}

const _recentCoffees = <_CoffeePreview>[];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _HomeHeader(),
            SizedBox(height: AppSpacing.lg),
            _TodayCard(),
            SizedBox(height: AppSpacing.lg),
            _RecordCoffeeButton(),
            SizedBox(height: AppSpacing.xl),
            _RecentCoffeeSection(coffees: _recentCoffees),
          ],
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('早上好', style: context.textTheme.displaySmall),
        const SizedBox(height: AppSpacing.xs),
        Text('7月8日 星期三', style: context.textTheme.bodyMedium),
      ],
    );
  }
}

class _TodayCard extends StatelessWidget {
  const _TodayCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: AppDimensions.homeTodayCardMinHeight,
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceTint,
        borderRadius: AppRadius.cardBorder,
        border: Border.all(color: AppColors.outline),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  color: AppColors.primarySoft,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.local_cafe_rounded,
                  color: AppColors.accent,
                  size: 22,
                ),
              ),
              const Spacer(),
              Text('Today', style: context.textTheme.labelMedium),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Text('今天还没有记录咖啡', style: context.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.sm),
          Text('等你记录这一杯后，我会帮你留下今天的小小记忆。', style: context.textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _RecordCoffeeButton extends StatelessWidget {
  const _RecordCoffeeButton();

  @override
  Widget build(BuildContext context) {
    return PrimaryActionButton(label: '+ 记录一杯', onPressed: () {});
  }
}

class _RecentCoffeeSection extends StatelessWidget {
  const _RecentCoffeeSection({required this.coffees});

  final List<_CoffeePreview> coffees;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('最近的咖啡', style: context.textTheme.titleLarge),
        const SizedBox(height: AppSpacing.md),
        if (coffees.isEmpty) const _HomeEmptyState(),
        if (coffees.isNotEmpty)
          for (final coffee in coffees) _RecentCoffeeTile(coffee: coffee),
      ],
    );
  }
}

class _HomeEmptyState extends StatelessWidget {
  const _HomeEmptyState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xl,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.cardBorder,
        border: Border.all(color: AppColors.outline),
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: AppColors.primarySoft,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.coffee_outlined,
              color: AppColors.accent,
              size: 28,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text('还没有最近记录', style: context.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '从第一杯开始，Coffee Journal 会慢慢变成你的咖啡记忆。',
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _RecentCoffeeTile extends StatelessWidget {
  const _RecentCoffeeTile({required this.coffee});

  final _CoffeePreview coffee;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const CircleAvatar(
        backgroundColor: AppColors.primarySoft,
        child: Icon(Icons.local_cafe_rounded, color: AppColors.accent),
      ),
      title: Text(coffee.name),
      subtitle: Text('${coffee.place} · ${coffee.timeLabel}'),
    );
  }
}
