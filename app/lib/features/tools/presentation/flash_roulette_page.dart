import 'dart:math';
import 'package:flutter/material.dart';
import '../../../app/theme/tokens.dart';

class FlashRoulettePage extends StatefulWidget {
  const FlashRoulettePage({super.key});

  @override
  State<FlashRoulettePage> createState() => _FlashRoulettePageState();
}

class _FlashRoulettePageState extends State<FlashRoulettePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  String _selectedDesign = "?";
  bool _isSpinning = false;

  final List<String> _designs = [
    'Traditional Rose',
    'Cyberpunk Skull',
    'Dark Mandala',
    'Bloodmoon Raven',
    'Void Serpent',
    'Ethereal Dagger',
    'Bio-Organic Spire',
    'Gothic Script',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isSpinning = false;
          _selectedDesign = _designs[Random().nextInt(_designs.length)];
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _spin() {
    if (_isSpinning) return;
    setState(() {
      _isSpinning = true;
      _selectedDesign = "...";
    });
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InfernalColors.background,
      appBar: AppBar(
        title: const Text('FLASH ROULETTE'),
        backgroundColor: InfernalColors.surface,
        foregroundColor: InfernalColors.textPrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'SURRENDER TO FATE',
              style: TextStyle(
                color: InfernalColors.textMuted,
                letterSpacing: 4,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: InfernalSpacing.xl),
            _buildRouletteWheel(),
            const SizedBox(height: InfernalSpacing.xl),
            _buildResultDisplay(),
            const SizedBox(height: InfernalSpacing.xl),
            _buildSpinButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildRouletteWheel() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animation.value * 20, // Many rotations
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: [
                  InfernalColors.blood,
                  InfernalColors.surface,
                  InfernalColors.arcane,
                  InfernalColors.surface,
                ],
              ),
              border: Border.all(color: InfernalColors.border, width: 4),
              boxShadow: [
                BoxShadow(
                  color: InfernalColors.blood.withValues(alpha: 0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: const Center(
              child: Icon(Icons.flash_on, color: InfernalColors.gold, size: 64),
            ),
          ),
        );
      },
    );
  }

  Widget _buildResultDisplay() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: BoxDecoration(
        color: InfernalColors.surface,
        borderRadius: BorderRadius.circular(InfernalRadius.md),
        border: Border.all(color: InfernalColors.border),
      ),
      child: Text(
        _selectedDesign.toUpperCase(),
        style: const TextStyle(
          color: InfernalColors.textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          fontFamily: 'Outfit',
          letterSpacing: 2,
        ),
      ),
    );
  }

  Widget _buildSpinButton() {
    return ElevatedButton(
      onPressed: _isSpinning ? null : _spin,
      style: ElevatedButton.styleFrom(
        backgroundColor: InfernalColors.blood,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
        disabledBackgroundColor: InfernalColors.border,
      ),
      child: const Text(
        'PULL THE LEVER',
        style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
      ),
    );
  }
}
