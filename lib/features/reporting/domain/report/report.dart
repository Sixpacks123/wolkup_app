import 'package:freezed_annotation/freezed_annotation.dart';

part 'report.freezed.dart';
part 'report.g.dart';

@freezed
class Report with _$Report {
  const factory Report({
    String? id,
    required String user_id,
    required String category_id,
    required String description,
    required double latitude,
    required double longitude,
    required DateTime timestamp,
    int? status_id,  // Utilise status_id pour faire référence à la table status
  }) = _Report;

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);
}
