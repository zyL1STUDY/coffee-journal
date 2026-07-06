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
}
