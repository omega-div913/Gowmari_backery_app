import 'package:flutter/material.dart';
import 'dashboard_screen.dart'; // Import for navigation

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
      // This hides the scrollbar on Windows/Web while keeping the page scrollable
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              child: Container(
                // Max width ensures it looks like a mobile app even on a wide monitor
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 1. PERFECT CIRCULAR LOGO BADGE
                    Container(
                      height: 140, // Height and Width must be identical
                      width: 140,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0), // Adjust padding to let logo breathe
                          child: Image.asset(
                            'assets/images/rts_logo.png',
                            fit: BoxFit.contain, // Protects your logo text from being cut
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // 2. WELCOME HEADER
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF001A4D),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Sign in to continue to your ERP',
                      style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                    ),
                    const SizedBox(height: 40),

                    // 3. LOGIN FORM CARD
                    Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 25,
                            offset: const Offset(0, 15),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 26,
                            backgroundColor: Color(0xFFF0F5FF),
                            child: Icon(Icons.person_outline, 
                                color: Color(0xFF1B59F8), size: 30),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'Sign In',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Enter your credentials to access your account',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                          const SizedBox(height: 35),

                          // Email Input
                          _buildLabel("Email Address"),
                          const SizedBox(height: 10),
                          TextFormField(
                            decoration: _buildInputDecoration(
                                "Enter your email", Icons.email_outlined),
                          ),
                          const SizedBox(height: 25),

                          // Password Input
                          _buildLabel("Password"),
                          const SizedBox(height: 10),
                          TextFormField(
                            obscureText: _obscureText,
                            decoration: _buildInputDecoration(
                                "Enter your password", Icons.lock_outline)
                                .copyWith(
                              suffixIcon: IconButton(
                                icon: Icon(_obscureText 
                                    ? Icons.visibility_outlined 
                                    : Icons.visibility_off_outlined, size: 22),
                                onPressed: () => setState(() => _obscureText = !_obscureText),
                              ),
                            ),
                          ),

                          // Remember & Forgot Password Row
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: Checkbox(
                                      value: _rememberMe,
                                      onChanged: (v) => setState(() => _rememberMe = v!),
                                      activeColor: const Color(0xFF1B59F8),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text('Remember me', style: TextStyle(fontSize: 13)),
                                ],
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text('Forgot Password?',
                                    style: TextStyle(fontSize: 13, color: Color(0xFF1B59F8), fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),

                          // ACTION BUTTON
                          SizedBox(
                            width: double.infinity,
                            height: 58,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0D47A1),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                elevation: 0,
                              ),
                              onPressed: () {
                                // Updated logic to navigate to Dashboard
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const DashboardScreen()),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text('Sign In', 
                                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                  SizedBox(width: 12),
                                  Icon(Icons.arrow_forward, color: Colors.white, size: 22),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),

                          // SUPPORT LINK
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              "Need help? Contact Support",
                              style: TextStyle(color: Color(0xFF1B59F8), fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Label Helper
  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF001A4D)),
      ),
    );
  }

  // Input Decoration Helper
  InputDecoration _buildInputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.grey, size: 22),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xFF1B59F8), width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 20),
    );
  }
}