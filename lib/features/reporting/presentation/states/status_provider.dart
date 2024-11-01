import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wolkup_app/core/resources/lib/supabase.dart';
import '../../domain/report/report.dart';
import '../../domain/status/status.dart';

final statusProvider = FutureProvider<List<Status>>((ref) async {
  final response = await supabase.from('status').select();

  return (response as List<dynamic>)
      .map((json) => Status.fromJson(json))
      .toList();
});
