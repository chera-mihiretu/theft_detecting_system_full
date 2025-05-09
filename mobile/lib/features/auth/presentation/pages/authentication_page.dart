import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:theft_detecting_system/features/auth/presentation/providers/auth_provider.dart';
import 'package:theft_detecting_system/features/home/presentation/pages/home_page.dart';

class AuthenticationPage extends StatelessWidget {
  static final String routeName = '/authentication';
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        // Navigate to home if already authenticated
        if (authProvider.isAuthenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, HomePage.routeName);
          });
        }
        
        return _buildAuthUI(context, authProvider);
      },
    );
  }

  Widget _buildAuthUI(BuildContext context, AuthProvider authProvider) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(20),
            borderRadius: BorderRadius.circular(40),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image with smaller size and border radius
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset('assets/logo.png', height: 60),
              ),
              const SizedBox(height: 16),
              // Logo text
              const Text(
                'Theft Detecting System',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              // Grey information text
              const Text(
                'Sign in with your Google account to start monitoring your space',
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Blue gradient button with Google SVG logo and text
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                onPressed: authProvider.isLoading ? null : () async {
                  await authProvider.signInWithGoogle();
                  if (authProvider.isAuthenticated) {
                    Navigator.pushReplacementNamed(context, HomePage.routeName);
                  }
                },
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4285F4), Color(0xFF3367D6)],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/google.svg',
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(width: 8),
                        authProvider.isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Continue with google',
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Error message
              if (authProvider.error != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.withOpacity(0.3)),
                  ),
                  child: Text(
                    authProvider.error!,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
              // Grey RichText with linked text for Terms and privacy policy
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  children: [
                    const TextSpan(text: 'By signing in, you agree to our '),
                    TextSpan(
                      text: 'Terms',
                      style: const TextStyle(color: Colors.blue),
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              // Add Terms tap functionality here.
                            },
                    ),
                    const TextSpan(text: ' '),
                    TextSpan(
                      text: 'privacy policy',
                      style: const TextStyle(color: Colors.blue),
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              // Add privacy policy tap functionality here.
                            },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
