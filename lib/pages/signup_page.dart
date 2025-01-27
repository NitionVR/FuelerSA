import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fuel_price_tracker/services/auth_service.dart';

import '../constants/app_styles.dart';
import '../utils/dialog_utils.dart';
import '../viewmodels/signup_view_model.dart';
import '../widgets/auth_button.dart';
import '../widgets/custom_text_field.dart';

// lib/pages/signup_page.dart
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignupViewModel(context.read<AuthService>()),
      child: Scaffold(
        backgroundColor: AppStyles.darkBackground,
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),
                _buildSignupForm(),
                _buildButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppStyles.darkAppBar,
      title: const Text(
        'Create Account',
        style: TextStyle(color: AppStyles.orangeAccent),
      ),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppStyles.orangeAccent),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      children: [
        SizedBox(height: 40),
        Icon(
          Icons.person_add_outlined,
          size: 80,
          color: AppStyles.orangeAccent,
        ),
        SizedBox(height: 20),
        Text(
          'Join us today',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Fill in your details to create an account',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
        SizedBox(height: 40),
      ],
    );
  }

  Widget _buildSignupForm() {
    return Column(
      children: [
        CustomTextField(
          controller: _emailController,
          label: 'Email',
          prefixIcon: Icons.email_outlined,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: _passwordController,
          label: 'Password',
          isPassword: true,
          prefixIcon: Icons.lock_outline,
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Consumer<SignupViewModel>(
      builder: (context, viewModel, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            if (viewModel.isLoading)
              const Center(
                  child: CircularProgressIndicator(color: AppStyles.orangeAccent)
              )
            else
              _buildSignupButton(viewModel),
            const SizedBox(height: 20),
            _buildLoginLink(),
          ],
        );
      },
    );
  }

  Widget _buildSignupButton(SignupViewModel viewModel) {
    return AuthButton(
      onPressed: () async {
        final success = await viewModel.registerWithEmail(
          _emailController.text,
          _passwordController.text,
        );
        if (success) {
          DialogUtils.showSuccessSnackBar(
            context,
            'Account created successfully!',
          );
          Navigator.pop(context);
        } else {
          DialogUtils.showErrorSnackBar(
            context,
            'Registration failed. Please try again.',
          );
        }
      },
      text: 'Create Account',
    );
  }

  Widget _buildLoginLink() {
    return TextButton(
      onPressed: () => Navigator.pop(context),
      child: const Text(
        'Already have an account? Login',
        style: TextStyle(
          color: AppStyles.orangeAccent,
          fontSize: 16,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}