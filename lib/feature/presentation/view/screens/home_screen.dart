import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_task/feature/presentation/view/widgets/theme_toggle_widget.dart';

import '../../../../core/routing/app_routing.gr.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.createUserWithEmailAndPassword(email: 'enkunove@gmail.com', password: '1234');
              context.router.replacePath('/tasks');
            },
            child: Text("Go to tasks"),
          ),
          ThemeToggleWidget(),
        ],
      ),
    );
  }
}
