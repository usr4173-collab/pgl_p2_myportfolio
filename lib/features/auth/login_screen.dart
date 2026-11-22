import 'package:flutter/material.dart';

import 'package:pgl_p2_myportfolio/core/constants/app_colors.dart';
import 'package:pgl_p2_myportfolio/core/constants/app_sizes.dart';
import 'package:pgl_p2_myportfolio/core/constants/app_strings.dart';
import 'package:pgl_p2_myportfolio/core/widgets/drawer_menu.dart';
import 'package:pgl_p2_myportfolio/features/auth/widgets/auth_input_decoration.dart';

/// Login screen: text inputs for email and password.
/// StatefulWidget because it owns the TextEditingControllers.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Later we read .text to send them to POST /users/login
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.loginTitle)),
      drawer: const DrawerMenu(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.spacingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.login,
              color: AppColors.primary,
              size: AppSizes.welcomeIcon,
            ),
            const SizedBox(height: AppSizes.spacingLarge),

            // Email
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              textInputAction: TextInputAction.next,
              decoration: authInputDecoration(AppStrings.email, Icons.email),
            ),
            const SizedBox(height: AppSizes.spacing),

            // Password (hidden characters)
            TextField(
              controller: _passwordController,
              obscureText: true,
              autocorrect: false,
              enableSuggestions: false,
              textInputAction: TextInputAction.done,
              decoration: authInputDecoration(AppStrings.password, Icons.lock),
            ),
          ],
        ),
      ),
    );
  }
}
