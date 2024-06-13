import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'reset_password_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  Future<void> _sendForgotPasswordEmail() async {
    final email = _emailController.text;
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/api/v1/auth/forgot-password'),
      body: {'email': email},
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Check your email for the new password reset code')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResetPasswordPage(email: email)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response.body}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forgot Password')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendForgotPasswordEmail,
              child: Text('Send Email'),
            ),
          ],
        ),
      ),
    );
  }
}
