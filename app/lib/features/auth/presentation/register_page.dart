import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/tokens.dart';
import '../../../shared/presentation/widgets/neon_plate.dart';
import '../../../shared/presentation/widgets/neon_divider.dart';
import '../domain/auth_service.dart';
import '../domain/auth_state.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _shopNameController = TextEditingController();
  final _shopIdController = TextEditingController();
  
  bool _isLoading = false;
  bool _isInit = true;
  
  // Claim Mode variables
  bool _isClaimMode = false;
  String? _requestId;
  String? _inviteToken;
  bool _isValidatingToken = false;
  String? _validationError;
  
  // Request Mode variables
  bool _requestSubmitted = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final state = GoRouterState.of(context);
      final id = state.uri.queryParameters['id'];
      final token = state.uri.queryParameters['token'];

      if (id != null && token != null) {
        setState(() {
          _isClaimMode = true;
          _requestId = id;
          _inviteToken = token;
        });
        _checkClaimDetails(id, token);
      }
      _isInit = false;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _displayNameController.dispose();
    _passwordController.dispose();
    _shopNameController.dispose();
    _shopIdController.dispose();
    super.dispose();
  }

  Future<void> _checkClaimDetails(String id, String token) async {
    setState(() {
      _isValidatingToken = true;
      _validationError = null;
    });

    try {
      final data = await ref.read(authServiceProvider.notifier).getShopRequest(id);
      if (data == null) {
        setState(() {
          _validationError = 'Sanctum invitation link not found.';
          _isValidatingToken = false;
        });
        return;
      }

      if (data['status'] == 'claimed') {
        setState(() {
          _validationError = 'This invitation has already been claimed.';
          _isValidatingToken = false;
        });
        return;
      }
      if (data['status'] != 'approved') {
        setState(() {
          _validationError = 'This setup request is pending review or has been rejected.';
          _isValidatingToken = false;
        });
        return;
      }
      if (data['inviteToken'] != token) {
        setState(() {
          _validationError = 'Invalid invitation authorization token.';
          _isValidatingToken = false;
        });
        return;
      }

      setState(() {
        _emailController.text = data['email'] ?? '';
        _shopNameController.text = data['shopName'] ?? '';
        _shopIdController.text = data['shopId'] ?? '';
        _displayNameController.text = data['displayName'] ?? '';
        _isValidatingToken = false;
      });
    } catch (e) {
      setState(() {
        _validationError = 'Error verifying invitation: $e';
        _isValidatingToken = false;
      });
    }
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) return;

    if (_isClaimMode) {
      // Claim approved request
      ref.read(authServiceProvider.notifier).claimShopRequest(
            requestId: _requestId!,
            inviteToken: _inviteToken!,
            password: _passwordController.text,
          );
    } else {
      // Submit new join request
      ref
          .read(authServiceProvider.notifier)
          .submitShopRequest(
            email: _emailController.text.trim(),
            shopName: _shopNameController.text.trim(),
            shopId: _shopIdController.text.trim().toLowerCase(),
            displayName: _displayNameController.text.trim(),
          )
          .then((_) {
        setState(() {
          _requestSubmitted = true;
        });
      }).catchError((e) {
        // Handled by ref.listen error state
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<AuthState>>(authServiceProvider, (previous, next) {
      next.when(
        data: (authState) {
          authState.maybeWhen(
            authenticated: (user) {
              if (mounted) {
                context.go(AppRoutes.dashboard);
              }
            },
            orElse: () {},
          );

          setState(() {
            _isLoading = authState.maybeWhen(
              loading: () => true,
              orElse: () => false,
            );
          });
        },
        error: (error, stack) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Action failed: ${error.toString()}'),
              backgroundColor: InfernalColors.error,
            ),
          );
        },
        loading: () {
          setState(() => _isLoading = true);
        },
      );
    });

    if (_isValidatingToken) {
      return const Scaffold(
        backgroundColor: InfernalColors.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: InfernalColors.arcane),
              SizedBox(height: InfernalSpacing.md),
              Text(
                'VERIFYING SANCTUM INVITATION...',
                style: TextStyle(color: InfernalColors.textSecondary, letterSpacing: 2),
              ),
            ],
          ),
        ),
      );
    }

    if (_validationError != null) {
      return Scaffold(
        backgroundColor: InfernalColors.background,
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(InfernalSpacing.xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NeonPlate(
                  color: InfernalColors.error,
                  padding: const EdgeInsets.all(InfernalSpacing.lg),
                  child: const Icon(Icons.error_outline, color: InfernalColors.error, size: 48),
                ),
                const SizedBox(height: InfernalSpacing.lg),
                Text(
                  'ACCESS DENIED',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: InfernalColors.error,
                    letterSpacing: 4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: InfernalSpacing.md),
                Text(
                  _validationError!,
                  style: const TextStyle(color: InfernalColors.textMuted),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: InfernalSpacing.xl),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: InfernalColors.surface),
                    onPressed: () => context.go(AppRoutes.login),
                    child: const Text('BACK TO SANCTUM'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (_requestSubmitted) {
      return Scaffold(
        backgroundColor: InfernalColors.background,
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 450),
            padding: const EdgeInsets.all(InfernalSpacing.xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NeonPlate(
                  color: InfernalColors.success,
                  padding: const EdgeInsets.all(InfernalSpacing.lg),
                  child: const Icon(Icons.shield_outlined, color: InfernalColors.success, size: 48),
                ),
                const SizedBox(height: InfernalSpacing.lg),
                Text(
                  'REQUEST SENT',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: InfernalColors.success,
                    letterSpacing: 4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: InfernalSpacing.md),
                Text(
                  'Your sanctum request has been queued for review by the Arch-Admin.\n\nOnce approved, an invitation code and claim link will be provided to you by the Arch-Admin.',
                  style: const TextStyle(color: InfernalColors.textMuted, height: 1.4),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: InfernalSpacing.xl),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: InfernalColors.success),
                    onPressed: () => context.go(AppRoutes.login),
                    child: const Text('RETURN TO LOGIN'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: InfernalColors.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(InfernalSpacing.xl),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Glowing Icon
                NeonPlate(
                  color: _isClaimMode ? InfernalColors.success : InfernalColors.arcane,
                  padding: const EdgeInsets.all(InfernalSpacing.lg),
                  child: Icon(
                    _isClaimMode ? Icons.key_outlined : Icons.app_registration,
                    color: _isClaimMode ? InfernalColors.success : InfernalColors.arcane,
                    size: 48,
                  ),
                ),
                const SizedBox(height: InfernalSpacing.lg),

                // Titles
                Text(
                  _isClaimMode ? 'CLAIM YOUR SANCTUM' : 'REQUEST NEW SANCTUM',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    letterSpacing: 4,
                    color: _isClaimMode ? InfernalColors.success : InfernalColors.arcane,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: InfernalSpacing.xs),
                Text(
                  _isClaimMode
                      ? 'SET YOUR PASSWORD TO FINALIZE REGISTRATION'
                      : 'SUBMIT DETAILS FOR SHOP OWNER APPROVAL',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: InfernalColors.textMuted,
                    letterSpacing: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: InfernalSpacing.md),
                NeonDivider(
                  blurRadius: 15,
                  thickness: 0.5,
                  color: _isClaimMode ? InfernalColors.success : InfernalColors.arcane,
                ),
                const SizedBox(height: InfernalSpacing.lg),

                // Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Shop Details Header
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: InfernalSpacing.sm),
                          child: Text(
                            'SHOP DETAILS',
                            style: TextStyle(
                              color: InfernalColors.textSecondary,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _shopNameController,
                        enabled: !_isClaimMode,
                        decoration: const InputDecoration(
                          labelText: 'Shop Name',
                          prefixIcon: Icon(Icons.storefront),
                        ),
                        style: const TextStyle(color: InfernalColors.textPrimary),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Shop name required'
                            : null,
                      ),
                      const SizedBox(height: InfernalSpacing.md),
                      TextFormField(
                        controller: _shopIdController,
                        enabled: !_isClaimMode,
                        decoration: const InputDecoration(
                          labelText: 'Shop Code (Workspace ID)',
                          prefixIcon: Icon(Icons.link),
                          helperText: 'Lowercase letters, numbers, and dashes only.',
                          helperStyle: TextStyle(color: InfernalColors.textMuted, fontSize: 11),
                        ),
                        style: const TextStyle(color: InfernalColors.textPrimary),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Shop code required';
                          }
                          final regex = RegExp(r'^[a-z0-9\-]+$');
                          if (!regex.hasMatch(value)) {
                            return 'Use lowercase, numbers, and dashes only';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: InfernalSpacing.lg),

                      // Admin Details Header
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: InfernalSpacing.sm),
                          child: Text(
                            'OWNER DETAILS',
                            style: TextStyle(
                              color: InfernalColors.textSecondary,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _emailController,
                        enabled: !_isClaimMode,
                        decoration: const InputDecoration(
                          labelText: 'Owner Email',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        style: const TextStyle(color: InfernalColors.textPrimary),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email required';
                          }
                          if (!value.contains('@')) {
                            return 'Invalid email format';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: InfernalSpacing.md),
                      TextFormField(
                        controller: _displayNameController,
                        decoration: const InputDecoration(
                          labelText: 'Owner Display Name',
                          prefixIcon: Icon(Icons.badge_outlined),
                        ),
                        style: const TextStyle(color: InfernalColors.textPrimary),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Display name required'
                            : null,
                      ),
                      const SizedBox(height: InfernalSpacing.md),
                      if (_isClaimMode) ...[
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Set Password',
                            prefixIcon: Icon(Icons.lock_outline),
                          ),
                          style: const TextStyle(color: InfernalColors.textPrimary),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password required';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: InfernalSpacing.xl),
                      ],

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isClaimMode ? InfernalColors.success : InfernalColors.arcane,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: _isLoading ? null : _handleSubmit,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: InfernalSpacing.sm,
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(_isClaimMode ? 'INITIALIZE SHOP' : 'SUBMIT REQUEST'),
                          ),
                        ),
                      ),
                      const SizedBox(height: InfernalSpacing.md),

                      // Back to Login Link
                      TextButton(
                        onPressed: _isLoading
                            ? null
                            : () => context.go(AppRoutes.login),
                        style: TextButton.styleFrom(
                          foregroundColor: InfernalColors.textMuted,
                        ),
                        child: const Text('BACK TO LOGIN'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
