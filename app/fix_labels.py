import os
import re

lib_dir = '/home/m3tal/infernal-web/app/lib'

def process_file(filepath):
    with open(filepath, 'r') as f:
        content = f.read()

    original = content

    # Replace provider name
    content = content.replace('useInfernalLabelsProvider', 'labelModeProvider')

    # Find where the mode is read (e.g. final useInfernal = ref.watch(labelModeProvider);)
    # We want to add the custom labels fetch right after it
    # And make sure we import org_labels_provider.dart if not present
    
    # We will just replace all UiLabels.get(key, useInfernal) with UiLabels.get(key, useInfernal, customLabels)
    # But wait, sometimes it's passed as an argument.
    
    # It might be easier to just change UiLabels.get(key, mode) to use the customLabels if available.
    # To do this safely:
    # 1. Regex find: ref.watch(labelModeProvider)
    # 2. Add: final customLabels = ref.watch(orgLabelsProvider).value;
    
    watch_pattern = re.compile(r'(final\s+(\w+)\s*=\s*ref\.watch\(labelModeProvider\);)')
    match = watch_pattern.search(content)
    if match:
        var_name = match.group(2)
        replacement = match.group(1) + f'\n    final customLabels = ref.watch(orgLabelsProvider).value;'
        content = content.replace(match.group(1), replacement)
        
        # Now replace UiLabels.get(xxx, var_name) with UiLabels.get(xxx, var_name, customLabels)
        # It could be `UiLabels.get('key', useInfernal)`
        get_pattern = re.compile(r'UiLabels\.get\(([^,]+),\s*' + re.escape(var_name) + r'\)')
        content = get_pattern.sub(r'UiLabels.get(\1, ' + var_name + r', customLabels)', content)

        applabels_pattern = re.compile(r'AppLabels\.(\w+)\(' + re.escape(var_name) + r'\)')
        content = applabels_pattern.sub(r'AppLabels.\1(' + var_name + r', customLabels)', content)
        
        # Also need to add import if we added customLabels
        if 'customLabels = ref.watch(orgLabelsProvider)' in content and 'org_labels_provider.dart' not in content:
            # Add import at the top
            import_stmt = "import 'package:infernal_ink_steel/shared/data/org_labels_provider.dart';\n"
            # find first import
            first_import = content.find('import ')
            if first_import != -1:
                content = content[:first_import] + import_stmt + content[first_import:]

    # Special handling for methods that take useInfernal as argument, e.g., _deleteAppointment
    # If they use UiLabels.get(..., useInfernal), and customLabels is not in scope, they will fail to compile.
    # The flutter analyze will tell us! Let's just do a blanket replace for UiLabels.get(..., useInfernal) 
    # Wait, the regex above only replaced it if `var_name` matches. But if it's passed into a function as `useInfernal`, `var_name` was matched in `build()`, so `useInfernal` is replaced inside `build()`.
    # Functions outside `build()` won't have `customLabels` in scope!
    # A better approach: functions should take `customLabels` as well.
    # Let's see what happens. I'll just write this file and run it.

    if content != original:
        with open(filepath, 'w') as f:
            f.write(content)
        print(f"Updated {filepath}")

for root, dirs, files in os.walk(lib_dir):
    for file in files:
        if file.endswith('.dart'):
            process_file(os.path.join(root, file))
