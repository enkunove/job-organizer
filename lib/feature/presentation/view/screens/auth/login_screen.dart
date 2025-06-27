import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task/core/service_locator.dart';
import '../../../viewmodels/login_screen_viewmodel.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChangeNotifierProvider(
      create: (_) => InjectionContainer.sl<LoginScreenViewmodel>(),
      child: Consumer<LoginScreenViewmodel>(
        builder: (context, viewModel, _) {
          return Scaffold(
            backgroundColor: theme.colorScheme.surface,
            body: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 4,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.lock_outline, size: 72, color: theme.colorScheme.primary),
                    const SizedBox(height: 24),
                    Text(
                      'Добро пожаловать',
                      style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Войдите, чтобы продолжить',
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
                    ),
                    const SizedBox(height: 32),
                    TextField(
                      onChanged: viewModel.onEmailChanged,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email_outlined),
                        border: const OutlineInputBorder(),
                        errorText: viewModel.emailError,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      obscureText: true,
                      onChanged: viewModel.onPasswordChanged,
                      decoration: InputDecoration(
                        labelText: 'Пароль',
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: const OutlineInputBorder(),
                        errorText: viewModel.passwordError,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CheckboxListTile(
                      value: viewModel.rememberMe,
                      onChanged: viewModel.setRememberMe,
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Запомнить меня'),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: FilledButton(
                        onPressed: viewModel.isLoading ? null : () => viewModel.login(context),
                        child: viewModel.isLoading
                            ? const CircularProgressIndicator(strokeWidth: 2, color: Colors.white)
                            : const Text('Войти'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => context.router.pushPath('/register'),
                      child: const Text('Нет аккаунта?'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
