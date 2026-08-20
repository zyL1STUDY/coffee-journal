import 'dart:async';

import 'package:flutter/material.dart';

class TypingPromptText extends StatefulWidget {
  const TypingPromptText({
    required this.text,
    required this.style,
    this.textAlign = TextAlign.left,
    this.startDelay = const Duration(milliseconds: 420),
    this.duration = const Duration(milliseconds: 1100),
    super.key,
  });

  final String text;
  final TextStyle style;
  final TextAlign textAlign;
  final Duration startDelay;
  final Duration duration;

  @override
  State<TypingPromptText> createState() => _TypingPromptTextState();
}

class _TypingPromptTextState extends State<TypingPromptText>
    with SingleTickerProviderStateMixin {
  static final Set<String> _animatedTexts = <String>{};

  late AnimationController _typingController;
  late Animation<int> _visibleCharacters;
  Timer? _typingDelayTimer;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
    _startAfterDelay();
  }

  @override
  void didUpdateWidget(covariant TypingPromptText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text ||
        oldWidget.duration != widget.duration ||
        oldWidget.startDelay != widget.startDelay) {
      _typingDelayTimer?.cancel();
      _typingController.dispose();
      _setupAnimation();
      _startAfterDelay();
    }
  }

  @override
  void dispose() {
    _typingDelayTimer?.cancel();
    _typingController.dispose();
    super.dispose();
  }

  void _setupAnimation() {
    _typingController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _visibleCharacters = StepTween(begin: 0, end: widget.text.length).animate(
      CurvedAnimation(parent: _typingController, curve: Curves.easeOutCubic),
    );

    if (_animatedTexts.contains(widget.text)) {
      _typingController.value = 1;
    }
  }

  void _startAfterDelay() {
    if (_animatedTexts.contains(widget.text)) {
      return;
    }

    _animatedTexts.add(widget.text);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _typingDelayTimer = Timer(widget.startDelay, () {
        if (!mounted) {
          return;
        }
        _typingController.forward();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _visibleCharacters,
      builder: (context, child) {
        final visibleText = widget.text.substring(0, _visibleCharacters.value);

        return Text(
          visibleText,
          textAlign: widget.textAlign,
          style: widget.style,
        );
      },
    );
  }
}
