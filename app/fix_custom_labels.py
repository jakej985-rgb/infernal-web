import re

files_to_fix = [
    '/home/m3tal/infernal-web/app/lib/features/appointments/presentation/appointment_form_page.dart',
    '/home/m3tal/infernal-web/app/lib/features/clients/presentation/client_details_page.dart'
]

for filepath in files_to_fix:
    with open(filepath, 'r') as f:
        content = f.read()

    # In these files, `customLabels` was injected blindly. We can replace `customLabels` with `ref.read(orgLabelsProvider).value` if it's inside `UiLabels.get`.
    # Let's just find and replace `customLabels` with `ref.read(orgLabelsProvider).value` in the whole file EXCEPT where `final customLabels = ref.watch(orgLabelsProvider).value;` is defined.
    # Actually, simpler: just remove `customLabels` if it's not defined, or define it at the top of the function.
    # We can just change `useInfernal, customLabels)` to `useInfernal, ref.read(orgLabelsProvider).value)` globally in these files, then revert the `watch` one.
    
    content = content.replace('customLabels', 'ref.read(orgLabelsProvider).value')
    # Revert the watch definition
    content = content.replace('final ref.read(orgLabelsProvider).value = ref.watch(orgLabelsProvider).value;', 'final customLabels = ref.watch(orgLabelsProvider).value;')
    # Revert usages in build method that could use customLabels? No, using ref.read is fine or ref.watch is fine. Wait, `customLabels` is still useful.
    # Just fix the specific occurrences!
    
    with open(filepath, 'w') as f:
        f.write(content)
        
    print(f"Fixed {filepath}")
