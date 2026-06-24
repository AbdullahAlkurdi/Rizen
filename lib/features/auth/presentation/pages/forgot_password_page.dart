import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../cubit/auth_cubit.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendResetLink() {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    context.read<AuthCubit>().sendPasswordResetEmail(
      _emailController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        setState(() => _isLoading = false);
        if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (_emailController.text.isNotEmpty && state is! AuthError) {
          setState(() => _emailSent = true);
        }
      },
      builder: (context, state) {
        return RizenScaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(PhosphorIconsBold.arrowLeft),
              onPressed: () => context.pop(),
            ),
            title: const Text('Reset Password'),
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: 12),
                Text(
                  'Recover your account',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  _emailSent
                      ? 'Check your inbox for a password reset link.'
                      : 'Enter the email associated with your Rizen account.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 32),
                if (!_emailSent) ...[
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter your email';
                      }
                      if (!value.contains('@')) return 'Enter a valid email';
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  RizenButton(
                    label: 'Send Reset Link',
                    isLoading: _isLoading,
                    onPressed: _sendResetLink,
                  ),
                ] else
                  RizenButton(
                    label: 'Back to Sign In',
                    onPressed: () => context.pop(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
