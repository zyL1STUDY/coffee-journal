import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_route.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_typography.dart';
import '../application/coffee_photo_picker.dart';
import '../application/coffee_record_repository.dart';
import '../domain/coffee_record.dart';
import 'record_flow_widgets.dart';

class RecordDetailPage extends ConsumerStatefulWidget {
  const RecordDetailPage({required this.sourceType, this.editId, super.key});

  final CoffeeSourceType sourceType;
  final String? editId;

  @override
  ConsumerState<RecordDetailPage> createState() => _RecordDetailPageState();
}

class _RecordDetailPageState extends ConsumerState<RecordDetailPage> {
  final _dismissController = RecordFlowDismissController();
  late String _sourceName;
  late bool _hasPhoto;
  String? _photoUrl;
  late final TextEditingController _drinkController;
  late final TextEditingController _noteController;
  late final TextEditingController _cafeController;

  @override
  void initState() {
    super.initState();
    final editingRecord = widget.editId == null
        ? null
        : ref
              .read(coffeeRecordRepositoryProvider.notifier)
              .findById(widget.editId!);
    _sourceName = editingRecord?.sourceName ?? '';
    _photoUrl = editingRecord?.photoUrl;
    _hasPhoto = _photoUrl != null;
    _drinkController = TextEditingController();
    _drinkController.text = editingRecord?.drinkName ?? '';
    _noteController = TextEditingController();
    _noteController.text = editingRecord?.note ?? '';
    _cafeController = TextEditingController();
    if (widget.sourceType == CoffeeSourceType.cafe) {
      _cafeController.text = _sourceName;
    }
  }

  @override
  void dispose() {
    _drinkController.dispose();
    _noteController.dispose();
    _cafeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RecordOverlayScaffold(
      sheetTop: AppDimensions.recordDetailSheetTop,
      sheetHeight: AppDimensions.recordDetailSheetHeight,
      borderRadius: AppRadius.recordDetailSheetBorder,
      dismissController: _dismissController,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const RecordHandle(),
            const SizedBox(height: AppDimensions.recordHandleToHeaderGap),
            RecordHeader(
              title: widget.sourceType.title,
              onBack: () => context.go(AppRoute.record.path),
              onCancel: _cancelRecord,
            ),
            const SizedBox(height: AppDimensions.recordHeaderToContentGap),
            if (_hasPhoto) ...[
              RecordStickerPreview(photoUrl: _photoUrl, onChangeTap: _addPhoto),
              const SizedBox(height: AppDimensions.recordPhotoPreviewBottomGap),
            ],
            _SourceSection(
              sourceType: widget.sourceType,
              sourceName: _sourceName,
              cafeController: _cafeController,
              onSourceChanged: (value) {
                setState(() {
                  _sourceName = value;
                  if (widget.sourceType == CoffeeSourceType.cafe) {
                    _cafeController.text = value;
                  }
                });
              },
            ),
            const SizedBox(height: AppDimensions.recordLargeBlockGap),
            const RecordSectionTitle('这一杯叫什么？（可选）'),
            const SizedBox(height: AppDimensions.recordSectionToFieldGap),
            RecordTextField(controller: _drinkController, hintText: _drinkHint),
            if (!_hasPhoto) ...[
              const SizedBox(height: AppDimensions.recordBlockGap),
              const RecordSectionTitle('照片（可选）'),
              const SizedBox(height: AppDimensions.recordSectionToFieldGap),
              RecordPhotoEntry(onTap: _addPhoto),
            ],
            const SizedBox(height: AppDimensions.recordBlockGap),
            const RecordSectionTitle('备注（可选）'),
            const SizedBox(height: AppDimensions.recordSectionToFieldGap),
            RecordTextField(
              controller: _noteController,
              hintText: '展开',
              trailing: const Text('>', style: AppTypography.recordGentleNote),
            ),
            const SizedBox(height: AppDimensions.recordButtonTopGap),
            RecordSaveButton(onTap: _saveRecord, isEnabled: _canSave),
          ],
        ),
      ),
    );
  }

  bool get _canSave => _sourceName.trim().isNotEmpty;

  bool get _hasDraftContent {
    return _sourceName.trim().isNotEmpty ||
        _drinkController.text.trim().isNotEmpty ||
        _noteController.text.trim().isNotEmpty ||
        _hasPhoto;
  }

  String get _drinkHint {
    switch (widget.sourceType) {
      case CoffeeSourceType.brand:
        return '例如：红酒美式';
      case CoffeeSourceType.cafe:
        return '例如：热拿铁';
      case CoffeeSourceType.homemade:
        return '例如：埃塞俄比亚手冲';
    }
  }

  void _saveRecord() {
    if (!_canSave) {
      return;
    }

    final sourceName = _sourceName.trim().isEmpty
        ? widget.sourceType.defaultSourceName
        : _sourceName.trim();

    final draft = CoffeeRecordDraft(
      sourceType: widget.sourceType,
      sourceName: sourceName,
      drinkName: _drinkController.text,
      note: _noteController.text,
      photoUrl: _photoUrl,
    );
    final repository = ref.read(coffeeRecordRepositoryProvider.notifier);

    if (widget.editId == null) {
      repository.save(draft);
    } else {
      repository.update(widget.editId!, draft);
    }

    context.go(AppRoute.home.path);
  }

  Future<void> _addPhoto() async {
    final photoUrl = await ref
        .read(coffeePhotoPickerProvider)
        .pickFromGallery();
    if (photoUrl == null || !mounted) {
      return;
    }

    setState(() {
      _photoUrl = photoUrl;
      _hasPhoto = true;
    });
  }

  Future<void> _cancelRecord() async {
    if (!_hasDraftContent) {
      await _dismissController.dismiss();
      return;
    }

    final shouldDiscard = await showGeneralDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierLabel: '取消记录',
      barrierColor: Colors.black.withValues(alpha: 0.18),
      transitionDuration: const Duration(milliseconds: 180),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: widget.editId == null
              ? const RecordDiscardDialog()
              : const RecordDiscardDialog(
                  continueLabel: '继续修改',
                  discardLabel: '放弃修改',
                ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.98, end: 1).animate(curved),
            child: child,
          ),
        );
      },
    );

    if (shouldDiscard == true && mounted) {
      await _dismissController.dismiss();
    }
  }
}

