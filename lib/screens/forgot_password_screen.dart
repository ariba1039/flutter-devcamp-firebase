import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_devcamp_ui/utils/validation.dart';
import 'package:flutter_devcamp_ui/widgets/custom_button.dart';
import 'package:flutter_devcamp_ui/widgets/custom_text_form_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> resetPassword() async {
    if (formKey.currentState!.validate()) {
      try {
        await auth.sendPasswordResetEmail(
          email: emailController.text,
        );

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Reset Email Sent")));

        Navigator.of(context).pop();
      } on FirebaseAuthException {
        rethrow;
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Failed to Login")));
        }
      }
    }
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                const Text(
                  'Forgot Password',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 24,
                ),
                Image.asset('assets/gifs/firebase_flutter.gif'),
                const SizedBox(
                  height: 24,
                ),
                CustomTextFormField(
                  controller: emailController,
                  label: 'Email',
                  validator: (val) => Validators.emailValidation(val),
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomButton(
                  onPressed: resetPassword,
                  buttonText: 'Send Reset Email',
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
