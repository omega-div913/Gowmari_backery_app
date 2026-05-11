import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _rememberMe = false;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              // 1. Logo
              Center(
                child: Image.asset(
                  'assets/images/rts_logo.png',
                  height: 100,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 100, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Welcome Back',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF001A4D)),
              ),
              const Text(
                'Sign in to continue to your ERP',
                style: TextStyle(fontSize: 15, color: Colors.blueGrey),
              ),
              const SizedBox(height: 30),

              // 2. The Login Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10)),
                  ],
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundColor: Color(0xFFF0F5FF),
                      child: Icon(Icons.person_outline, color: Color(0xFF1B59F8), size: 30),
                    ),
                    const SizedBox(height: 10),
                    const Text('Sign In', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const Text('Enter your credentials to access your account', 
                        textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.grey)),
                    const SizedBox(height: 30),

                    // Email Field
                    _inputLabel("Email Address"),
                    TextFormField(
                      decoration: _inputDecoration("Enter your email", Icons.email_outlined),
                    ),
                    const SizedBox(height: 20),

                    // Password Field
                    _inputLabel("Password"),
                    TextFormField(
                      obscureText: _obscureText,
                      decoration: _inputDecoration("Enter your password", Icons.lock_outline).copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(_obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                          onPressed: () => setState(() => _obscureText = !_obscureText),
                        ),
                      ),
                    ),

                    // Remember Me & Forgot Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(value: _rememberMe, onChanged: (v) => setState(() => _rememberMe = v!)),
                            const Text('Remember me', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                        TextButton(onPressed: () {}, child: const Text('Forgot Password?', style: TextStyle(fontSize: 12))),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Sign In Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0D47A1),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Sign In', style: TextStyle(color: Colors.white, fontSize: 16)),
                            SizedBox(width: 10),
                            Icon(Icons.arrow_forward, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text("Need help? Contact Support", style: TextStyle(color: Colors.blue, fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(vertical: 15),
    );
  }
}