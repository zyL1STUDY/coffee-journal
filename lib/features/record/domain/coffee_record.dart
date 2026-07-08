enum CoffeeSourceType { brand, cafe, homemade }

enum AiStatus { idle, loading, success, failed }

class CoffeeRecord {
  const CoffeeRecord({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
    required this.sourceType,
    required this.sourceName,
    this.deletedAt,
    this.drinkName,
    this.photoUrl,
    this.note,
    this.aiMessage,
    this.aiStatus = AiStatus.idle,
    this.aiCreatedAt,
  });

  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;
  final DateTime? deletedAt;
  final CoffeeSourceType sourceType;
  final String sourceName;
  final String? drinkName;
  final String? photoUrl;
  final String? note;
  final String? aiMessage;
  final AiStatus aiStatus;
  final DateTime? aiCreatedAt;

  CoffeeRecord copyWith({
    DateTime? updatedAt,
    bool? isDeleted,
    DateTime? deletedAt,
    CoffeeSourceType? sourceType,
    String? sourceName,
    String? drinkName,
    String? photoUrl,
    String? note,
    String? aiMessage,
    AiStatus? aiStatus,
    DateTime? aiCreatedAt,
  }) {
    return CoffeeRecord(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      deletedAt: deletedAt ?? this.deletedAt,
      sourceType: sourceType ?? this.sourceType,
      sourceName: sourceName ?? this.sourceName,
      drinkName: drinkName ?? this.drinkName,
      photoUrl: photoUrl ?? this.photoUrl,
      note: note ?? this.note,
      aiMessage: aiMessage ?? this.aiMessage,
      aiStatus: aiStatus ?? this.aiStatus,
      aiCreatedAt: aiCreatedAt ?? this.aiCreatedAt,
    );
  }
}

extension CoffeeSourceTypeLabel on CoffeeSourceType {
  String get title {
    switch (this) {
      case CoffeeSourceType.brand:
        return '连锁品牌';
      case CoffeeSourceType.cafe:
        return '独立咖啡店';
      case CoffeeSourceType.homemade:
        return '自己做';
    }
  }

  String get defaultSourceName {
    switch (this) {
      case CoffeeSourceType.brand:
        return '瑞幸';
      case CoffeeSourceType.cafe:
        return '街角咖啡店';
      case CoffeeSourceType.homemade:
        return '手冲';
    }
  }
}
