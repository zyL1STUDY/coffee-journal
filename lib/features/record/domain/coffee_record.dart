enum CoffeeSourceType { brand, cafe, homemade }

enum AiStatus { idle, loading, success, failed }

enum CutoutStatus { idle, processing, success, failed }

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
    this.cutoutPhotoUrl,
    this.cutoutStatus = CutoutStatus.idle,
    this.cutoutUpdatedAt,
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
  final String? cutoutPhotoUrl;
  final CutoutStatus cutoutStatus;
  final DateTime? cutoutUpdatedAt;
  final String? note;
  final String? aiMessage;
  final AiStatus aiStatus;
  final DateTime? aiCreatedAt;

  factory CoffeeRecord.fromJson(Map<String, Object?> json) {
    return CoffeeRecord(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      isDeleted: json['is_deleted'] as bool? ?? false,
      deletedAt: _parseOptionalDate(json['deleted_at']),
      sourceType: _sourceTypeFromJson(json['source_type'] as String?),
      sourceName: json['source_name'] as String? ?? '',
      drinkName: json['drink_name'] as String?,
      photoUrl: json['photo_url'] as String?,
      cutoutPhotoUrl: json['cutout_photo_url'] as String?,
      cutoutStatus: _cutoutStatusFromJson(json['cutout_status'] as String?),
      cutoutUpdatedAt: _parseOptionalDate(json['cutout_updated_at']),
      note: json['note'] as String?,
      aiMessage: json['ai_message'] as String?,
      aiStatus: _aiStatusFromJson(json['ai_status'] as String?),
      aiCreatedAt: _parseOptionalDate(json['ai_created_at']),
    );
  }

  CoffeeRecord copyWith({
    DateTime? updatedAt,
    bool? isDeleted,
    DateTime? deletedAt,
    CoffeeSourceType? sourceType,
    String? sourceName,
    String? drinkName,
    String? photoUrl,
    String? cutoutPhotoUrl,
    CutoutStatus? cutoutStatus,
    DateTime? cutoutUpdatedAt,
    bool clearCutoutPhotoUrl = false,
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
      cutoutPhotoUrl: clearCutoutPhotoUrl
          ? null
          : cutoutPhotoUrl ?? this.cutoutPhotoUrl,
      cutoutStatus: cutoutStatus ?? this.cutoutStatus,
      cutoutUpdatedAt: cutoutUpdatedAt ?? this.cutoutUpdatedAt,
      note: note ?? this.note,
      aiMessage: aiMessage ?? this.aiMessage,
      aiStatus: aiStatus ?? this.aiStatus,
      aiCreatedAt: aiCreatedAt ?? this.aiCreatedAt,
    );
  }

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_deleted': isDeleted,
      'deleted_at': deletedAt?.toIso8601String(),
      'source_type': sourceType.name,
      'source_name': sourceName,
      'drink_name': drinkName,
      'photo_url': photoUrl,
      'cutout_photo_url': cutoutPhotoUrl,
      'cutout_status': cutoutStatus.name,
      'cutout_updated_at': cutoutUpdatedAt?.toIso8601String(),
      'note': note,
      'ai_message': aiMessage,
      'ai_status': aiStatus.name,
      'ai_created_at': aiCreatedAt?.toIso8601String(),
    };
  }

  static DateTime? _parseOptionalDate(Object? value) {
    if (value is! String || value.isEmpty) {
      return null;
    }
    return DateTime.tryParse(value);
  }

  static CoffeeSourceType _sourceTypeFromJson(String? value) {
    return CoffeeSourceType.values.firstWhere(
      (type) => type.name == value,
      orElse: () => CoffeeSourceType.cafe,
    );
  }

  static AiStatus _aiStatusFromJson(String? value) {
    return AiStatus.values.firstWhere(
      (status) => status.name == value,
      orElse: () => AiStatus.idle,
    );
  }

  static CutoutStatus _cutoutStatusFromJson(String? value) {
    return CutoutStatus.values.firstWhere(
      (status) => status.name == value,
      orElse: () => CutoutStatus.idle,
    );
  }
}

extension CoffeeRecordPhoto on CoffeeRecord {
  String? get displayPhotoUrl {
    final cutout = cutoutPhotoUrl?.trim();
    if (cutout != null && cutout.isNotEmpty) {
      return cutout;
    }
    final original = photoUrl?.trim();
    if (original != null && original.isNotEmpty) {
      return original;
    }
    return null;
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
