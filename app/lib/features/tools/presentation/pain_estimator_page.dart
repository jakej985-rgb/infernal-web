import 'package:flutter/material.dart';
import '../../../app/theme/tokens.dart';
import '../../../shared/presentation/widgets/neon_divider.dart';

class PainZone {
  final String name;
  final int level; // 1-10
  final String description;
  final Offset position; // normalized 0-1
  final Size size;

  const PainZone({
    required this.name,
    required this.level,
    required this.description,
    required this.position,
    required this.size,
  });
}

class PainEstimatorPage extends StatefulWidget {
  const PainEstimatorPage({super.key});

  @override
  State<PainEstimatorPage> createState() => _PainEstimatorPageState();
}

class _PainEstimatorPageState extends State<PainEstimatorPage> {
  PainZone? _selectedZone;

  static const List<PainZone> _zones = [
    PainZone(
      name: 'Skull',
      level: 7,
      description: 'Thin skin over bone. Vibrations will echo through your very soul.',
      position: Offset(0.42, 0.02),
      size: Size(0.16, 0.08),
    ),
    PainZone(
      name: 'Inner Arm',
      level: 6,
      description: 'Tender flesh. A sharp, burning sensation that lingers.',
      position: Offset(0.25, 0.25),
      size: Size(0.1, 0.2),
    ),
    PainZone(
      name: 'Ribs',
      level: 9,
      description: 'The cage of life. Every breath becomes a ritual of endurance.',
      position: Offset(0.38, 0.2),
      size: Size(0.24, 0.15),
    ),
    PainZone(
      name: 'Stomach',
      level: 8,
      description: 'Soft and deep. A primal discomfort that reaches the core.',
      position: Offset(0.4, 0.35),
      size: Size(0.2, 0.12),
    ),
    PainZone(
      name: 'Knees',
      level: 8,
      description: 'Joint of the pilgrim. Sharp, stinging pain on the bone.',
      position: Offset(0.38, 0.65),
      size: Size(0.24, 0.05),
    ),
    PainZone(
      name: 'Feet',
      level: 9,
      description: 'The foundation. Nerve endings scream at every touch of the needle.',
      position: Offset(0.4, 0.9),
      size: Size(0.2, 0.08),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InfernalColors.background,
      appBar: AppBar(
        title: const Text('PAIN ESTIMATOR'),
        backgroundColor: InfernalColors.surface,
        foregroundColor: InfernalColors.textPrimary,
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          const NeonDivider(blurRadius: 10),
          Expanded(
            flex: 3,
            child: _buildBodyMap(),
          ),
          _buildReadout(),
        ],
      ),
    );
  }

  Widget _buildBodyMap() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: AspectRatio(
            aspectRatio: 0.55,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: InfernalSpacing.lg, vertical: InfernalSpacing.md),
              decoration: BoxDecoration(
                color: InfernalColors.surface,
                borderRadius: BorderRadius.circular(InfernalRadius.lg),
                border: Border.all(color: InfernalColors.border),
                gradient: const RadialGradient(
                  center: Alignment.center,
                  radius: 1.0,
                  colors: [
                    InfernalColors.surfaceElevated,
                    InfernalColors.surface,
                  ],
                ),
              ),
              child: Stack(
                children: [
                  _buildSilhouette(),
                  ..._zones.map((zone) => _buildZoneMarker(zone, constraints)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSilhouette() {
    return Center(
      child: Opacity(
        opacity: 0.05,
        child: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [InfernalColors.blood, Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(bounds),
          child: const Icon(
            Icons.accessibility_new,
            size: 400,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildZoneMarker(PainZone zone, BoxConstraints constraints) {
    final isSelected = _selectedZone == zone;
    final color = zone.level > 7 ? InfernalColors.blood : InfernalColors.gold;
    
    return Positioned(
      left: zone.position.dx * 300,
      top: zone.position.dy * 600,
      width: zone.size.width * 300,
      height: zone.size.height * 600,
      child: GestureDetector(
        onTap: () => setState(() => _selectedZone = zone),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: (isSelected ? color : Colors.transparent).withValues(alpha: 0.2),
            border: Border.all(
              color: isSelected ? color : color.withValues(alpha: 0.1),
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(InfernalRadius.sm),
            boxShadow: isSelected ? [
              BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 10, spreadRadius: 2)
            ] : null,
          ),
          child: isSelected 
            ? Center(child: Icon(Icons.gps_fixed, color: color, size: 20))
            : null,
        ),
      ),
    );
  }

  Widget _buildReadout() {
    return Container(
      height: 280,
      padding: const EdgeInsets.all(InfernalSpacing.lg),
      decoration: const BoxDecoration(
        color: InfernalColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(InfernalRadius.xl)),
        boxShadow: [
          BoxShadow(color: Colors.black54, blurRadius: 20, offset: Offset(0, -5))
        ],
      ),
      child: _selectedZone == null 
        ? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.touch_app, color: InfernalColors.textMuted, size: 48),
                SizedBox(height: InfernalSpacing.md),
                Text('Touch a site to gauge the suffering.', style: TextStyle(color: InfernalColors.textMuted)),
              ],
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedZone!.name.toUpperCase(),
                    style: const TextStyle(
                      color: InfernalColors.textPrimary,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
                  _buildPainMeter(_selectedZone!.level),
                ],
              ),
              const SizedBox(height: InfernalSpacing.sm),
              const NeonDivider(height: 20, thickness: 0.5),
              const SizedBox(height: InfernalSpacing.sm),
              Text(
                _selectedZone!.description,
                style: const TextStyle(
                  color: InfernalColors.textSecondary,
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: InfernalSpacing.sm),
                decoration: BoxDecoration(
                  color: (_selectedZone!.level > 7 ? InfernalColors.blood : InfernalColors.gold).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(InfernalRadius.sm),
                ),
                child: Text(
                  'ESTIMATED COST: ${_selectedZone!.level}/10 RITUAL INTENSITY',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _selectedZone!.level > 7 ? InfernalColors.blood : InfernalColors.gold,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildPainMeter(int level) {
    return Row(
      children: List.generate(5, (index) {
        final active = level > (index * 2);
        final color = level > 7 ? InfernalColors.blood : InfernalColors.gold;
        return Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Icon(
            active ? Icons.bolt : Icons.bolt_outlined,
            color: active ? color : InfernalColors.textMuted,
            size: 24,
          ),
        );
      }),
    );
  }
}
