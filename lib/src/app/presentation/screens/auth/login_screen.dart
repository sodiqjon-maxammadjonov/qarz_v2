import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../utils/widgets/text/my_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Bu yerda aslida login logikangiz bo'ladi
    // Masalan: authService.login(_loginController.text, _passwordController.text)

    // Simulyatsiya uchun kechikish
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;

        // Test uchun, aslida API javobiga qarab xatolik chiqarish kerak
        if (_loginController.text.isEmpty || _passwordController.text.isEmpty) {
          _errorMessage = "Login yoki parol noto'g'ri";
        } else {
          // Muvaffaqiyatli login
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Muvaffaqiyatli kirildi")),
          );
        }
      });
    });
  }

  void _forgotPassword() {
    // Parolni tiklash ekraniga o'tish
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Parolni tiklash sahifasiga o'tilmoqda...")),
    );
    // Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(isSmallScreen ? 16.0 : 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo yoki app nomi
                  Icon(
                    Icons.lock_outline_rounded,
                    size: isSmallScreen ? 64 : 80,
                    color: AppTheme.primary,
                  ),

                  SizedBox(height: isSmallScreen ? 24 : 32),

                  // Sarlavha
                  Text(
                    "Tizimga kirish",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 24 : 28,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textColor,
                    ),
                  ),

                  SizedBox(height: 8),

                  // Izoh
                  Text(
                    "Hisobingizga kirish uchun ma'lumotlarni kiriting",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 14 : 16,
                      color: AppTheme.textColor.withOpacity(0.7),
                    ),
                  ),

                  SizedBox(height: isSmallScreen ? 24 : 32),

                  // Xatolik xabari
                  if (_errorMessage != null)
                    Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: AppTheme.error.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppTheme.error.withOpacity(0.3)),
                      ),
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(
                          color: AppTheme.error,
                          fontSize: 14,
                        ),
                      ),
                    ),

                  // Login maydoni
                  MyTextField(
                    controller: _loginController,
                    label: "Login",
                    hintText: "Email yoki telefon raqamingiz",
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icon(Icons.person_outline, color: AppTheme.primary.withOpacity(0.5)),
                    textInputAction: TextInputAction.next,
                  ),

                  SizedBox(height: 16),

                  // Parol maydoni
                  MyTextField(
                    controller: _passwordController,
                    label: "Parol",
                    hintText: "Parolingizni kiriting",
                    isPassword: true,
                    prefixIcon: Icon(Icons.lock_outline, color: AppTheme.primary.withOpacity(0.5)),
                    textInputAction: TextInputAction.done,
                  ),

                  SizedBox(height: 12),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _forgotPassword,
                      child: Text(
                        "Parolni unutdingizmi?",
                        style: TextStyle(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 24),

                  ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 1,
                    ),
                    child: _isLoading
                        ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                        : Text(
                      "Kirish",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: isSmallScreen ? 36 : 48),

                  // Yordam
                  Text(
                    "Texnik yordam: +998 XX XXX XX XX",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.textColor.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}