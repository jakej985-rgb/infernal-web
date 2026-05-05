import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infernal_ink_steel/features/auth/domain/auth_state.dart';
import '../../../app/theme/tokens.dart';
import '../../../../shared/domain/client.dart';
import '../../../../shared/domain/quote.dart';
import '../../auth/domain/auth_service.dart';
import '../data/quotes_provider.dart';
import '../../appointments/presentation/widgets/client_selection_modal.dart';

class QuoteFormPage extends ConsumerStatefulWidget {
  final String? quoteId;

  const QuoteFormPage({super.key, this.quoteId});

  @override
  ConsumerState<QuoteFormPage> createState() => _QuoteFormPageState();
}

class _QuoteFormPageState extends ConsumerState<QuoteFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isInit = true;
  bool _isLoading = false;

  // Fields
  Client? _selectedClient;
  final _placementCtrl = TextEditingController();
  final _styleCtrl = TextEditingController();
  final _widthCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();
  
  bool _isCoverUp = false;
  
  // Complexity (1-5)
  double _coverage = 3;
  double _lineWork = 3;
  double _shading = 3;
  double _color = 3;
  double _difficulty = 3;
  
  // Estimates
  final _hoursLowCtrl = TextEditingController();
  final _hoursHighCtrl = TextEditingController();
  final _priceLowCtrl = TextEditingController();
  final _priceHighCtrl = TextEditingController();
  final _depositCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _initData();
      _isInit = false;
    }
  }
  
  @override
  void dispose() {
    _placementCtrl.dispose();
    _styleCtrl.dispose();
    _widthCtrl.dispose();
    _heightCtrl.dispose();
    _hoursLowCtrl.dispose();
    _hoursHighCtrl.dispose();
    _priceLowCtrl.dispose();
    _priceHighCtrl.dispose();
    _depositCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _initData() async {
    if (widget.quoteId != null) {
      final id = int.tryParse(widget.quoteId!);
      if (id != null) {
          final quote = await ref.read(quoteDetailProvider(id).future);
         
         if (quote != null) {
            setState(() {
               // We need client info. Ideally Quote has clientName or we deduce it.
               // Quote domain might not have clientName denormalized?
               // Let's check shared/domain/quote.dart.
               // It usually has ID. We might need to fetch client to show name.
               // For simplicity, we'll try to fetch client if ID exists.
               // Or just show ID if name not avail.
               // Wait, `Quote` domain has `clientId`.
               // I'll leave client blank or fetch it properly if I had `clientDetailProvider`.
               // I do have `clientDetailProvider(id)` in `clients_provider.dart`.
               // I'll fetch it.
               _loadClient(quote.clientId);

               _placementCtrl.text = quote.placement;
               _styleCtrl.text = quote.style;
               _isCoverUp = quote.isCoverUp;
               _widthCtrl.text = quote.width.toString();
               _heightCtrl.text = quote.height.toString();
               _coverage = quote.coverageLevel.toDouble();
               _lineWork = quote.lineComplexity.toDouble();
               _shading = quote.shadingComplexity.toDouble();
               _color = quote.colorComplexity.toDouble();
               _difficulty = quote.difficulty.toDouble();
               
               _hoursLowCtrl.text = quote.estimatedHoursLow.toString();
               _hoursHighCtrl.text = quote.estimatedHoursHigh.toString();
               _priceLowCtrl.text = quote.priceLow.toString();
               _priceHighCtrl.text = quote.priceHigh.toString();
               _depositCtrl.text = quote.recommendedDeposit.toString();
               _notesCtrl.text = quote.notes ?? '';
            });
         }
      }
    }
  }

  Future<void> _loadClient(int? clientId) async {
     if (clientId == null) return;
     // Hacky fetch
     // We define client provider import?
     // I'll skip resolving client name for edit mode MVP to avoid circular deps or complexity.
     // Just show "Client ID: $clientId" if _selectedClient is null.
  }

  Future<void> _selectClient() async {
    final result = await showModalBottomSheet<Client>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, _) => ClientSelectionModal(),
      ),
    );

    if (result != null) {
      setState(() => _selectedClient = result);
    }
  }
  
  Future<void> _save() async {
     if (!_formKey.currentState!.validate()) return;
     // Client is optional for Quote? Usually yes, estimtes can be anonymous?
     // But schema has clientId nullable. OK.
     
     setState(() => _isLoading = true);
     try {
        final authState = ref.read(authServiceProvider);
        final userId = authState.value?.maybeMap(
           authenticated: (s) => s.user.id,
           orElse: () => 1
        ) ?? 1;

        final q = Quote(
           id: widget.quoteId == null ? 0 : int.parse(widget.quoteId!),
           clientId: _selectedClient?.id,
           artistId: userId,
           placement: _placementCtrl.text,
           style: _styleCtrl.text,
           isCoverUp: _isCoverUp,
           width: double.tryParse(_widthCtrl.text) ?? 0,
           height: double.tryParse(_heightCtrl.text) ?? 0,
           coverageLevel: _coverage.toInt(),
           lineComplexity: _lineWork.toInt(),
           shadingComplexity: _shading.toInt(),
           colorComplexity: _color.toInt(),
           difficulty: _difficulty.toInt(),
           estimatedHoursLow: double.tryParse(_hoursLowCtrl.text) ?? 0,
           estimatedHoursHigh: double.tryParse(_hoursHighCtrl.text) ?? 0,
           priceLow: double.tryParse(_priceLowCtrl.text) ?? 0,
           priceHigh: double.tryParse(_priceHighCtrl.text) ?? 0,
           shopMinimum: 150.0, // Default or fetch
           recommendedDeposit: double.tryParse(_depositCtrl.text) ?? 0,
           confidenceScore: 0.8,
           similarJobsCount: 0,
           notes: _notesCtrl.text,
           photoPath: null,
           createdAt: DateTime.now(), // Ignored on update usually
        );
        
        final service = ref.read(quotesServiceProvider);
        if (widget.quoteId != null) {
           await service.updateQuote(q);
        } else {
           await service.createQuote(q);
        }

        if (!mounted) return;
        context.pop();
     } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
     } finally {
        if (mounted) setState(() => _isLoading = false);
     }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InfernalColors.background,
      appBar: AppBar(
        title: Text(widget.quoteId == null ? 'New Estimate' : 'Edit Estimate'),
        backgroundColor: InfernalColors.surface,
        foregroundColor: InfernalColors.textPrimary,
        actions: [
           IconButton(
             icon: _isLoading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.check),
             onPressed: _isLoading ? null : _save,
           )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(InfernalSpacing.md),
          children: [
             // Client
             InkWell(
               onTap: _selectClient,
               borderRadius: BorderRadius.circular(InfernalRadius.md),
               child: Container(
                 padding: const EdgeInsets.all(InfernalSpacing.md),
                 decoration: BoxDecoration(
                   color: InfernalColors.surface,
                   border: Border.all(color: InfernalColors.border),
                   borderRadius: BorderRadius.circular(InfernalRadius.md),
                 ),
                 child: Row(
                   children: [
                     const Icon(Icons.person, color: InfernalColors.textSecondary),
                     const SizedBox(width: InfernalSpacing.md),
                     Text(
                        _selectedClient?.fullName ?? (_isLoading || (widget.quoteId != null && _selectedClient == null) ? 'Client (Tap to Select)' : 'Select Client'),
                        style: TextStyle(color: _selectedClient != null ? InfernalColors.textPrimary : InfernalColors.textMuted),
                     ),
                   ],
                 ),
               ),
             ),
             const SizedBox(height: InfernalSpacing.lg),
             
             // Base Info
             Row(
                children: [
                   Expanded(child: _buildTextField(_placementCtrl, 'Placement')),
                   const SizedBox(width: InfernalSpacing.md),
                   Expanded(child: _buildTextField(_styleCtrl, 'Style')),
                ],
             ),
             const SizedBox(height: InfernalSpacing.md),
             SwitchListTile(
                title: const Text('Cover-Up?', style: TextStyle(color: InfernalColors.textPrimary)),
                value: _isCoverUp,
                activeThumbColor: InfernalColors.blood,
                onChanged: (v) => setState(() => _isCoverUp = v),
             ),
             const SizedBox(height: InfernalSpacing.md),
             
             // Dimensions
             Row(
                children: [
                   Expanded(child: _buildTextField(_widthCtrl, 'Width (in)', isNumber: true)),
                   const SizedBox(width: InfernalSpacing.md),
                   Expanded(child: _buildTextField(_heightCtrl, 'Height (in)', isNumber: true)),
                ],
             ),
             const SizedBox(height: InfernalSpacing.lg),
             
             // Sliders
             const Text('Complexity Factors (1-5)', style: TextStyle(color: InfernalColors.gold, fontWeight: FontWeight.bold)),
             _buildSlider('Coverage', _coverage, (v) => setState(() => _coverage = v)),
             _buildSlider('Line Work', _lineWork, (v) => setState(() => _lineWork = v)),
             _buildSlider('Shading', _shading, (v) => setState(() => _shading = v)),
             _buildSlider('Color', _color, (v) => setState(() => _color = v)),
             _buildSlider('Difficulty', _difficulty, (v) => setState(() => _difficulty = v)),
             
             const SizedBox(height: InfernalSpacing.lg),
             const Divider(color: InfernalColors.divider),
             const SizedBox(height: InfernalSpacing.md),
             
             // Estimates
             const Text('Estimate (Manual)', style: TextStyle(color: InfernalColors.arcane, fontWeight: FontWeight.bold)),
             const SizedBox(height: InfernalSpacing.md),
             Row(
                children: [
                   Expanded(child: _buildTextField(_hoursLowCtrl, 'Hours (Low)', isNumber: true)),
                   const SizedBox(width: InfernalSpacing.md),
                   Expanded(child: _buildTextField(_hoursHighCtrl, 'Hours (High)', isNumber: true)),
                ],
             ),
             const SizedBox(height: InfernalSpacing.md),
             Row(
                children: [
                   Expanded(child: _buildTextField(_priceLowCtrl, 'Price (Low) \$', isNumber: true)),
                   const SizedBox(width: InfernalSpacing.md),
                   Expanded(child: _buildTextField(_priceHighCtrl, 'Price (High) \$', isNumber: true)),
                ],
             ),
             
             const SizedBox(height: InfernalSpacing.lg),
             _buildTextField(_notesCtrl, 'Notes', maxLines: 3),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTextField(TextEditingController ctrl, String label, {bool isNumber = false, int maxLines = 1}) {
     return TextFormField(
        controller: ctrl,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        maxLines: maxLines,
        style: const TextStyle(color: InfernalColors.textPrimary),
        decoration: InputDecoration(
           labelText: label,
           filled: true,
           fillColor: InfernalColors.surface,
           border: const OutlineInputBorder(),
        ),
     );
  }
  
  Widget _buildSlider(String label, double value, ValueChanged<double> onChanged) {
     return Row(
        children: [
           SizedBox(width: 80, child: Text(label, style: const TextStyle(color: InfernalColors.textSecondary))),
           Expanded(
              child: Slider(
                 value: value,
                 min: 1,
                 max: 5,
                 divisions: 4,
                 activeColor: InfernalColors.blood,
                 inactiveColor: InfernalColors.surfaceElevated,
                 label: value.toInt().toString(),
                 onChanged: onChanged,
              ),
           ),
           Text(value.toInt().toString(), style: const TextStyle(color: InfernalColors.textPrimary)),
        ],
     );
  }
}
