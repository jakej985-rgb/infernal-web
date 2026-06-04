import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../cache/id_mapper.dart';
import '../../data/org_provider.dart';
import '../../domain/quote.dart' as domain;
import 'firestore_helpers.dart';

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

  CollectionReference<Map<String, dynamic>> get _quotesRef =>
      orgDoc(_orgId).collection('quotes');

  Stream<List<domain.Quote>> watchQuotes() {
    return _quotesRef
        .where('isDeleted', isEqualTo: false)
        .snapshots()
        .asyncMap((snapshot) async {
          final list = <domain.Quote>[];
          for (final doc in snapshot.docs) {
            list.add(await _mapDocToDomain(doc, _idMapper));
          }
          return list;
        });
  }

  Stream<domain.Quote?> watchQuoteById(int id) {
    final uuid = _idMapper.getUuid('quote', id);
    if (uuid == null) {
      return Stream.value(null);
    }

    return _quotesRef.doc(uuid).snapshots().asyncMap((doc) async {
      if (!doc.exists || doc.data()?['isDeleted'] == true) return null;
      return await _mapDocToDomain(doc, _idMapper);
    });
  }

  Future<void> createQuote(domain.Quote quote) async {
    final docRef = _quotesRef.doc();
    final uuid = docRef.id;

    String? clientUuid;
    if (quote.clientId != null) {
      clientUuid = _idMapper.getUuid('client', quote.clientId!);
    }

    String? artistUuid;
    artistUuid = _idMapper.getUuid('user', quote.artistId);
    artistUuid ??= 'default-artist-uuid';

    await docRef.set({
      'client_id': clientUuid,
      'artist_id': artistUuid,
      'placement': quote.placement,
      'style': quote.style,
      'isCoverUp': quote.isCoverUp,
      'width': quote.width,
      'height': quote.height,
      'coverageLevel': quote.coverageLevel,
      'lineComplexity': quote.lineComplexity,
      'shadingComplexity': quote.shadingComplexity,
      'colorComplexity': quote.colorComplexity,
      'difficulty': quote.difficulty,
      'estimatedHoursLow': quote.estimatedHoursLow,
      'estimatedHoursHigh': quote.estimatedHoursHigh,
      'priceLow': quote.priceLow,
      'priceHigh': quote.priceHigh,
      'shopMinimum': quote.shopMinimum,
      'recommendedDeposit': quote.recommendedDeposit,
      'confidenceScore': quote.confidenceScore,
      'similarJobsCount': quote.similarJobsCount,
      'notes': quote.notes ?? '',
      'photoPath': quote.photoPath ?? '',
      'isDeleted': false,
      'createdAt': FieldValue.serverTimestamp(),
    });

    await _idMapper.registerUuid('quote', uuid);
  }

  Future<void> updateQuote(domain.Quote quote) async {
    final uuid = _idMapper.getUuid('quote', quote.id);
    if (uuid == null) throw Exception('Cannot resolve ID for quote.');

    String? clientUuid;
    if (quote.clientId != null) {
      clientUuid = _idMapper.getUuid('client', quote.clientId!);
    }

    await _quotesRef.doc(uuid).update({
      'client_id': clientUuid,
      'placement': quote.placement,
      'style': quote.style,
      'isCoverUp': quote.isCoverUp,
      'width': quote.width,
      'height': quote.height,
      'coverageLevel': quote.coverageLevel,
      'lineComplexity': quote.lineComplexity,
      'shadingComplexity': quote.shadingComplexity,
      'colorComplexity': quote.colorComplexity,
      'difficulty': quote.difficulty,
      'estimatedHoursLow': quote.estimatedHoursLow,
      'estimatedHoursHigh': quote.estimatedHoursHigh,
      'priceLow': quote.priceLow,
      'priceHigh': quote.priceHigh,
      'shopMinimum': quote.shopMinimum,
      'recommendedDeposit': quote.recommendedDeposit,
      'confidenceScore': quote.confidenceScore,
      'similarJobsCount': quote.similarJobsCount,
      'notes': quote.notes ?? '',
      'photoPath': quote.photoPath ?? '',
    });
  }

  Future<void> deleteQuote(int id) async {
    final uuid = _idMapper.getUuid('quote', id);
    if (uuid == null) throw Exception('Cannot resolve ID for quote.');

    await _quotesRef.doc(uuid).update({
      'isDeleted': true,
      'deletedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<domain.Quote> _mapDocToDomain(
    DocumentSnapshot<Map<String, dynamic>> doc,
    IdMapper idMapper,
  ) async {
    final uuid = doc.id;
    final id = await idMapper.registerUuid('quote', uuid);

    final data = doc.data() ?? {};
    final clientUuid = data['client_id'] as String?;
    int? clientId;
    if (clientUuid != null && clientUuid.isNotEmpty) {
      clientId = await idMapper.registerUuid('client', clientUuid);
    }

    final artistUuid = data['artist_id'] as String? ?? '';
    final artistId = artistUuid.isNotEmpty
        ? await idMapper.registerUuid('user', artistUuid)
        : 1;

    final createdAtTimestamp = data['createdAt'] as Timestamp?;
    final createdAt = createdAtTimestamp?.toDate() ?? DateTime.now();

    return domain.Quote(
      id: id,
      clientId: clientId,
      artistId: artistId,
      placement: data['placement'] as String? ?? '',
      style: data['style'] as String? ?? '',
      isCoverUp: data['isCoverUp'] as bool? ?? false,
      width: (data['width'] as num?)?.toDouble() ?? 0.0,
      height: (data['height'] as num?)?.toDouble() ?? 0.0,
      coverageLevel: data['coverageLevel'] as int? ?? 3,
      lineComplexity: data['lineComplexity'] as int? ?? 3,
      shadingComplexity: data['shadingComplexity'] as int? ?? 3,
      colorComplexity: data['colorComplexity'] as int? ?? 3,
      difficulty: data['difficulty'] as int? ?? 3,
      estimatedHoursLow: (data['estimatedHoursLow'] as num?)?.toDouble() ?? 0.0,
      estimatedHoursHigh: (data['estimatedHoursHigh'] as num?)?.toDouble() ?? 0.0,
      priceLow: (data['priceLow'] as num?)?.toDouble() ?? 0.0,
      priceHigh: (data['priceHigh'] as num?)?.toDouble() ?? 0.0,
      shopMinimum: (data['shopMinimum'] as num?)?.toDouble() ?? 0.0,
      recommendedDeposit: (data['recommendedDeposit'] as num?)?.toDouble() ?? 0.0,
      confidenceScore: (data['confidenceScore'] as num?)?.toDouble() ?? 0.0,
      similarJobsCount: data['similarJobsCount'] as int? ?? 0,
      notes: data['notes'] as String?,
      photoPath: data['photoPath'] as String?,
      createdAt: createdAt,
    );
  }
}
