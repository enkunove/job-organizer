import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task/core/themes/theme_provider.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool notificationsEnabled;
  late bool isDarkTheme;
  late String email;

  void toggleNotifications(bool value) {
    setState(() {
      notificationsEnabled = value;
    });
  }

  void toggleTheme(bool value) {
    setState(() {
      isDarkTheme = value;
      context.read<ThemeProvider>().toggleTheme();
    });
  }

  @override
  void initState() {
    super.initState();
    notificationsEnabled = true;
    isDarkTheme = context.read<ThemeProvider>().isDarkMode;
    email = FirebaseAuth.instance.currentUser!.email!;
  }

  @override
  Widget build(BuildContext context) {
    isDarkTheme = context.watch<ThemeProvider>().isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            value: notificationsEnabled,
            onChanged: toggleNotifications,
            title: const Text('Уведомления'),
            subtitle: const Text('Получать пуш-уведомления'),
          ),
          SwitchListTile(
            value: isDarkTheme,
            onChanged: toggleTheme,
            title: const Text('Темная тема'),
          ),
          ListTile(
            trailing: const Icon(Icons.update),
            title: const Text('Восстановить задачи'),
            onTap: ()=> context.router.replacePath('/archive/tasks'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Выйти'),
            subtitle: Text(email),
            onTap: () => context.router.replacePath('/login')
          ),
        ],
      ),
    );
  }
}
