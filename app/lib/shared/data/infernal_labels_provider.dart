import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../util/shared_prefs_provider.dart';

class UseInfernalLabelsNotifier extends Notifier<bool> {
  @override
  bool build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getBool('use_infernal_labels') ?? true;
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
  };

  static const infernalLabels = {
    'home': 'Altar',
    'calendar': 'Rituals',
    'contacts': 'Souls',
    'quotes': 'Quotes',
    'settings': 'Config',
    'stats': 'Omens',
    'tools': 'Arsenal',
    'app_title': 'INFERNAL',
    'dashboard_title': 'THE ALTAR',
    'todays_appointments': "Today's Rituals",
    'active_clients': 'Bound Souls',
    'open_quotes': 'Open Scrolls',
    'pending_actions': 'Pending',
    'empty_appointments': 'The altar is empty today.',
    'no_upcoming_appointments': 'The portal reveals no upcoming rituals.',
    'admin_status_title': 'MACHINE SPIRIT // Status',
    'settings_title': 'MACHINE SPIRIT',
    'recent_logs': 'RECENT INCANTATIONS (LOGS)',
    'logs_error': 'Error loading sanctuary logs',
    'edit_client': 'Edit Soul',
    'add_client': 'Summon Type',
    'client_details': 'Soul Details',
    'search_placeholder': 'Search souls...',
    'no_clients_found': 'No souls found.',
    'delete_client_title': 'Void Soul?',
    'delete_client_content': 'This soul will be cast into the void (soft deleted). Continue?',
    'delete_client_action': 'Void',
    'timeline_title': 'BLOOD MOON TIMELINE',
    'stats_title': 'VOX MECANICUS // Stats',
    'summoning_grid_title': 'SUMMONING GRID',
    'action_new_ritual': 'Ritual+',
    'action_new_soul': 'Soul+',
    'action_new_quote': 'Quote+',
    'action_supplies': 'Supplies',
    'action_invocation': 'Invocation',
    'upcoming_sessions': 'Upcoming Sessions',
    'no_future_visions': 'No future visions revealed.',
    'no_events_day': 'No rituals for this day.',
    'tools_title': 'ARSENAL // Tools',
    'tool_inventory_title': 'Supply (Inventory)',
    'tool_inventory_subtitle': 'Manage the alchemical stores',
    'tool_messages_title': 'Invocations (Messages)',
    'tool_messages_subtitle': 'Spirit communications hub',
  };

  static String get(String key, bool useInfernal) {
    if (useInfernal) {
      return infernalLabels[key] ?? standardLabels[key] ?? key;
    }
    return standardLabels[key] ?? key;
  }
}
