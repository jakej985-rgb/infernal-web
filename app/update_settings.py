import re

filepath = '/home/m3tal/infernal-web/app/lib/features/settings/presentation/settings_page.dart'
with open(filepath, 'r') as f:
    content = f.read()

# Add Custom mode to dropdown
dropdown_str = """                  DropdownMenuItem(value: kLabelModeStudio, child: Text('Studio', style: TextStyle(color: InfernalColors.textPrimary))),
                  DropdownMenuItem(value: kLabelModeInfernal, child: Text('Infernal', style: TextStyle(color: InfernalColors.textPrimary))),"""

new_dropdown_str = """                  DropdownMenuItem(value: kLabelModeStudio, child: Text('Studio', style: TextStyle(color: InfernalColors.textPrimary))),
                  DropdownMenuItem(value: kLabelModeInfernal, child: Text('Infernal', style: TextStyle(color: InfernalColors.textPrimary))),
                  DropdownMenuItem(value: kLabelModeCustom, child: Text('Custom (Override)', style: TextStyle(color: InfernalColors.gold))),"""

content = content.replace(dropdown_str, new_dropdown_str)

# Add custom subtitle
subtitle_str = """      case kLabelModeInfernal:
        return 'Infernal terminology active (Altar, Dark Rites, Bound Souls)';
      default:
        return 'Standard terminology active (Home, Calendar, Contacts)';"""

new_subtitle_str = """      case kLabelModeInfernal:
        return 'Infernal terminology active (Altar, Dark Rites, Bound Souls)';
      case kLabelModeCustom:
        return 'Custom terminology active (Configured by your shop)';
      default:
        return 'Standard terminology active (Home, Calendar, Contacts)';"""

content = content.replace(subtitle_str, new_subtitle_str)

# Add edit custom terminology button right under Studio Terminology if custom is selected. Or just add a new SettingItem.
settings_item = """              onTap: () {},
            ),
          ],
        ),"""

new_settings_item = """              onTap: () {},
            ),
            if (ref.watch(labelModeProvider) == kLabelModeCustom)
              _SettingsItem(
                title: 'Edit Custom Labels',
                subtitle: 'Customize shop terminology',
                icon: Icons.edit_note,
                onTap: () => _showCustomLabelsDialog(context, ref),
              ),
          ],
        ),"""

content = content.replace(settings_item, new_settings_item)

# Ensure cloud_firestore and org_provider are imported
if 'cloud_firestore.dart' not in content:
    content = content.replace("import 'package:flutter/material.dart';", "import 'package:flutter/material.dart';\nimport 'package:cloud_firestore/cloud_firestore.dart';\nimport '../../../shared/data/org_provider.dart';\nimport '../../../shared/data/org_labels_provider.dart';")

# Add the dialog method
dialog_method = """  void _showCustomLabelsDialog(BuildContext context, WidgetRef ref) {
    final customLabelsAsync = ref.watch(orgLabelsProvider);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: InfernalColors.surface,
        title: const Text(
          'CUSTOM LABELS',
          style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold),
        ),
        content: customLabelsAsync.when(
          data: (custom) => _CustomLabelsEditor(initialData: custom, ref: ref),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Text('Error loading labels: $e'),
        ),
      ),
    );
  }"""

# Insert right after _showShopProfileDialog definition finishes (or just above it)
content = content.replace("void _showShopProfileDialog(", dialog_method + "\n\n  void _showShopProfileDialog(")

with open(filepath, 'w') as f:
    f.write(content)
