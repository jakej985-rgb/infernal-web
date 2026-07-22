import 'package:infernal_ink_steel/shared/data/org_labels_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../app/theme/tokens.dart';
import '../../../shared/presentation/widgets/neon_plate.dart';
import '../../../../shared/domain/appointment.dart' as domain;
import '../data/appointments_provider.dart';
import 'widgets/appointment_status_chip.dart';
import '../../../shared/data/infernal_labels_provider.dart';
import '../../../app/router.dart';

enum AppointmentsViewMode { list, calendar }

final appointmentsViewModeProvider = StateProvider<AppointmentsViewMode>(
  (ref) => AppointmentsViewMode.calendar,
);
final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

class AppointmentsListPage extends ConsumerWidget {
  const AppointmentsListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewMode = ref.watch(appointmentsViewModeProvider);
    final upcomingAsync = ref.watch(upcomingAppointmentsProvider);
    final todaysAsync = ref.watch(todaysAppointmentsProvider);
    final allAsync = ref.watch(allAppointmentsProvider);
    final useInfernal = ref.watch(labelModeProvider);
    final customLabels = ref.watch(orgLabelsProvider).value;

    return Scaffold(
      backgroundColor: InfernalColors.background,
      appBar: AppBar(
        title: Text(UiLabels.get('calendar', useInfernal, customLabels)),
        backgroundColor: InfernalColors.surface,
        foregroundColor: InfernalColors.textPrimary,
        leading: MediaQuery.sizeOf(context).width < 800
            ? IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              )
            : null,
        actions: [
          IconButton(
            icon: Icon(
              viewMode == AppointmentsViewMode.list
                  ? Icons.calendar_month
                  : Icons.list,
            ),
            onPressed: () {
              ref
                  .read(appointmentsViewModeProvider.notifier)
                  .state = viewMode == AppointmentsViewMode.list
                  ? AppointmentsViewMode.calendar
                  : AppointmentsViewMode.list;
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: InfernalColors.blood,
        foregroundColor: InfernalColors.textPrimary,
        child: const Icon(Icons.add),
        onPressed: () => context.go('${AppRoutes.appointments}/new'),
      ),
      body: viewMode == AppointmentsViewMode.list
          ? _ListView(todaysAsync: todaysAsync, upcomingAsync: upcomingAsync)
          : allAsync.when(
              data: (data) => _CalendarView(appointments: data),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) => Center(child: Text('Error: $e')),
            ),
    );
  }
}

class _ListView extends ConsumerWidget {
  final AsyncValue<List<domain.Appointment>> todaysAsync;
  final AsyncValue<List<domain.Appointment>> upcomingAsync;

  const _ListView({required this.todaysAsync, required this.upcomingAsync});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useInfernal = ref.watch(labelModeProvider);
    final customLabels = ref.watch(orgLabelsProvider).value;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            title: UiLabels.get('todays_appointments', useInfernal, customLabels),
          ),
          todaysAsync.when(
            data: (data) => _AppointmentList(
              appointments: data,
              emptyText: UiLabels.get('empty_appointments', useInfernal, customLabels),
            ),
            loading: () => const Padding(
              padding: EdgeInsets.all(InfernalSpacing.md),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, s) => Padding(
              padding: const EdgeInsets.all(InfernalSpacing.md),
              child: Text(
                'Error: $e',
                style: const TextStyle(color: InfernalColors.error),
              ),
            ),
          ),
          const SizedBox(height: InfernalSpacing.lg),
          _SectionHeader(title: UiLabels.get('upcoming_sessions', useInfernal, customLabels)),
          upcomingAsync.when(
            data: (data) => _AppointmentList(
              appointments: data,
              emptyText: UiLabels.get('no_future_visions', useInfernal, customLabels),
            ),
            loading: () => const Padding(
              padding: EdgeInsets.all(InfernalSpacing.md),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, s) => Padding(
              padding: const EdgeInsets.all(InfernalSpacing.md),
              child: Text(
                'Error: $e',
                style: const TextStyle(color: InfernalColors.error),
              ),
            ),
          ),
          const SizedBox(height: InfernalSpacing.xl),
        ],
      ),
    );
  }
}

class _CalendarView extends ConsumerStatefulWidget {
  final List<domain.Appointment> appointments;

  const _CalendarView({required this.appointments});

  @override
  ConsumerState<_CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends ConsumerState<_CalendarView> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();

  List<domain.Appointment> _getEventsForDay(DateTime day) {
    return widget.appointments
        .where((apt) => isSameDay(apt.dateTime, day))
        .toList();
  }

