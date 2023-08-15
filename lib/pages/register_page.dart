import 'package:chatapp/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/my_button.dart';
import '../components/my_text_field.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //function

  void signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your passwords do not match!'),
        ),
      );
      return;
    }
    // get auth service
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signUpWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Icon(
                  Icons.message,
                  size: 100,
                  color: Colors.grey[800],
                ),

                //Welcome Back Message
                const SizedBox(height: 50),
                const Text(
                  "Create an account here!",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),

                //Email Textfield
                const SizedBox(height: 25),
                MyTextField(
                    controller: emailController,
                    hintText: 'Put your email here...',
                    obscureText: false),

                //Password Textfield
                const SizedBox(height: 15),
                MyTextField(
                    controller: passwordController,
                    hintText: 'Enter your password here...',
                    obscureText: true),

                //Confirm Password Textfield
                const SizedBox(height: 15),
                MyTextField(
                    controller: confirmPasswordController,
                    hintText: 'Enter your password again...',
                    obscureText: true),

                //Sign In Button
                const SizedBox(height: 25),
                MyButton(onTap: signUp, text: 'Sign Up!'),

                //Not yet a member text
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already a member?'),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login Here!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
