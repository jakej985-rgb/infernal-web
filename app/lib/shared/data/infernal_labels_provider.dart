import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../util/shared_prefs_provider.dart';

class UseInfernalLabelsNotifier extends Notifier<bool> {
  @override
  bool build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getBool('use_infernal_labels') ?? false;
  }

  Future<void> toggle(bool value) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool('use_infernal_labels', value);
    state = value;
  }
}

final useInfernalLabelsProvider = NotifierProvider<UseInfernalLabelsNotifier, bool>(() {
  return UseInfernalLabelsNotifier();
});

class UiLabels {
  static const standardLabels = {
    'home': 'Home',
    'calendar': 'Calendar',
    'contacts': 'Contacts',
    'quotes': 'Quotes',
    'settings': 'Settings',
    'stats': 'Stats',
    'tools': 'Tools',
    'app_title': 'INK & STEEL',
    'dashboard_title': 'DASHBOARD',
    'todays_appointments': "Today's Appointments",
    'active_clients': 'Active Clients',
    'open_quotes': 'Open Quotes',
    'pending_actions': 'Pending Actions',
    'empty_appointments': 'The calendar is empty today.',
    'no_upcoming_appointments': 'No upcoming appointments found.',
    'admin_status_title': 'SYSTEM STATUS',
    'admin_users_title': 'USER MANAGEMENT',
    'settings_title': 'SETTINGS',
    'recent_logs': 'RECENT LOGS',
    'logs_error': 'Error loading logs',
    'edit_client': 'Edit Client',
    'add_client': 'Add Client',
    'client_details': 'Client Details',
    'search_placeholder': 'Search clients...',
    'no_clients_found': 'No clients found.',
    'delete_client_title': 'Delete Client?',
    'delete_client_content': 'This client will be soft deleted. Continue?',
    'delete_client_action': 'Delete',
    'timeline_title': 'TIMELINE',
    'stats_title': 'STATS',
    'summoning_grid_title': 'QUICK ACTIONS',
    'action_new_ritual': 'Event+',
    'action_new_soul': 'Client+',
    'action_new_quote': 'Quote+',
    'action_supplies': 'Supplies',
    'action_invocation': 'Messages',
    'upcoming_sessions': 'Upcoming Appointments',
    'no_future_visions': 'No upcoming appointments.',
    'no_events_day': 'No appointments for this day.',
    'tools_title': 'TOOLS',
    'tool_inventory_title': 'Inventory',
    'tool_inventory_subtitle': 'Manage shop inventory',
    'tool_messages_title': 'Messages',
    'tool_messages_subtitle': 'Client communications hub',
    'appointment_details': 'Appointment Details',
    'delete_appointment_title': 'Cancel Appointment?',
    'delete_appointment_content': 'This will permanently remove the appointment. Are you sure?',
    'appointment_not_found': 'Appointment not found',
    'quote_details': 'Estimate Details',
    'delete_quote_title': 'Delete Estimate?',
    'delete_quote_content': 'This action cannot be undone. Continue?',
    'quote_not_found': 'Estimate not found',
  };

  static const infernalLabels = {
    'home': 'Studio',
    'calendar': 'Sessions',
    'contacts': 'Canvases',
    'quotes': 'Stencils',
    'settings': 'Autoclave',
    'stats': 'Ledger',
    'tools': 'Station',
    'app_title': 'INK & STEEL',
    'dashboard_title': 'STUDIO FRONT',
    'todays_appointments': "Today's Sessions",
    'active_clients': 'Active Canvases',
    'open_quotes': 'Open Stencils',
    'pending_actions': 'Shop Tasks',
    'empty_appointments': 'No sessions booked for today.',
    'no_upcoming_appointments': 'No upcoming sessions scheduled.',
    'admin_status_title': 'STERILIZATION LOGS // Status',
    'admin_users_title': 'STUDIO STAFF // Users',
    'settings_title': 'STERILIZATION & SYSTEM',
    'recent_logs': 'AUTOCLAVE & SYSTEM LOGS',
    'logs_error': 'Error loading system logs',
    'edit_client': 'Edit Canvas',
    'add_client': 'New Canvas',
    'client_details': 'Canvas Details',
    'search_placeholder': 'Search canvases...',
    'no_clients_found': 'No canvases found.',
    'delete_client_title': 'Archive Canvas?',
    'delete_client_content': 'This canvas record will be soft deleted. Continue?',
    'delete_client_action': 'Archive',
    'timeline_title': 'SESSION SCHEDULE',
    'stats_title': 'SHOP LEDGER // Stats',
    'summoning_grid_title': 'FRONT DESK GRID',
    'action_new_ritual': 'Session+',
    'action_new_soul': 'Canvas+',
    'action_new_quote': 'Stencil+',
    'action_supplies': 'Supplies',
    'action_invocation': 'Messages',
    'upcoming_sessions': 'Upcoming Sessions',
    'no_future_visions': 'No upcoming sessions scheduled.',
    'no_events_day': 'No sessions scheduled for this day.',
    'tools_title': 'STATION // Tools',
    'tool_inventory_title': 'Supply Inventory',
    'tool_inventory_subtitle': 'Manage studio supply levels',
    'tool_messages_title': 'Messages',
    'tool_messages_subtitle': 'Canvas communications hub',
    'appointment_details': 'Session Details',
    'delete_appointment_title': 'Cancel Session?',
    'delete_appointment_content': 'This will permanently cancel the session. Are you sure?',
    'appointment_not_found': 'Session not found',
    'quote_details': 'Stencil Details',
    'delete_quote_title': 'Delete Stencil?',
    'delete_quote_content': 'This stencil estimate will be deleted. Continue?',
    'quote_not_found': 'Stencil not found',
  };

  static String get(String key, bool useInfernal) {
    if (useInfernal) {
      return infernalLabels[key] ?? standardLabels[key] ?? key;
    }
    return standardLabels[key] ?? key;
  }
}
