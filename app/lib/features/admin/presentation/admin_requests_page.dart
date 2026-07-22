import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:uuid/uuid.dart';

import '../../../app/theme/tokens.dart';
import '../../auth/domain/auth_service.dart';
import '../../auth/domain/auth_state.dart';
import '../../../shared/domain/enums.dart';
import '../../../shared/presentation/widgets/neon_plate.dart';

class AdminRequestsPage extends ConsumerStatefulWidget {
  const AdminRequestsPage({super.key});

  @override
  ConsumerState<AdminRequestsPage> createState() => _AdminRequestsPageState();
}

class _AdminRequestsPageState extends ConsumerState<AdminRequestsPage> {
  final _uuid = const Uuid();

  Future<void> _sendInvite({
    required String email,
    required String shopName,
    required String shopId,
    required String displayName,
  }) async {
    try {
      final client = sb.Supabase.instance.client;
      final requestId = _uuid.v4();
      final inviteToken = _uuid.v4();

      String finalShopName = shopName.trim();
      String finalShopId = shopId.trim();
      String finalDisplayName = displayName.trim();

      final prefix = email.split('@').first;
      final cleanPrefix = prefix.toLowerCase().replaceAll(RegExp(r'[^a-z0-9-]'), '');

      if (finalShopId.isEmpty) {
        finalShopId = '$cleanPrefix-shop';
      }
      if (finalShopName.isEmpty) {
        finalShopName = '${prefix[0].toUpperCase()}${prefix.substring(1)} Shop';
      }
      if (finalDisplayName.isEmpty) {
        finalDisplayName = '${prefix[0].toUpperCase()}${prefix.substring(1)}';
      }

      await client.from('requests').insert({
        'id': requestId,
        'email': email,
        'shop_name': finalShopName,
        'shop_id': finalShopId,
        'display_name': finalDisplayName,
        'status': 'approved',
        'invite_token': inviteToken,
        'requested_at': DateTime.now().toUtc().toIso8601String(),
        'approved_at': DateTime.now().toUtc().toIso8601String(),
      });

      if (mounted) {
        _copyLink(requestId, inviteToken);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invitation created & claim link copied to clipboard!'),
            backgroundColor: InfernalColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send invite: $e'),
            backgroundColor: InfernalColors.error,
          ),
        );
      }
    }
  }

  void _showInviteDialog() {
    final formKey = GlobalKey<FormState>();
    final shopNameCtrl = TextEditingController();
    final shopIdCtrl = TextEditingController();
    final ownerNameCtrl = TextEditingController();
    final ownerEmailCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: InfernalColors.surface,
        title: const Text(
          'SEND NEW INVITATION',
          style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: shopNameCtrl,
                  style: const TextStyle(color: InfernalColors.textPrimary),
                  decoration: const InputDecoration(
                    labelText: 'Shop Name (Optional)',
                    hintText: 'e.g., Valhalla Ink',
                  ),
                  onChanged: (value) {
                    final slug = value
                        .toLowerCase()
                        .replaceAll(RegExp(r'[^a-z0-9\s-]'), '')
                        .replaceAll(RegExp(r'\s+'), '-');
                    shopIdCtrl.text = slug;
                  },
                ),
                const SizedBox(height: InfernalSpacing.md),
                TextFormField(
                  controller: shopIdCtrl,
                  style: const TextStyle(color: InfernalColors.textPrimary),
                  decoration: const InputDecoration(
                    labelText: 'Shop ID / Slug (Optional)',
                    hintText: 'e.g., valhalla-ink',
                  ),
                  validator: (value) {
                    if (value != null && value.trim().isNotEmpty) {
                      if (!RegExp(r'^[a-z0-9-]+$').hasMatch(value)) {
                        return 'Only lowercase letters, numbers, and dashes allowed';
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: InfernalSpacing.md),
                TextFormField(
                  controller: ownerNameCtrl,
                  style: const TextStyle(color: InfernalColors.textPrimary),
                  decoration: const InputDecoration(
                    labelText: 'Owner Name (Optional)',
                    hintText: 'e.g., Jane Doe',
                  ),
                ),
                const SizedBox(height: InfernalSpacing.md),
                TextFormField(
                  controller: ownerEmailCtrl,
                  style: const TextStyle(color: InfernalColors.textPrimary),
                  decoration: const InputDecoration(
                    labelText: 'Owner Email',
                    hintText: 'e.g., owner@valhallaink.com',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Owner email is required';
                    }
                    if (!value.contains('@')) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            style: TextButton.styleFrom(foregroundColor: InfernalColors.textMuted),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                final shopName = shopNameCtrl.text.trim();
                final shopId = shopIdCtrl.text.trim();
                final ownerName = ownerNameCtrl.text.trim();
                final ownerEmail = ownerEmailCtrl.text.trim();
                
                Navigator.pop(ctx);
                _sendInvite(
                  email: ownerEmail,
                  shopName: shopName,
                  shopId: shopId,
                  displayName: ownerName,
                );
              }
            },
            child: const Text('SEND & COPY LINK'),
          ),
        ],
      ),
    );
  }

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
    final isSu = authState?.maybeWhen(
      authenticated: (user) => user.role == UserRole.su,
      orElse: () => false,
    ) ?? false;

    if (!isSu) {
      return const Scaffold(
        backgroundColor: InfernalColors.background,
        body: Center(
          child: Text(
            'ACCESS DENIED: SUPER ADMIN ONLY',
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
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: InfernalColors.blood,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.send),
        label: const Text('SEND INVITE'),
        onPressed: _showInviteDialog,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: ref.watch(authServiceProvider.notifier).watchRequests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: InfernalColors.arcane));
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: InfernalColors.error)));
          }

          final requests = snapshot.data ?? [];
          if (requests.isEmpty) {
            return const Center(
              child: Text(
                'NO SHOP REQUESTS FOUND',
                style: TextStyle(color: InfernalColors.textMuted, letterSpacing: 1.5),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(InfernalSpacing.lg),
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final data = requests[index];
              final id = data['id'] as String;
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
                                color: statusColor.withValues(alpha: 0.15),
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
