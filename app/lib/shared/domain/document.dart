import 'package:freezed_annotation/freezed_annotation.dart';

part 'document.freezed.dart';
part 'document.g.dart';

/// Document entity matching legacy Domain/Document.cs
///
/// Represents a file upload attached to a client (waivers, reference images, etc.)
@freezed
abstract class Document with _$Document {
  const factory Document({
    /// Primary key
    required int id,

    /// Sync identifier for multi-device sync
    required String syncId,

    /// Foreign key to User who uploaded
    required int uploadedByUserId,

    /// Foreign key to Client
    required int clientId,

    /// Document title/name
    required String title,

    /// File storage path
    required String filePath,

    /// Upload timestamp
    required DateTime createdAt,

    /// Last modification timestamp (UTC)
    required DateTime lastModifiedUtc,

    /// User who last modified this record
    @Default('') String lastModifiedBy,

    /// Soft delete flag
    @Default(false) bool isDeleted,
  }) = _Document;

  /// Private constructor for custom getters
  const Document._();

  /// File extension from path
  String get fileExtension {
    final lastDot = filePath.lastIndexOf('.');
    if (lastDot == -1 || lastDot == filePath.length - 1) return '';
    return filePath.substring(lastDot + 1).toLowerCase();
  }

  /// Whether this is an image file
  bool get isImage {
    const imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp'];
    return imageExtensions.contains(fileExtension);
  }

  /// Whether this is a PDF file
  bool get isPdf => fileExtension == 'pdf';

  /// Create from JSON
  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);
}
