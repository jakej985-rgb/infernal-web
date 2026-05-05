// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Quote _$QuoteFromJson(Map<String, dynamic> json) => _Quote(
  id: (json['id'] as num).toInt(),
  clientId: (json['clientId'] as num?)?.toInt(),
  artistId: (json['artistId'] as num).toInt(),
  placement: json['placement'] as String? ?? '',
  style: json['style'] as String? ?? '',
  isCoverUp: json['isCoverUp'] as bool? ?? false,
  width: (json['width'] as num?)?.toDouble() ?? 0.0,
  height: (json['height'] as num?)?.toDouble() ?? 0.0,
  coverageLevel: (json['coverageLevel'] as num?)?.toInt() ?? 3,
  lineComplexity: (json['lineComplexity'] as num?)?.toInt() ?? 3,
  shadingComplexity: (json['shadingComplexity'] as num?)?.toInt() ?? 3,
  colorComplexity: (json['colorComplexity'] as num?)?.toInt() ?? 3,
  difficulty: (json['difficulty'] as num?)?.toInt() ?? 3,
  estimatedHoursLow: (json['estimatedHoursLow'] as num?)?.toDouble() ?? 0.0,
  estimatedHoursHigh: (json['estimatedHoursHigh'] as num?)?.toDouble() ?? 0.0,
  priceLow: (json['priceLow'] as num?)?.toDouble() ?? 0.0,
  priceHigh: (json['priceHigh'] as num?)?.toDouble() ?? 0.0,
  shopMinimum: (json['shopMinimum'] as num?)?.toDouble() ?? 0.0,
  recommendedDeposit: (json['recommendedDeposit'] as num?)?.toDouble() ?? 0.0,
  confidenceScore: (json['confidenceScore'] as num?)?.toDouble() ?? 0.0,
  similarJobsCount: (json['similarJobsCount'] as num?)?.toInt() ?? 0,
  notes: json['notes'] as String?,
  photoPath: json['photoPath'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$QuoteToJson(_Quote instance) => <String, dynamic>{
  'id': instance.id,
  'clientId': instance.clientId,
  'artistId': instance.artistId,
  'placement': instance.placement,
  'style': instance.style,
  'isCoverUp': instance.isCoverUp,
  'width': instance.width,
  'height': instance.height,
  'coverageLevel': instance.coverageLevel,
  'lineComplexity': instance.lineComplexity,
  'shadingComplexity': instance.shadingComplexity,
  'colorComplexity': instance.colorComplexity,
  'difficulty': instance.difficulty,
  'estimatedHoursLow': instance.estimatedHoursLow,
  'estimatedHoursHigh': instance.estimatedHoursHigh,
  'priceLow': instance.priceLow,
  'priceHigh': instance.priceHigh,
  'shopMinimum': instance.shopMinimum,
  'recommendedDeposit': instance.recommendedDeposit,
  'confidenceScore': instance.confidenceScore,
  'similarJobsCount': instance.similarJobsCount,
  'notes': instance.notes,
  'photoPath': instance.photoPath,
  'createdAt': instance.createdAt.toIso8601String(),
};

_QuoteInput _$QuoteInputFromJson(Map<String, dynamic> json) => _QuoteInput(
  clientId: (json['clientId'] as num?)?.toInt(),
  artistId: (json['artistId'] as num).toInt(),
  placement: json['placement'] as String? ?? '',
  style: json['style'] as String? ?? '',
  isCoverUp: json['isCoverUp'] as bool? ?? false,
  width: (json['width'] as num?)?.toDouble() ?? 0.0,
  height: (json['height'] as num?)?.toDouble() ?? 0.0,
  coverageLevel: (json['coverageLevel'] as num?)?.toInt() ?? 3,
  lineComplexity: (json['lineComplexity'] as num?)?.toInt() ?? 3,
  shadingComplexity: (json['shadingComplexity'] as num?)?.toInt() ?? 3,
  colorComplexity: (json['colorComplexity'] as num?)?.toInt() ?? 3,
  difficulty: (json['difficulty'] as num?)?.toInt() ?? 3,
  notes: json['notes'] as String?,
  photoPath: json['photoPath'] as String?,
);

Map<String, dynamic> _$QuoteInputToJson(_QuoteInput instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'artistId': instance.artistId,
      'placement': instance.placement,
      'style': instance.style,
      'isCoverUp': instance.isCoverUp,
      'width': instance.width,
      'height': instance.height,
      'coverageLevel': instance.coverageLevel,
      'lineComplexity': instance.lineComplexity,
      'shadingComplexity': instance.shadingComplexity,
      'colorComplexity': instance.colorComplexity,
      'difficulty': instance.difficulty,
      'notes': instance.notes,
      'photoPath': instance.photoPath,
    };

_QuoteEstimate _$QuoteEstimateFromJson(Map<String, dynamic> json) =>
    _QuoteEstimate(
      estimatedHoursLow: (json['estimatedHoursLow'] as num).toDouble(),
      estimatedHoursHigh: (json['estimatedHoursHigh'] as num).toDouble(),
      priceLow: (json['priceLow'] as num).toDouble(),
      priceHigh: (json['priceHigh'] as num).toDouble(),
      shopMinimum: (json['shopMinimum'] as num).toDouble(),
      recommendedDeposit: (json['recommendedDeposit'] as num).toDouble(),
      confidenceScore: (json['confidenceScore'] as num).toDouble(),
      similarJobsCount: (json['similarJobsCount'] as num).toInt(),
    );

Map<String, dynamic> _$QuoteEstimateToJson(_QuoteEstimate instance) =>
    <String, dynamic>{
      'estimatedHoursLow': instance.estimatedHoursLow,
      'estimatedHoursHigh': instance.estimatedHoursHigh,
      'priceLow': instance.priceLow,
      'priceHigh': instance.priceHigh,
      'shopMinimum': instance.shopMinimum,
      'recommendedDeposit': instance.recommendedDeposit,
      'confidenceScore': instance.confidenceScore,
      'similarJobsCount': instance.similarJobsCount,
    };
