import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infernal_ink_steel/features/communications/data/communications_provider.dart';
import 'package:infernal_ink_steel/features/communications/presentation/communications_hub_page.dart';
import 'package:infernal_ink_steel/shared/domain/communication.dart';



void main() {
  testWidgets('CommunicationsHubPage shows log and composer tabs', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          communicationsProvider.overrideWith((ref) => Stream.value([])),
        ],
        child: const MaterialApp(home: CommunicationsHubPage()),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('RITUAL INVOCATIONS'), findsOneWidget);
    expect(find.text('NO RECENT INVOCATIONS'), findsOneWidget);

  });

  testWidgets('CommunicationsHubPage shows messages in log', (tester) async {
    final message = CommunicationRitual(
      id: 1,
      clientId: 123,
      clientName: 'Client X',
      type: 'SMS',
      direction: 'OUTBOUND',
      content: 'Appointment Confirmed',
      sentAt: DateTime.now(),
      status: 'SENT',
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          communicationsProvider.overrideWith((ref) => Stream.value([message])),
        ],
        child: const MaterialApp(home: CommunicationsHubPage()),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('ME'), findsOneWidget);
    expect(find.text('Appointment Confirmed'), findsOneWidget);

  });
}
