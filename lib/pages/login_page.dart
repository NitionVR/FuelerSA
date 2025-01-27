import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_styles.dart';
import '../services/auth_service.dart';
import '../viewmodels/login_view_model.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/auth_button.dart';
import '../utils/dialog_utils.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(context.read<AuthService>()),
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
                _buildLoginForm(),
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
        'Welcome Back',
        style: TextStyle(color: AppStyles.orangeAccent),
      ),
      elevation: 0,
    );
  }

  Widget _buildHeader() {
    return const Column(
      children: [
        SizedBox(height: 40),
        Icon(
          Icons.lock_outline,
          size: 80,
          color: AppStyles.orangeAccent,
        ),
        SizedBox(height: 20),
        Text(
          'Login to continue',
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

  Widget _buildLoginForm() {
    return Column(
      children: [
        CustomTextField(
          controller: _emailController,
          label: 'Email',
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: _passwordController,
          label: 'Password',
          isPassword: true,
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Consumer<LoginViewModel>(
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
              _buildLoginButton(viewModel),
            const SizedBox(height: 16),
            _buildGoogleSignInButton(viewModel),
            const SizedBox(height: 16),
            _buildSignUpLink(),
          ],
        );
      },
    );
  }

  Widget _buildLoginButton(LoginViewModel viewModel) {
    return AuthButton(
      onPressed: () async {
        final success = await viewModel.signInWithEmail(
          _emailController.text,
          _passwordController.text,
        );
        if (!success && mounted) {
          DialogUtils.showErrorSnackBar(
            context,
            'Login failed. Check your credentials.',
          );
        }
      },
      text: 'Login',
    );
  }

  Widget _buildGoogleSignInButton(LoginViewModel viewModel) {
    return AuthButton(
      onPressed: () async {
        final success = await viewModel.signInWithGoogle();
        if (!success && mounted) {
          DialogUtils.showErrorSnackBar(
            context,
            'Google sign-in failed.',
          );
        }
      },
      text: 'Sign in with Google',
      backgroundColor: Colors.white,
      icon: Icons.g_mobiledata,
    );
  }

  Widget _buildSignUpLink() {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignupPage()),
        );
      },
      child: const Text(
        "Don't have an account? Sign Up",
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