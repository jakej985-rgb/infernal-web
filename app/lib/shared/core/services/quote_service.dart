import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart' as uuid;
import '../../cache/id_mapper.dart';
import '../../data/org_provider.dart';
import '../../domain/quote.dart' as domain;

part 'quote_service.g.dart';

@riverpod
QuoteService quoteService(Ref ref) {
  return QuoteService(ref);
}

class QuoteService {
  final Ref _ref;
  QuoteService(this._ref);

  IdMapper get _idMapper => _ref.read(idMapperProvider);
  String get _orgId => _ref.read(orgIdProvider);

  Stream<List<domain.Quote>> watchQuotes() {
    final client = sb.Supabase.instance.client;
    return client
        .from('quotes')
        .stream(primaryKey: ['id'])
        .eq('org_id', _orgId)
        .asyncMap((data) async {
          final list = <domain.Quote>[];
          for (final row in data) {
            if (row['is_deleted'] == true) continue;
            list.add(await _mapRowToDomain(row, _idMapper));
          }
          return list;
        });
  }

  Stream<domain.Quote?> watchQuoteById(int id) {
    final uuidVal = _idMapper.getUuid('quote', id);
    if (uuidVal == null) {
      return Stream.value(null);
    }
    final client = sb.Supabase.instance.client;
    return client
        .from('quotes')
        .stream(primaryKey: ['id'])
        .eq('id', uuidVal)
        .asyncMap((data) async {
          if (data.isEmpty || data.first['is_deleted'] == true) return null;
          return await _mapRowToDomain(data.first, _idMapper);
        });
  }

  Future<void> createQuote(domain.Quote quote) async {
    final uuidVal = const uuid.Uuid().v4();
    final client = sb.Supabase.instance.client;

    String? clientUuid;
    if (quote.clientId != null) {
      clientUuid = _idMapper.getUuid('client', quote.clientId!);
    }

    String? artistUuid;
    artistUuid = _idMapper.getUuid('user', quote.artistId);
    artistUuid ??= 'default-artist-uuid';

    await client.from('quotes').insert({
      'id': uuidVal,
      'org_id': _orgId,
      'client_id': clientUuid,
      'artist_id': artistUuid,
      'placement': quote.placement,
      'style': quote.style,
      'is_cover_up': quote.isCoverUp,
      'width': quote.width,
      'height': quote.height,
      'coverage_level': quote.coverageLevel,
      'line_complexity': quote.lineComplexity,
      'shading_complexity': quote.shadingComplexity,
      'color_complexity': quote.colorComplexity,
      'difficulty': quote.difficulty,
      'estimated_hours_low': quote.estimatedHoursLow,
      'estimated_hours_high': quote.estimatedHoursHigh,
      'price_low': quote.priceLow,
      'price_high': quote.priceHigh,
      'shop_minimum': quote.shopMinimum,
      'recommended_deposit': quote.recommendedDeposit,
      'confidence_score': quote.confidenceScore,
      'similar_jobs_count': quote.similarJobsCount,
      'notes': quote.notes ?? '',
      'photo_path': quote.photoPath ?? '',
      'is_deleted': false,
      'created_at': DateTime.now().toUtc().toIso8601String(),
    });

    await _idMapper.registerUuid('quote', uuidVal);
  }

  Future<void> updateQuote(domain.Quote quote) async {
    final uuidVal = _idMapper.getUuid('quote', quote.id);
    if (uuidVal == null) throw Exception('Cannot resolve ID for quote.');

    String? clientUuid;
    if (quote.clientId != null) {
      clientUuid = _idMapper.getUuid('client', quote.clientId!);
    }

    final client = sb.Supabase.instance.client;
    await client.from('quotes').update({
      'client_id': clientUuid,
      'placement': quote.placement,
      'style': quote.style,
      'is_cover_up': quote.isCoverUp,
      'width': quote.width,
      'height': quote.height,
      'coverage_level': quote.coverageLevel,
      'line_complexity': quote.lineComplexity,
      'shading_complexity': quote.shadingComplexity,
      'color_complexity': quote.colorComplexity,
      'difficulty': quote.difficulty,
      'estimated_hours_low': quote.estimatedHoursLow,
      'estimated_hours_high': quote.estimatedHoursHigh,
      'price_low': quote.priceLow,
      'price_high': quote.priceHigh,
      'shop_minimum': quote.shopMinimum,
      'recommended_deposit': quote.recommendedDeposit,
      'confidence_score': quote.confidenceScore,
      'similar_jobs_count': quote.similarJobsCount,
      'notes': quote.notes ?? '',
      'photo_path': quote.photoPath ?? '',
    }).eq('id', uuidVal);
  }

  Future<void> deleteQuote(int id) async {
    final uuidVal = _idMapper.getUuid('quote', id);
    if (uuidVal == null) throw Exception('Cannot resolve ID for quote.');

    final client = sb.Supabase.instance.client;
    await client.from('quotes').update({
      'is_deleted': true,
    }).eq('id', uuidVal);
  }

  Future<domain.Quote> _mapRowToDomain(
    Map<String, dynamic> row,
    IdMapper idMapper,
  ) async {
    final uuidVal = row['id'] as String;
    final id = await idMapper.registerUuid('quote', uuidVal);

    final clientUuid = row['client_id'] as String?;
    int? clientId;
    if (clientUuid != null && clientUuid.isNotEmpty) {
      clientId = await idMapper.registerUuid('client', clientUuid);
    }

    final artistUuid = row['artist_id'] as String? ?? '';
    final artistId = artistUuid.isNotEmpty
        ? await idMapper.registerUuid('user', artistUuid)
        : 1;

    final createdAtStr = row['created_at'] as String;
    final createdAt = DateTime.parse(createdAtStr).toLocal();

    return domain.Quote(
      id: id,
      clientId: clientId,
      artistId: artistId,
      placement: row['placement'] as String? ?? '',
      style: row['style'] as String? ?? '',
      isCoverUp: row['is_cover_up'] as bool? ?? false,
      width: (row['width'] as num?)?.toDouble() ?? 0.0,
      height: (row['height'] as num?)?.toDouble() ?? 0.0,
      coverageLevel: row['coverage_level'] as int? ?? 3,
      lineComplexity: row['line_complexity'] as int? ?? 3,
      shadingComplexity: row['shading_complexity'] as int? ?? 3,
      colorComplexity: row['color_complexity'] as int? ?? 3,
      difficulty: row['difficulty'] as int? ?? 3,
      estimatedHoursLow: (row['estimated_hours_low'] as num?)?.toDouble() ?? 0.0,
      estimatedHoursHigh: (row['estimated_hours_high'] as num?)?.toDouble() ?? 0.0,
      priceLow: (row['price_low'] as num?)?.toDouble() ?? 0.0,
      priceHigh: (row['price_high'] as num?)?.toDouble() ?? 0.0,
      shopMinimum: (row['shop_minimum'] as num?)?.toDouble() ?? 0.0,
      recommendedDeposit: (row['recommended_deposit'] as num?)?.toDouble() ?? 0.0,
      confidenceScore: (row['confidence_score'] as num?)?.toDouble() ?? 0.0,
      similarJobsCount: row['similar_jobs_count'] as int? ?? 0,
      notes: row['notes'] as String?,
      photoPath: row['photo_path'] as String?,
      createdAt: createdAt,
    );
  }
}
