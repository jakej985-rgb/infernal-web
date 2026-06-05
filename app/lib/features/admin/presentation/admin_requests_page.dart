import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../app/theme/tokens.dart';
import '../../auth/domain/auth_service.dart';
import '../../auth/domain/auth_state.dart';
import '../../../shared/presentation/widgets/neon_plate.dart';

class AdminRequestsPage extends ConsumerStatefulWidget {
  const AdminRequestsPage({super.key});

  @override
  ConsumerState<AdminRequestsPage> createState() => _AdminRequestsPageState();
}

class _AdminRequestsPageState extends ConsumerState<AdminRequestsPage> {
  final _uuid = const Uuid();

  Future<void> _approve(String requestId) async {
    final inviteToken = _uuid.v4();
    try {
      await ref.read(authServiceProvider.notifier).approveShopRequest(requestId, inviteToken);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Request approved! Copy the invite link to share.'),
            backgroundColor: InfernalColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Approval failed: $e'),
            backgroundColor: InfernalColors.error,
          ),
        );
      }
    }
  }

  Future<void> _reject(String requestId) async {
    try {
      await ref.read(authServiceProvider.notifier).rejectShopRequest(requestId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Request rejected.'),
            backgroundColor: InfernalColors.error,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Rejection failed: $e'),
            backgroundColor: InfernalColors.error,
          ),
        );
      }
    }
  }

  void _copyLink(String id, String token) {
    final baseUri = Uri.base;
    final claimLink = '${baseUri.scheme}://${baseUri.authority}/#/register/claim?id=$id&token=$token';
    
    Clipboard.setData(ClipboardData(text: claimLink));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Claim link copied to clipboard!'),
        backgroundColor: InfernalColors.success,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authServiceProvider).value;
    final userEmail = authState?.maybeWhen(
      authenticated: (user) => user.username,
      orElse: () => '',
    );

    if (userEmail != 'admin@inkandsteel.xyz') {
      return const Scaffold(
        backgroundColor: InfernalColors.background,
        body: Center(
          child: Text(
            'ACCESS DENIED: SYSTEM ADMIN ONLY',
            style: TextStyle(color: InfernalColors.error, letterSpacing: 2),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: InfernalColors.background,
      appBar: AppBar(
        title: const Text('SHOP REQUESTS REVIEW'),
        backgroundColor: InfernalColors.surface,
        foregroundColor: InfernalColors.textPrimary,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('requests')
            .orderBy('requestedAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: InfernalColors.arcane));
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: InfernalColors.error)));
          }

          final docs = snapshot.data?.docs ?? [];
          if (docs.isEmpty) {
            return const Center(
              child: Text(
                'NO SHOP REQUESTS FOUND',
                style: TextStyle(color: InfernalColors.textMuted, letterSpacing: 1.5),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(InfernalSpacing.lg),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data();
              final id = docs[index].id;
              final status = data['status'] as String? ?? 'pending';
              final shopName = data['shopName'] as String? ?? 'Unknown Shop';
              final shopId = data['shopId'] as String? ?? '';
              final email = data['email'] as String? ?? '';
              final displayName = data['displayName'] as String? ?? '';
              final inviteToken = data['inviteToken'] as String? ?? '';

              Color statusColor;
              switch (status) {
                case 'approved':
                  statusColor = InfernalColors.success;
                  break;
                case 'rejected':
                  statusColor = InfernalColors.error;
                  break;
                case 'claimed':
                  statusColor = InfernalColors.gold;
                  break;
                default:
                  statusColor = InfernalColors.arcane;
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: InfernalSpacing.md),
                child: NeonPlate(
                  color: statusColor,
                  child: Padding(
                    padding: const EdgeInsets.all(InfernalSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              shopName.toUpperCase(),
                              style: const TextStyle(
                                color: InfernalColors.textPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: 1.5,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: statusColor.withOpacity(0.15),
                                border: Border.all(color: statusColor),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                status.toUpperCase(),
                                style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: InfernalSpacing.sm),
                        Text('Shop ID: $shopId', style: const TextStyle(color: InfernalColors.textSecondary)),
                        Text('Owner: $displayName ($email)', style: const TextStyle(color: InfernalColors.textSecondary)),
                        const SizedBox(height: InfernalSpacing.md),
                        if (status == 'pending') ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () => _reject(id),
                                style: TextButton.styleFrom(foregroundColor: InfernalColors.error),
                                child: const Text('REJECT'),
                              ),
                              const SizedBox(width: InfernalSpacing.md),
                              ElevatedButton(
                                onPressed: () => _approve(id),
                                style: ElevatedButton.styleFrom(backgroundColor: InfernalColors.success),
                                child: const Text('APPROVE & GENERATE LINK'),
                              ),
                            ],
                          )
                        ] else if (status == 'approved') ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: Text(
                                  'Share claim link with owner.',
                                  style: TextStyle(color: InfernalColors.textMuted, fontStyle: FontStyle.italic),
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: () => _copyLink(id, inviteToken),
                                style: ElevatedButton.styleFrom(backgroundColor: InfernalColors.success),
                                icon: const Icon(Icons.copy, size: 16),
                                label: const Text('COPY CLAIM LINK'),
                              ),
                            ],
                          )
                        ] else if (status == 'claimed') ...[
                          const Text(
                            'Setup completed. This sanctum is active.',
                            style: TextStyle(color: InfernalColors.textMuted, fontStyle: FontStyle.italic),
                          ),
                        ] else ...[
                          const Text(
                            'This setup request has been rejected.',
                            style: TextStyle(color: InfernalColors.textMuted, fontStyle: FontStyle.italic),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
