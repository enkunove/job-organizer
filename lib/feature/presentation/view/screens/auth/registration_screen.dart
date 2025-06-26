import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task/core/service_locator.dart';
import '../../../viewmodels/registration_screen_viewmodel.dart';

@RoutePage()
class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChangeNotifierProvider(
      create: (_) => InjectionContainer.sl<RegistrationScreenViewmodel>(),
      child: Consumer<RegistrationScreenViewmodel>(
        builder: (context, viewModel, _) {
          return Scaffold(
            backgroundColor: theme.colorScheme.background,
            body: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 4,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person_add_alt_1, size: 72, color: theme.colorScheme.primary),
                    const SizedBox(height: 24),
                    Text(
                      'Регистрация',
                      style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Создайте новый аккаунт',
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
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: FilledButton(
                        onPressed: viewModel.isLoading ? null : () => viewModel.register(context),
                        child: viewModel.isLoading
                            ? const CircularProgressIndicator(strokeWidth: 2, color: Colors.white)
                            : const Text('Зарегистрироваться'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => context.router.replacePath("/login"),
                      child: const Text('Уже есть аккаунт? Войти'),
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
