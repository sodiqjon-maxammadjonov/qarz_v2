import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qarz_v2/src/app/presentation/screens/main/main_screen.dart';
import 'package:qarz_v2/src/app/utils/widgets/snackbar/floating_snackbar.dart';
import 'package:qarz_v2/src/app/utils/widgets/text/my_text_field.dart';

import '../../../../core/theme/app_theme.dart';
import '../../bloc/login/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Tizimga kirish')),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.06),
            child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) async {
                if (state is LoginLoadingState) {
                  if (mounted) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                } else if (state is LoginSuccessState) {
                  FloatingSnackbar.showSuccess(context: context, message: state.message);
                  if (mounted) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                        (Route<dynamic> route) => false,
                  );

                } else if (state is LoginErrorState) {
                  FloatingSnackbar.showError(context: context, message: state.message);
                  if (mounted) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height * 0.25),
                  MyTextField(
                    controller: usernameController,
                    label: 'Username',
                    hintText: 'Username kiriting',
                    prefixIcon: const Icon(Icons.person),
                  ),
                  SizedBox(height: height * 0.02),
                  MyTextField(
                    controller: passwordController,
                    label: 'Parol',
                    hintText: 'Parol kiriting',
                    prefixIcon: const Icon(Icons.lock),
                    isPassword: true,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        FloatingSnackbar.showInfo(context: context, message: 'Eslashga urunib koring!');
                      },
                      child: Text('Username yoki parolni unutdingizmi?'),
                    ),
                  ),
                  SizedBox(height: height * 0.1),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed:
                              isLoading
                                  ? null
                                  : () {
                                    context.read<LoginBloc>().add(
                                      LoginEnteringEvent(
                                        username: usernameController.text,
                                        password: passwordController.text,
                                      ),
                                    );
                                  },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child:
                              isLoading
                                  ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                  : const Text(
                                    "Kirish",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
