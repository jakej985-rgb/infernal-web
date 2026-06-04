import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../util/shared_prefs_provider.dart';

/// Label mode constants
const kLabelModeStandard = 'standard';
const kLabelModeStudio   = 'studio';
const kLabelModeInfernal = 'infernal';
const kLabelModeCustom   = 'custom';

const kPrefLabelMode = 'label_mode';

// ─── Provider ────────────────────────────────────────────────────────────────

class LabelModeNotifier extends Notifier<String> {
  @override
  String build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    // Migrate old bool pref → new string pref
    final legacy = prefs.getBool('use_infernal_labels');
    if (legacy != null && !prefs.containsKey(kPrefLabelMode)) {
      return legacy ? kLabelModeStudio : kLabelModeStandard;
    }
    return prefs.getString(kPrefLabelMode) ?? kLabelModeStandard;
  }

  Future<void> setMode(String mode) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(kPrefLabelMode, mode);
    state = mode;
  }

  /// Legacy compat — kept so any old callers don't crash
  Future<void> toggle(bool value) async {
    await setMode(value ? kLabelModeStudio : kLabelModeStandard);
  }
}

final labelModeProvider =
    NotifierProvider<LabelModeNotifier, String>(
      () => LabelModeNotifier(),
    );

// ─── AppLabels (short convenience labels) ────────────────────────────────────

class AppLabels {
  static String client(String mode, [Map<String, String>? custom]) {
    if (mode == kLabelModeCustom && custom != null && custom.containsKey('contacts')) return custom['contacts']!;
    switch (mode) {
      case kLabelModeStudio:   return 'Canvas';
      case kLabelModeInfernal: return 'Bound Soul';
      default:                 return 'Client';
    }
  }

  static String date(String mode, [Map<String, String>? custom]) {
    switch (mode) {
      case kLabelModeStudio:   return 'Session Date';
      case kLabelModeInfernal: return 'Rite Date';
      default:                 return 'Date';
    }
  }

  static String time(String mode, [Map<String, String>? custom]) {
    switch (mode) {
      case kLabelModeStudio:   return 'Session Time';
      case kLabelModeInfernal: return 'Rite Hour';
      default:                 return 'Time';
    }
  }

  static String service(String mode, [Map<String, String>? custom]) => 'Service';

  static String name(String mode, [Map<String, String>? custom]) {
    switch (mode) {
      case kLabelModeStudio:   return 'Name of Essence';
      case kLabelModeInfernal: return 'True Name';
      default:                 return 'Name';
    }
  }

  static String category(String mode, [Map<String, String>? custom]) {
    switch (mode) {
      case kLabelModeStudio:   return 'Category (Inks, Needles, etc.)';
      case kLabelModeInfernal: return 'Classification';
      default:                 return 'Category';
    }
  }
}

// ─── UiLabels (full label maps) ───────────────────────────────────────────────

class UiLabels {
  // ── Standard ──────────────────────────────────────────────────────────────
  static const standardLabels = {
    'home': 'Home',
    'calendar': 'Calendar',
    'contacts': 'Contacts',
    'quotes': 'Quotes',
    'documents': 'Documents',
    'settings': 'Settings',
    'stats': 'Stats',
    'tools': 'Tools',
    'documents_title': 'DOCUMENTS',
    'documents_upload': 'Upload Document',
    'documents_edit': 'Edit Document',
    'documents_empty': 'No documents found.',
    'documents_search': 'Search documents…',
    'documents_client_section': 'DOCUMENTS & WAIVERS',
    'documents_client_empty': 'No documents attached.',
    'document_details': 'Document',
    'document_delete_title': 'Delete Document?',
    'document_delete_content': 'This action cannot be undone.',
    'document_open': 'Open Document',
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
    'delete_appointment_content':
        'This will permanently remove the appointment. Are you sure?',
    'appointment_not_found': 'Appointment not found',
    'quote_details': 'Estimate Details',
    'delete_quote_title': 'Delete Estimate?',
    'delete_quote_content': 'This action cannot be undone. Continue?',
    'quote_not_found': 'Estimate not found',
    'new_appointment': 'New Appointment',
    'edit_appointment': 'Edit Appointment',
  };

  // ── Studio Mode (previously "infernal") ──────────────────────────────────
  static const studioLabels = {
    'home': 'Studio',
    'calendar': 'Sessions',
    'contacts': 'Canvases',
    'quotes': 'Stencils',
    'documents': 'Scrolls',
    'settings': 'Autoclave',
    'stats': 'Ledger',
    'tools': 'Station',
    'documents_title': 'SCROLLS & PACTS',
    'documents_upload': 'Bind New Scroll',
    'documents_edit': 'Edit Scroll',
    'documents_empty': 'No scrolls or pacts on record.',
    'documents_search': 'Search scrolls…',
    'documents_client_section': 'SCROLLS & PACTS',
    'documents_client_empty': 'No active pacts.',
    'document_details': 'Scroll',
    'document_delete_title': 'Burn This Scroll?',
    'document_delete_content': 'This pact cannot be restored.',
    'document_open': 'Open Scroll',
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
    'delete_appointment_content':
        'This will permanently cancel the session. Are you sure?',
    'appointment_not_found': 'Session not found',
    'quote_details': 'Stencil Details',
    'delete_quote_title': 'Delete Stencil?',
    'delete_quote_content': 'This stencil estimate will be deleted. Continue?',
    'quote_not_found': 'Stencil not found',
    'new_appointment': 'New Session',
    'edit_appointment': 'Edit Session',
  };