class _SourceSection extends StatelessWidget {
  const _SourceSection({
    required this.sourceType,
    required this.sourceName,
    required this.cafeController,
    required this.onSourceChanged,
  });

  final CoffeeSourceType sourceType;
  final String sourceName;
  final TextEditingController cafeController;
  final ValueChanged<String> onSourceChanged;

  @override
  Widget build(BuildContext context) {
    switch (sourceType) {
      case CoffeeSourceType.brand:
        return _ChipSourceSection(
          title: '选择品牌',
          selectedValue: sourceName,
          options: const [
            _SourceOption('瑞幸'),
            _SourceOption('星巴克'),
            _SourceOption('Manner', isWide: true),
            _SourceOption('蓝瓶', isWide: true),
            _SourceOption('其他'),
          ],
          onChanged: onSourceChanged,
        );
      case CoffeeSourceType.homemade:
        return _ChipSourceSection(
          title: '今天怎么做的？',
          selectedValue: sourceName,
          options: const [
            _SourceOption('手冲'),
            _SourceOption('咖啡机'),
            _SourceOption('胶囊'),
            _SourceOption('摩卡壶'),
            _SourceOption('冷萃'),
            _SourceOption('其他'),
          ],
          onChanged: onSourceChanged,
        );
      case CoffeeSourceType.cafe:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const RecordSectionTitle('选择或创建咖啡店'),
            const SizedBox(height: AppDimensions.recordSectionToFieldGap),
            RecordTextField(
              controller: cafeController,
              hintText: '选择咖啡店',
              readOnly: true,
              onTap: () => onSourceChanged('街角咖啡店'),
              trailing: const Text('>', style: AppTypography.recordGentleNote),
            ),
            const SizedBox(height: AppDimensions.recordSectionToFieldGap),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onSourceChanged('新咖啡店'),
              child: const SizedBox(
                width: AppDimensions.recordContentWidth,
                height: AppDimensions.recordCreateCafeHeight,
                child: Center(
                  child: Text(
                    '+ 创建新咖啡店',
                    style: AppTypography.recordGentleNote,
                  ),
                ),
              ),
            ),
          ],
        );
    }
  }
}

class _ChipSourceSection extends StatelessWidget {
  const _ChipSourceSection({
    required this.title,
    required this.selectedValue,
    required this.options,
    required this.onChanged,
  });

  final String title;
  final String selectedValue;
  final List<_SourceOption> options;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RecordSectionTitle(title),
        const SizedBox(height: AppDimensions.recordSectionToFieldGap),
        Wrap(
          spacing: AppDimensions.recordChipGap,
          runSpacing: AppDimensions.recordChipGap,
          children: [
            for (final option in options)
              RecordChip(
                label: option.label,
                isSelected: selectedValue == option.label,
                width: option.isWide
                    ? AppDimensions.recordChipWideWidth
                    : AppDimensions.recordChipWidth,
                onTap: () => onChanged(option.label),
              ),
          ],
        ),
      ],
    );
  }
}

class _SourceOption {
  const _SourceOption(this.label, {this.isWide = false});

  final String label;
  final bool isWide;
}
