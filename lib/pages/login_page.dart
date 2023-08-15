import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/my_text_field.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text controllers
  final emailController1 = TextEditingController();
  final passwordController2 = TextEditingController();

  // function
  void signIn() async {
    //get auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailandPassword(
        emailController1.text,
        passwordController2.text,
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
                  "Welcome back! Wanna chat?",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),

                //Email Textfield
                const SizedBox(height: 25),
                MyTextField(
                    controller: emailController1,
                    hintText: 'Put your email here...',
                    obscureText: false),

                //Password Textfield
                const SizedBox(height: 15),
                MyTextField(
                    controller: passwordController2,
                    hintText: 'Enter your password here...',
                    obscureText: true),

                //Sign In Button
                const SizedBox(height: 25),
                MyButton(onTap: signIn, text: 'Sign In!'),

                //Not yet a member text
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Not a member yet?'),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register Here!',
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
