import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infernal_ink_steel/features/auth/domain/auth_state.dart';
import 'package:intl/intl.dart';
import '../../../app/theme/tokens.dart';
import '../../../../shared/domain/appointment.dart';
import '../../../../shared/domain/client.dart';
import '../../../../shared/domain/enums.dart';
import '../../auth/domain/auth_service.dart';
import '../data/appointments_provider.dart';
import 'controllers/appointment_controller.dart';
import '../../../../shared/presentation/labels/infernal_labels.dart';
import 'widgets/client_selection_modal.dart';

class AppointmentFormPage extends ConsumerStatefulWidget {
  final String? appointmentId;

  const AppointmentFormPage({super.key, this.appointmentId});

  @override
  ConsumerState<AppointmentFormPage> createState() =>
      _AppointmentFormPageState();
}

class _AppointmentFormPageState extends ConsumerState<AppointmentFormPage> {
  final _formKey = GlobalKey<FormState>();

  // State
  bool _isInit = true;
  bool _isLoading = false;

  // Fields
  Client? _selectedClient;
  DateTime _date = DateTime.now();
  TimeOfDay _time = const TimeOfDay(hour: 12, minute: 00);
  String _serviceType = 'Tattoo';
  String _status = 'Scheduled';

  final _durationCtrl = TextEditingController(text: '60');
  final _notesCtrl = TextEditingController();