  Widget _buildDayCell({
    required DateTime day,
    required Color textColor,
    BoxDecoration? decoration,
    required List<domain.Appointment> events,
  }) {
    final hasEvents = events.isNotEmpty;

    return Container(
      margin: const EdgeInsets.all(2),
      decoration: decoration ??
          (hasEvents
              ? BoxDecoration(
                  color: InfernalColors.blood.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(InfernalRadius.sm),
                  border: Border.all(
                    color: InfernalColors.blood.withValues(alpha: 0.25),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: InfernalColors.blood.withValues(alpha: 0.1),
                      blurRadius: 4,
                      spreadRadius: 0.5,
                    ),
                  ],
                )
              : null),
      child: Stack(
        children: [
          Center(
            child: Text(
              '${day.day}',
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: hasEvents ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          if (hasEvents)
            Positioned(
              top: 2,
              right: 4,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: InfernalColors.blood,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: InfernalColors.blood.withValues(alpha: 0.6),
                      blurRadius: 4,
                      spreadRadius: 0.5,
                    ),
                  ],
                ),
                constraints: const BoxConstraints(
                  minWidth: 14,
                  minHeight: 14,
                ),
                child: Center(
                  child: Text(
                    '${events.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedDay = ref.watch(selectedDateProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(InfernalSpacing.md),
          child: NeonPlate(
            color: InfernalColors.blood,
            padding: const EdgeInsets.all(InfernalSpacing.sm),
            child: TableCalendar<domain.Appointment>(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) => isSameDay(selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                ref.read(selectedDateProvider.notifier).state = selectedDay;
                setState(() {
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              eventLoader: _getEventsForDay,
              calendarStyle: const CalendarStyle(
                outsideDaysVisible: false,
                markersMaxCount: 0, // Disable default markers to use markerBuilder
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: true,
                titleCentered: true,
                formatButtonShowsNext: false,
                titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: InfernalColors.blood,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ) ?? const TextStyle(color: InfernalColors.blood, fontSize: 16),
                formatButtonTextStyle: const TextStyle(
                  color: InfernalColors.gold,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
                formatButtonDecoration: BoxDecoration(
                  border: Border.all(color: InfernalColors.gold.withValues(alpha: 0.5)),
                  borderRadius: BorderRadius.circular(InfernalRadius.sm),
                  color: InfernalColors.gold.withValues(alpha: 0.1),
                ),
                leftChevronIcon: const Icon(
                  Icons.chevron_left,
                  color: InfernalColors.blood,
                ),
                rightChevronIcon: const Icon(
                  Icons.chevron_right,
                  color: InfernalColors.blood,
                ),
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                  color: InfernalColors.textSecondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
                weekendStyle: TextStyle(
                  color: InfernalColors.blood,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  final events = _getEventsForDay(day);
                  return _buildDayCell(
                    day: day,
                    textColor: events.isNotEmpty ? InfernalColors.blood : InfernalColors.textPrimary,
                    events: events,
                  );
                },
                selectedBuilder: (context, day, focusedDay) {
                  final events = _getEventsForDay(day);
                  return _buildDayCell(
                    day: day,
                    textColor: Colors.white,
                    decoration: BoxDecoration(
                      color: InfernalColors.blood.withValues(alpha: 0.25),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: InfernalColors.blood,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: InfernalColors.blood.withValues(alpha: 0.5),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    events: events,
                  );
                },
                todayBuilder: (context, day, focusedDay) {
                  final events = _getEventsForDay(day);
                  return _buildDayCell(
                    day: day,
                    textColor: InfernalColors.arcane,
                    decoration: BoxDecoration(
                      color: InfernalColors.arcane.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: InfernalColors.arcane.withValues(alpha: 0.8),
                        width: 1.5,
                      ),
                    ),
                    events: events,
                  );
                },
                markerBuilder: (context, day, events) {
                  if (events.isEmpty) return const SizedBox.shrink();
                  
                  return Positioned(
                    bottom: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: events.take(3).map((event) {
                        Color dotColor = InfernalColors.blood;
                        if (event.status.toLowerCase() == 'completed') {
                          dotColor = Colors.green;
                        } else if (event.status.toLowerCase() == 'cancelled') {
                          dotColor = InfernalColors.error;
                        }
                        
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 1.0),
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            color: dotColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: dotColor.withValues(alpha: 0.8),
                                blurRadius: 3,
                                spreadRadius: 0.5,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        const Divider(color: InfernalColors.divider),
        Expanded(
          child: _AppointmentList(
            appointments: _getEventsForDay(selectedDay),
            physics: const AlwaysScrollableScrollPhysics(),
            emptyText: UiLabels.get(
              'no_events_day',
              ref.watch(labelModeProvider),
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        InfernalSpacing.md,
        InfernalSpacing.lg,
        InfernalSpacing.md,
        InfernalSpacing.sm,
      ),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: InfernalColors.textMuted,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}

class _AppointmentList extends StatelessWidget {
  final List<domain.Appointment> appointments;
  final String emptyText;
  final ScrollPhysics physics;

  const _AppointmentList({
    required this.appointments,
    required this.emptyText,
    this.physics = const NeverScrollableScrollPhysics(),
  });

  @override
  Widget build(BuildContext context) {
    if (appointments.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: InfernalSpacing.md),
        child: Text(
          emptyText,
          style: const TextStyle(
            color: InfernalColors.textSecondary,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: physics,
      padding: const EdgeInsets.symmetric(horizontal: InfernalSpacing.md),
      itemCount: appointments.length,
      separatorBuilder: (_, index) =>
          const SizedBox(height: InfernalSpacing.sm),
      itemBuilder: (ctx, idx) {
        final apt = appointments[idx];
        return Card(
          color: InfernalColors.surface,
          margin: EdgeInsets.zero,
          child: InkWell(
            onTap: () => context.go('${AppRoutes.appointments}/${apt.id}'),
            borderRadius: BorderRadius.circular(InfernalRadius.md),
            child: Padding(
              padding: const EdgeInsets.all(InfernalSpacing.md),
              child: Row(
                children: [
                  // Time
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('HH:mm').format(apt.dateTime),
                        style: const TextStyle(
                          color: InfernalColors.textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        DateFormat('MMM d').format(apt.dateTime),
                        style: const TextStyle(
                          color: InfernalColors.textMuted,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: InfernalSpacing.md),
                  Container(
                    width: 1,
                    height: 40,
                    color: InfernalColors.divider,
                  ),
                  const SizedBox(width: InfernalSpacing.md),
                  // Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          apt.clientName.isEmpty
                              ? 'Unknown Soul'
                              : apt.clientName,
                          style: const TextStyle(
                            color: InfernalColors.textPrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              apt.serviceType,
                              style: const TextStyle(
                                color: InfernalColors.textSecondary,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(width: 8),
                            AppointmentStatusChip(statusString: apt.status),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: InfernalColors.textMuted,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