  // ── Infernal / Dark Mode ──────────────────────────────────────────────────
  static const infernalLabels = {
    'home': 'Altar',
    'calendar': 'Dark Rites',
    'contacts': 'Bound Souls',
    'quotes': 'Blood Pacts',
    'documents': 'Grimoire',
    'settings': 'Blood Rites',
    'stats': 'Blood Ledger',
    'tools': 'Arsenal',
    'documents_title': 'GRIMOIRE',
    'documents_upload': 'Inscribe Grimoire',
    'documents_edit': 'Edit Inscription',
    'documents_empty': 'The grimoire is empty.',
    'documents_search': 'Search grimoire…',
    'documents_client_section': 'GRIMOIRE ENTRIES',
    'documents_client_empty': 'No inscriptions found.',
    'document_details': 'Inscription',
    'document_delete_title': 'Burn This Inscription?',
    'document_delete_content': 'This dark knowledge cannot be restored.',
    'document_open': 'Read Inscription',
    'app_title': 'INFERNAL INK',
    'dashboard_title': 'THE ALTAR',
    'todays_appointments': "Tonight's Rites",
    'active_clients': 'Bound Souls',
    'open_quotes': 'Open Blood Pacts',
    'pending_actions': 'Dark Tasks',
    'empty_appointments': 'No rituals scheduled tonight.',
    'no_upcoming_appointments': 'No dark rites foreseen.',
    'admin_status_title': 'DARK OPS // Status',
    'admin_users_title': 'COVEN // Members',
    'settings_title': 'BLOOD RITES',
    'recent_logs': 'DARK CHRONICLE',
    'logs_error': 'Error loading chronicles',
    'edit_client': 'Edit Soul',
    'add_client': 'Bind New Soul',
    'client_details': 'Soul Details',
    'search_placeholder': 'Search souls...',
    'no_clients_found': 'No souls found.',
    'delete_client_title': 'Release This Soul?',
    'delete_client_content': 'This soul will be unbound. Continue?',
    'delete_client_action': 'Release',
    'timeline_title': 'RITUAL TIMELINE',
    'stats_title': 'BLOOD LEDGER // Stats',
    'summoning_grid_title': 'DARK SUMMONING',
    'action_new_ritual': 'Rite+',
    'action_new_soul': 'Soul+',
    'action_new_quote': 'Pact+',
    'action_supplies': 'Arsenal',
    'action_invocation': 'Invoke',
    'upcoming_sessions': 'Upcoming Rites',
    'no_future_visions': 'No rituals foreseen.',
    'no_events_day': 'No dark rites this day.',
    'tools_title': 'ARSENAL // Tools',
    'tool_inventory_title': 'Dark Supplies',
    'tool_inventory_subtitle': 'Manage infernal arsenal',
    'tool_messages_title': 'Invocations',
    'tool_messages_subtitle': 'Soul communications',
    'appointment_details': 'Ritual Details',
    'delete_appointment_title': 'Cancel This Rite?',
    'delete_appointment_content':
        'This dark rite will be struck from the grimoire. Continue?',
    'appointment_not_found': 'Ritual not found',
    'quote_details': 'Blood Pact Details',
    'delete_quote_title': 'Void This Pact?',
    'delete_quote_content': 'This blood pact will be voided. Continue?',
    'quote_not_found': 'Pact not found',
    'new_appointment': 'New Rite',
    'edit_appointment': 'Edit Rite',
  };

  static String get(String key, String mode, [Map<String, String>? custom]) {
    // 🟣 CUSTOM LAYER
    if (mode == kLabelModeCustom && custom != null) {
      if (custom.containsKey(key)) {
        return custom[key]!;
      }
    }

    // 🔵 INFERNAL LAYER
    if (mode == kLabelModeInfernal && infernalLabels.containsKey(key)) {
      return infernalLabels[key]!;
    }

    // 🔵 STUDIO LAYER
    if (mode == kLabelModeStudio && studioLabels.containsKey(key)) {
      return studioLabels[key]!;
    }

    // ⚪ STANDARD LAYER
    assert(
      standardLabels.containsKey(key),
      'Missing label key: $key',
    );
    return standardLabels[key] ?? key;
  }
}
