import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_route.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_typography.dart';
import 'record_flow_widgets.dart';

class RecordSourcePage extends StatefulWidget {
  const RecordSourcePage({super.key});

  @override
  State<RecordSourcePage> createState() => _RecordSourcePageState();
}

class _RecordSourcePageState extends State<RecordSourcePage> {
  final _dismissController = RecordFlowDismissController();

  @override
  Widget build(BuildContext context) {
    return RecordOverlayScaffold(
      sheetTop: AppDimensions.recordSourceChoiceSheetTop,
      sheetHeight: AppDimensions.recordSourceChoiceSheetHeight,
      borderRadius: AppRadius.recordStartSheetBorder,
      dismissController: _dismissController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RecordHandle(),
          const SizedBox(height: AppDimensions.recordHandleToHeaderGap),
          RecordHeader(
            title: '选择来源',
            onBack: _dismissController.dismiss,
            onCancel: _dismissController.dismiss,
          ),
          const SizedBox(height: AppDimensions.recordHeaderToContentGap),
          const SizedBox(
            width: 320,
            child: Text(
              '这杯咖啡来自哪里？选一个最贴近的场景。',
              style: AppTypography.recordSubcopy,
            ),
          ),
          const SizedBox(height: AppDimensions.recordSourceSubcopyToOptionsGap),
          RecordOptionRow(
            icon: '☕',
            label: '连锁品牌',
            onTap: () => context.go(AppRoute.brandRecord.path),
          ),
          const SizedBox(height: AppDimensions.recordOptionGap),
          RecordOptionRow(
            icon: '⌂',
            label: '独立咖啡店',
            onTap: () => context.go(AppRoute.cafeRecord.path),
          ),
          const SizedBox(height: AppDimensions.recordOptionGap),
          RecordOptionRow(
            icon: '✍',
            label: '自己做',
            onTap: () => context.go(AppRoute.homemadeRecord.path),
          ),
        ],
      ),
    );
  }
}
