import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/tokens.dart';
import '../../../shared/presentation/widgets/neon_plate.dart';
import '../../../shared/presentation/widgets/neon_divider.dart';
import '../../../shared/util/app_version_helper.dart';
import '../domain/auth_service.dart';
import '../domain/auth_state.dart';

/// Login page implementing local authentication
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  final _focusNode = FocusNode();
  int _tapCount = 0;

  @override
  void dispose() {
    _focusNode.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      ref
          .read(authServiceProvider.notifier)
          .login(_usernameController.text, _passwordController.text);
    }
  }

  void _seedAdmin() {
    ref.read(authServiceProvider.notifier).seedAdmin().then((_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Admin user created (admin/adminadmin). Please login.'),
            backgroundColor: InfernalColors.success,
          ),
        );
      }
    });
  }

  void _handleKeyPress(KeyEvent event) {
    if (event is KeyDownEvent) {
      final isControlPressed = HardwareKeyboard.instance.isControlPressed;
      final isShiftPressed = HardwareKeyboard.instance.isShiftPressed;
      if (isControlPressed && isShiftPressed && event.logicalKey == LogicalKeyboardKey.keyR) {
        resetApp();
      }
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
            error: (message) {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Login failed: $message'),
                    backgroundColor: InfernalColors.error,
                  ),
                );
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
              content: Text('Login failed: ${error.toString()}'),
              backgroundColor: InfernalColors.error,
            ),
          );
        },
        loading: () {
          setState(() => _isLoading = true);
        },
      );
    });

    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: _handleKeyPress,
      child: Scaffold(
        backgroundColor: InfernalColors.background,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(InfernalSpacing.xl),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo with Glow (with 5-tap hidden reset)
                  GestureDetector(
                    onTap: () {
                      _tapCount++;
                      if (_tapCount >= 5) {
                        _tapCount = 0;
                        resetApp();
                      }
                    },
                    child: NeonPlate(
                      color: InfernalColors.blood,
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset(
                        'assets/logo.png',
                        width: 160,
                        height: 160,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: InfernalSpacing.xl),

                  // Title
                  Text(
                    'INFERNAL INK',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      letterSpacing: 8,
                      color: InfernalColors.blood,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '& STEEL SUITE',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      letterSpacing: 4,
                      color: InfernalColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: InfernalSpacing.md),
                  const NeonDivider(blurRadius: 20, thickness: 0.5),
                  const SizedBox(height: InfernalSpacing.md),
                  Text(
                    'ENTER THE SANCTUM',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: InfernalColors.textMuted,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: InfernalSpacing.xxl),

                  // Login form
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            labelText: 'Email / Username',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Email or Username required'
                              : null,
                          onFieldSubmitted: (_) => _login(),
                        ),
                        const SizedBox(height: InfernalSpacing.md),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock_outline),
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Password required'
                              : null,
                          onFieldSubmitted: (_) => _login(),
                        ),
                        const SizedBox(height: InfernalSpacing.xl),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _login,
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
                                        color: InfernalColors.textPrimary,
                                      ),
                                    )
                                  : const Text('ENTER'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: InfernalSpacing.lg),
                  TextButton(
                    onPressed: _isLoading ? null : () => context.go(AppRoutes.register),
                    style: TextButton.styleFrom(
                      foregroundColor: InfernalColors.arcane,
                    ),
                    child: const Text('CREATE NEW SANCTUM (REGISTER SHOP)'),
                  ),

                  const SizedBox(height: InfernalSpacing.xl),

                  // Dev / Seed tools
                  TextButton.icon(
                    onPressed: _isLoading ? null : _seedAdmin,
                    icon: const Icon(Icons.build, size: 16),
                    label: const Text('Initialize Demo Admin'),
                    style: TextButton.styleFrom(
                      foregroundColor: InfernalColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