  final List<String> _serviceTypes = [
    'Tattoo',
    'Piercing',
    'Consultation',
    'Touch-up',
  ];
  final List<String> _statuses = [
    'Scheduled',
    'In Progress',
    'Completed',
    'Cancelled',
    'No Show',
  ];

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
    _durationCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _initData() async {
    if (widget.appointmentId != null) {
      final id = int.tryParse(widget.appointmentId!);
      if (id != null) {
        // We need to fetch the appointment.
        // Assuming appointmentDetailProvider returns Stream, we can take first.
        ref.read(appointmentDetailProvider(id));
        // Since it is a stream, we should subscribe or await first value.
        // However, ref.read on a StreamProvider gives AsyncValue of the latest? No, it gives Stream.
        // We should use `ref.read(appointmentDetailProvider(id).future)` if it was FutureProvider.
        // But it's StreamProvider.
        // Let's use `ref.read` combined with stream listening or just `await first`.
        // Ideally, use `ref.watch` in build, but for form initialization we want one-time read?
        // Actually, if we use `ref.watch` in build, the form will reset if the stream updates.
        // We only want to Load Once.

        // Better approach:
        // Use a Future to fetch once.
        // But our provider is Stream.
        // We can listen once.

        final apt = await ref.read(appointmentDetailProvider(id).future);

        if (apt != null) {
          setState(() {
            _date = apt.dateTime;
            _time = TimeOfDay.fromDateTime(apt.dateTime);
            _serviceType = apt.serviceType;
            _status = apt.status;
            _durationCtrl.text = apt.durationMinutes.toString();
            _notesCtrl.text = apt.notes ?? '';

            // We also need the Client object to display name.
            _selectedClient = Client(
              id: apt.clientId,
              firstName: apt.clientName, // Store full or split
              lastName: '',
              middleName: '',
              phone: '',
              email: '',
              notes: '',
              visits: 0,
              photoPath: '',
              status: ClientStatus.bound,
              createdAt: DateTime.now(),
              lastModifiedUtc: DateTime.now(),
              lastModifiedBy: '',
              isDeleted: false,
              syncId: '',
            );
          });
        }
      }
    }
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
        builder: (_, ctrl) => ClientSelectionModal(),
      ),
    );

    if (result != null) {
      setState(() {
        _selectedClient = result;
      });
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: InfernalColors.blood,
              onPrimary: InfernalColors.textPrimary,
              surface: InfernalColors.surface,
              onSurface: InfernalColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _date = picked);
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _time,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: InfernalColors.surface,
              hourMinuteTextColor: InfernalColors.textPrimary,
              dayPeriodTextColor: InfernalColors.textSecondary,
              dialHandColor: InfernalColors.blood,
              dialBackgroundColor: InfernalColors.surfaceElevated,
            ),
            colorScheme: const ColorScheme.dark(
              primary: InfernalColors.blood,
              onPrimary: InfernalColors.textPrimary,
              surface: InfernalColors.surface,
              onSurface: InfernalColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _time = picked);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedClient == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You must summon a soul (select client).'),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      // Get current user ID
      final authState = ref.read(authServiceProvider);

      final userId =
          authState.value?.mapOrNull(authenticated: (s) => s.user.id) ??
          1; // Default to 1 if not logged in (or handle error)

      final dateTime = DateTime(
        _date.year,
        _date.month,
        _date.day,
        _time.hour,
        _time.minute,
      );

      final duration = int.tryParse(_durationCtrl.text) ?? 60;

      final controller = ref.read(appointmentControllerProvider);

      if (widget.appointmentId != null) {
        // Update
        final id = int.parse(widget.appointmentId!);
        // Fetch existing to keep fields?
        // We assume we have full data or just overwrite.
        // In _initData we fetched fields.
        // IMPORTANT: syncId and other fields must be preserved.
        final existing = await ref.read(appointmentDetailProvider(id).future);

        if (existing == null) throw Exception("Ritual not found");

        final updated = existing.copyWith(
          clientId: _selectedClient!.id,
          clientName: _selectedClient!.fullName,
          dateTime: dateTime,
          durationMinutes: duration,
          serviceType: _serviceType,
          status: _status,
          notes: _notesCtrl.text,
          lastModifiedUtc: DateTime.now(),
        );

        await controller.updateAppointment(updated);
      } else {
        // Create
        final newApt = Appointment(
          id: 0,
          syncId: '',
          clientId: _selectedClient!.id,
          userId: userId,
          clientName: _selectedClient!.fullName,
          dateTime: dateTime,
          durationMinutes: duration,
          serviceType: _serviceType,
          status: _status,
          notes: _notesCtrl.text,
          lastModifiedUtc: DateTime.now(),
          // Defaults
          serviceCategory: 'General',
          priceType: 'Hourly',
        );
        await controller.createAppointment(newApt);
      }

      if (!mounted) return;
      context.pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final useInfernal = ref.watch(useInfernalLabelsProvider);
    return Scaffold(
      backgroundColor: InfernalColors.background,
      appBar: AppBar(
        title: Text(
          widget.appointmentId == null ? 'New Ritual' : 'Edit Ritual',
        ),
        backgroundColor: InfernalColors.surface,
        foregroundColor: InfernalColors.textPrimary,
        actions: [
          IconButton(
            icon: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.check),
            onPressed: _isLoading ? null : _save,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(InfernalSpacing.md),
          children: [
            // Client Picker
            InkWell(
              onTap: _selectClient,
              borderRadius: BorderRadius.circular(InfernalRadius.md),
              child: Container(
                padding: const EdgeInsets.all(InfernalSpacing.md),
                decoration: BoxDecoration(
                  color: InfernalColors.surface,
                  borderRadius: BorderRadius.circular(InfernalRadius.md),
                  border: Border.all(
                    color: _selectedClient == null
                        ? InfernalColors.border
                        : InfernalColors.arcane,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.person,
                      color: InfernalColors.textSecondary,
                    ),
                    const SizedBox(width: InfernalSpacing.md),
                    Expanded(
                      child: Text(
                        _selectedClient == null
                            ? 'Select ${AppLabels.client(useInfernal)}'
                            : _selectedClient!.fullName,
                        style: TextStyle(
                          color: _selectedClient == null
                              ? InfernalColors.textMuted
                              : InfernalColors.textPrimary,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: InfernalColors.textMuted,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: InfernalSpacing.lg),

            // Date & Time
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: _pickDate,
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Date',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: InfernalColors.surface,
                        prefixIcon: Icon(
                          Icons.calendar_today,
                          color: InfernalColors.blood,
                        ),
                      ),
                      child: Text(
                        DateFormat('EEE, MMM d, y').format(_date),
                        style: const TextStyle(
                          color: InfernalColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: InfernalSpacing.md),
                Expanded(
                  child: InkWell(
                    onTap: _pickTime,
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Time',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: InfernalColors.surface,
                        prefixIcon: Icon(
                          Icons.access_time,
                          color: InfernalColors.blood,
                        ),
                      ),
                      child: Text(
                        _time.format(context),
                        style: const TextStyle(
                          color: InfernalColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: InfernalSpacing.lg),

            // Service Type & Status
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _serviceTypes.contains(_serviceType)
                        ? _serviceType
                        : _serviceTypes.first,
                    dropdownColor: InfernalColors.surfaceElevated,
                    decoration: const InputDecoration(
                      labelText: 'Service',
                      filled: true,
                      fillColor: InfernalColors.surface,
                      border: OutlineInputBorder(),
                    ),
                    style: const TextStyle(color: InfernalColors.textPrimary),
                    items: _serviceTypes
                        .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                        .toList(),
                    onChanged: (val) => setState(() => _serviceType = val!),
                  ),
                ),
                if (widget.appointmentId != null) ...[
                  const SizedBox(width: InfernalSpacing.md),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: _statuses.contains(_status)
                          ? _status
                          : _statuses.first,
                      dropdownColor: InfernalColors.surfaceElevated,
                      decoration: const InputDecoration(
                        labelText: 'Status',
                        filled: true,
                        fillColor: InfernalColors.surface,
                        border: OutlineInputBorder(),
                      ),
                      style: const TextStyle(color: InfernalColors.textPrimary),
                      items: _statuses
                          .map(
                            (s) => DropdownMenuItem(value: s, child: Text(s)),
                          )
                          .toList(),
                      onChanged: (val) => setState(() => _status = val!),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: InfernalSpacing.lg),

            // Duration
            TextFormField(
              controller: _durationCtrl,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: InfernalColors.textPrimary),
              decoration: const InputDecoration(
                labelText: 'Duration (minutes)',
                filled: true,
                fillColor: InfernalColors.surface,
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.timer,
                  color: InfernalColors.textSecondary,
                ),
              ),
              validator: (val) => (int.tryParse(val ?? '') ?? 0) > 0
                  ? null
                  : 'Invalid duration',
            ),
            const SizedBox(height: InfernalSpacing.lg),

            // Notes
            TextFormField(
              controller: _notesCtrl,
              maxLines: 4,
              style: const TextStyle(color: InfernalColors.textPrimary),
              decoration: const InputDecoration(
                labelText: 'Notes',
                filled: true,
                fillColor: InfernalColors.surface,
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
