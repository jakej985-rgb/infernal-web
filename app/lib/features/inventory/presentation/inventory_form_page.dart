import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../../../app/theme/tokens.dart';
import '../../../shared/persistence/database.dart';
import '../../../shared/presentation/widgets/neon_plate.dart';
import '../data/inventory_provider.dart';
import '../../../../shared/domain/inventory.dart' as domain;

class InventoryFormPage extends ConsumerStatefulWidget {
  final domain.InventoryItem? item;

  const InventoryFormPage({super.key, this.item});

  @override
  ConsumerState<InventoryFormPage> createState() => _InventoryFormPageState();
}

class _InventoryFormPageState extends ConsumerState<InventoryFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _categoryController;
  late TextEditingController _stockController;
  late TextEditingController _minStockController;
  late TextEditingController _unitController;
  late TextEditingController _supplierController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item?.name ?? '');
    _categoryController = TextEditingController(text: widget.item?.category ?? '');
    _stockController = TextEditingController(text: widget.item?.stockQuantity.toString() ?? '0');
    _minStockController = TextEditingController(text: widget.item?.minimumQuantity.toString() ?? '0');
    _unitController = TextEditingController(text: widget.item?.unit ?? 'pcs');
    _supplierController = TextEditingController(text: widget.item?.supplier ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _stockController.dispose();
    _minStockController.dispose();
    _unitController.dispose();
    _supplierController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final category = _categoryController.text;
      final stock = double.tryParse(_stockController.text) ?? 0.0;
      final minStock = double.tryParse(_minStockController.text) ?? 0.0;
      final unit = _unitController.text;
      final supplier = _supplierController.text.isEmpty ? null : _supplierController.text;

      if (widget.item == null) {
        // Insert (Drift Companion)
        final companion = InventoryItemsCompanion.insert(
          name: name,
          category: category,
          stockQuantity: drift.Value(stock),
          minimumQuantity: drift.Value(minStock),
          unit: unit,
          supplier: drift.Value(supplier),
          updatedAt: drift.Value(DateTime.now()),
        );
        await ref.read(inventoryServiceProvider.notifier).addItem(companion);
      } else {
        // Update (Domain Object)
        final updatedItem = widget.item!.copyWith(
          name: name,
          category: category,
          stockQuantity: stock,
          minimumQuantity: minStock,
          unit: unit,
          supplier: supplier,
          updatedAt: DateTime.now(),
        );
        await ref.read(inventoryServiceProvider.notifier).updateItem(updatedItem);
      }

      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.item != null;

    return Scaffold(
      backgroundColor: InfernalColors.background,
      appBar: AppBar(
        title: Text(isEditing ? 'RECALIBRATE SUPPLY' : 'SUMMON SUPPLY', style: const TextStyle(letterSpacing: 2)),
        backgroundColor: InfernalColors.surface,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(InfernalSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildField('NAME OF ESSENCE', _nameController, Icons.inventory_2_outlined),
              const SizedBox(height: InfernalSpacing.md),
              _buildField('CATEGORY (Inks, Needles, etc.)', _categoryController, Icons.category_outlined),
              const SizedBox(height: InfernalSpacing.md),
              Row(
                children: [
                  Expanded(child: _buildField('STOCK LEVEL', _stockController, Icons.numbers, isNumber: true)),
                  const SizedBox(width: InfernalSpacing.md),
                  Expanded(child: _buildField('UNIT (oz, pcs, roll)', _unitController, Icons.straighten)),
                ],
              ),
              const SizedBox(height: InfernalSpacing.md),
              _buildField('MINIMUM LEVEL (Low Stock Warning)', _minStockController, Icons.warning_amber_rounded, isNumber: true),
              const SizedBox(height: InfernalSpacing.md),
              _buildField('SUPPLIER (Optional)', _supplierController, Icons.business_outlined),
              const SizedBox(height: InfernalSpacing.xl),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: InfernalColors.blood,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(InfernalRadius.md)),
                  ),
                  child: Text(isEditing ? 'COMMIT RITUAL' : 'SUMMON TO ARSENAL'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller, IconData icon, {bool isNumber = false}) {
    return NeonPlate(
      color: InfernalColors.arcane,
      padding: const EdgeInsets.symmetric(horizontal: InfernalSpacing.md, vertical: 4),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? const TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
        style: const TextStyle(color: InfernalColors.textPrimary),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: InfernalColors.textMuted, fontSize: 12),
          icon: Icon(icon, color: InfernalColors.blood),
          border: InputBorder.none,
        ),
        validator: (value) => (value == null || value.isEmpty) ? 'Field cannot be empty' : null,
      ),
    );
  }
}
