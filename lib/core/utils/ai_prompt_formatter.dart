class AiPromptFormatter {
  const AiPromptFormatter._();

  static String lineBreakAfterComma(String value) {
    final normalized = value.trim();
    if (normalized.contains('\n')) {
      return normalized;
    }

    const comma = '，';
    final commaIndex = normalized.indexOf(comma);
    if (commaIndex == -1 || commaIndex == normalized.length - 1) {
      return normalized;
    }

    return '${normalized.substring(0, commaIndex + 1)}\n${normalized.substring(commaIndex + 1).trimLeft()}';
  }
}
