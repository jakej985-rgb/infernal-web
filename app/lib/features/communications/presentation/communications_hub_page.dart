import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/theme/tokens.dart';
import '../../../shared/presentation/widgets/neon_divider.dart';
import '../../../shared/presentation/widgets/neon_plate.dart';
import '../data/communications_provider.dart';
import '../../clients/data/clients_provider.dart';
import '../../../../shared/domain/client.dart' as domain;
import '../../../../shared/domain/communication.dart';

class CommunicationsHubPage extends ConsumerStatefulWidget {
  const CommunicationsHubPage({super.key});

  @override
  ConsumerState<CommunicationsHubPage> createState() => _CommunicationsHubPageState();
}

class _CommunicationsHubPageState extends ConsumerState<CommunicationsHubPage> {
  final TextEditingController _messageController = TextEditingController();
  domain.Client? _selectedClient;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendInvocation() async {
    if (_messageController.text.isEmpty) return;

    final content = _messageController.text;
    final clientName = _selectedClient != null 
        ? '${_selectedClient!.firstName} ${_selectedClient!.lastName}' 
        : 'Unknown Soul';
    
    final ritual = CommunicationRitual(
      id: 0,
      clientId: _selectedClient?.id,
      clientName: clientName,
      type: 'SMS', // Default for now
      direction: 'OUTBOUND',
      content: content,
      sentAt: DateTime.now(),
      status: 'SENT',
    );

    await ref.read(communicationsServiceProvider.notifier).sendCommunication(ritual);
    _messageController.clear();
    setState(() {
      _selectedClient = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final communicationsAsync = ref.watch(communicationsProvider);

    return Scaffold(
      backgroundColor: InfernalColors.background,
      appBar: AppBar(
        title: const Text('RITUAL INVOCATIONS', style: TextStyle(letterSpacing: 4)),
        centerTitle: true,
        backgroundColor: InfernalColors.surface,
        elevation: 0,
      ),
      body: Column(
        children: [
          const NeonDivider(blurRadius: 8),
          Expanded(
            child: communicationsAsync.when(
              data: (rituals) => rituals.isEmpty 
                  ? _buildEmptyState() 
                  : _buildRitualList(rituals),
              loading: () => const Center(child: CircularProgressIndicator(color: InfernalColors.blood)),
              error: (err, stack) => Center(child: Text('Ritual error: $err', style: const TextStyle(color: InfernalColors.error))),
            ),
          ),
          if (_selectedClient != null) _buildRecipientIndicator(),
          _buildRitualComposer(),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.auto_fix_high, size: 64, color: InfernalColors.textMuted.withValues(alpha: 0.3)),
          const SizedBox(height: InfernalSpacing.md),
          const Text(
            'NO RECENT INVOCATIONS',
            style: TextStyle(color: InfernalColors.textMuted, letterSpacing: 2),
          ),
        ],
      ),
    );
  }

  Widget _buildRitualList(List<CommunicationRitual> rituals) {
    return ListView.builder(
      padding: const EdgeInsets.all(InfernalSpacing.md),
      reverse: true, // Show latest at bottom
      itemCount: rituals.length,
      itemBuilder: (context, index) {
        final ritual = rituals[rituals.length - 1 - index];
        final isOut = ritual.direction == 'OUTBOUND';

        return Padding(
          padding: const EdgeInsets.only(bottom: InfernalSpacing.md),
          child: Row(
            mainAxisAlignment: !isOut ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              if (!isOut) _buildAvatar(ritual.clientName),
              const SizedBox(width: InfernalSpacing.sm),
              Flexible(
                child: NeonPlate(
                  color: !isOut ? InfernalColors.arcane : InfernalColors.blood,
                  padding: const EdgeInsets.all(InfernalSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            !isOut ? ritual.clientName : 'ME',
                            style: const TextStyle(color: InfernalColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 10),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _formatTime(ritual.sentAt),
                            style: const TextStyle(color: InfernalColors.textMuted, fontSize: 9),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        ritual.content,
                        style: const TextStyle(color: InfernalColors.textPrimary),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: InfernalSpacing.sm),
              if (isOut) _buildAvatar('Me'),
            ],
          ),
        );
      },
    );
  }

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    return '${dt.day}/${dt.month}';
  }

  Widget _buildAvatar(String name) {
    return CircleAvatar(
      radius: 18,
      backgroundColor: InfernalColors.surfaceElevated,
      child: Text(
        name.isEmpty ? '?' : name[0].toUpperCase(),
        style: const TextStyle(color: InfernalColors.blood, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildRecipientIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: InfernalColors.surfaceElevated,
      child: Row(
        children: [
          const Icon(Icons.person_pin, color: InfernalColors.arcane, size: 16),
          const SizedBox(width: 8),
          Text(
            'TO: ${_selectedClient!.firstName} ${_selectedClient!.lastName}'.toUpperCase(),
            style: const TextStyle(color: InfernalColors.arcane, fontSize: 10, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.close, size: 16, color: InfernalColors.textMuted),
            onPressed: () => setState(() => _selectedClient = null),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildRitualComposer() {
    return Container(
      padding: const EdgeInsets.all(InfernalSpacing.md),
      decoration: const BoxDecoration(
        color: InfernalColors.surface,
        border: Border(top: BorderSide(color: InfernalColors.divider)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.person_add_outlined, color: InfernalColors.blood),
            onPressed: _showClientPicker,
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Speak thy invocation...',
                hintStyle: const TextStyle(color: InfernalColors.textMuted),
                filled: true,
                fillColor: InfernalColors.background,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(InfernalRadius.pill), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              style: const TextStyle(color: InfernalColors.textPrimary),
              onSubmitted: (_) => _sendInvocation(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: InfernalColors.arcane),
            onPressed: _sendInvocation,
          ),
        ],
      ),
    );
  }

  void _showClientPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: InfernalColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(InfernalRadius.lg)),
      ),
      builder: (context) {
        return Consumer(
          builder: (context, ref, _) {
            final clientsAsync = ref.watch(filteredClientsProvider);
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(InfernalSpacing.md),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search for a soul...',
                      prefixIcon: Icon(Icons.search, color: InfernalColors.blood),
                    ),
                    onChanged: (val) => ref.read(clientSearchQueryProvider.notifier).set(val),
                  ),
                ),
                Expanded(
                  child: clientsAsync.when(
                    data: (clients) => ListView.builder(
                      itemCount: clients.length,
                      itemBuilder: (context, index) {
                        final client = clients[index];
                        return ListTile(
                          title: Text('${client.firstName} ${client.lastName}', style: const TextStyle(color: InfernalColors.textPrimary)),
                          subtitle: Text(client.phone, style: const TextStyle(color: InfernalColors.textMuted)),
                          onTap: () {
                            setState(() => _selectedClient = client);
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                    loading: () => const Center(child: CircularProgressIndicator(color: InfernalColors.blood)),
                    error: (err, _) => Center(child: Text('Error: $err')),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
