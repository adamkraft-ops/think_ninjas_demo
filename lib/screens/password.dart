import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../app_router.dart';
import '../utils/password_utils.dart';

class PasswordScreen extends StatefulWidget {
  final String route;

  const PasswordScreen({super.key, required this.route});

  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());
  final String _encodedPassword = base64Encode(utf8.encode('1503'));
  bool _isPasswordCorrect = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _validatePassword() {
    String inputPassword = _controllers.map((controller) => controller.text).join();
    bool isCorrect = PasswordUtils.validatePassword(inputPassword, _encodedPassword);

    if (isCorrect) {
      setState(() {
        _isPasswordCorrect = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Incorrect password, please try again.')),
      );
    }
  }

  void _navigate() {
    if (widget.route == 'waiter') {
      Navigator.pushNamed(context, AppRouter.waiterMain);
    } else if (widget.route == 'kitchen') {
      Navigator.pushNamed(context, AppRouter.kitchenMain);
    }
  }

  Widget _buildCodeBox(int index) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        maxLength: 1,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24),
        decoration: const InputDecoration(
          counterText: "",
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) {
          if (value.isNotEmpty && index < _focusNodes.length - 1) {
            _focusNodes[index + 1].requestFocus();
          }
          if (index == _focusNodes.length - 1 && value.isNotEmpty) {
            _validatePassword();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Screen'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, _buildCodeBox),
              ),
              if (_isPasswordCorrect)
                ElevatedButton(
                  onPressed: _navigate,
                  child: const Text('Next'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
