import re

files_to_fix = [
    '/home/m3tal/infernal-web/app/lib/features/appointments/presentation/appointment_details_page.dart',
    '/home/m3tal/infernal-web/app/lib/features/appointments/presentation/appointment_form_page.dart',
    '/home/m3tal/infernal-web/app/lib/features/clients/presentation/client_details_page.dart',
    '/home/m3tal/infernal-web/app/lib/features/documents/presentation/document_details_page.dart',
    '/home/m3tal/infernal-web/app/lib/features/quotes/presentation/quote_details_page.dart'
]

for filepath in files_to_fix:
    with open(filepath, 'r') as f:
        content = f.read()

    # In signatures like `int id, String useInfernal,` replace with `int id, String useInfernal, Map<String, String>? customLabels,`
    content = content.replace('String useInfernal,', 'String useInfernal, Map<String, String>? customLabels,')
    content = content.replace('String useInfernal)', 'String useInfernal, Map<String, String>? customLabels)')
    
    # In function calls `_deleteAppointment(context, ref, id, useInfernal)` replace with `..., useInfernal, customLabels)`
    content = content.replace(', useInfernal)', ', useInfernal, customLabels)')
    content = content.replace(', useInfernal,)', ', useInfernal, customLabels)')

    with open(filepath, 'w') as f:
        f.write(content)
        
    print(f"Fixed {filepath}")
