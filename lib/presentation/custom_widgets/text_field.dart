import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final String labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPassword;
  final bool isConfirmPassword;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.obscureText,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.isConfirmPassword = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isvisible = true;
  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return '${widget.labelText} is required';
    }

    if (widget.isPassword && value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (widget.isConfirmPassword && value != widget.controller.text) {
      return 'Passwords do not match';
    }

    if (widget.isPassword && !RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).{6,}$').hasMatch(value)) {
      return 'Password must contain at least one letter and one number';
    }

    if (widget.isPassword && !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    if (widget.labelText == 'Email Id' && !RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value)) {
        return 'Invalid Email Id';
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword ? isvisible : false,
        decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: const TextStyle(color: Color(0xFF24786D)),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isvisible = !isvisible;
                      });
                    },
                    icon: Icon(
                        isvisible ? Icons.visibility_off : Icons.visibility),
                  )
                : null),
                validator: _validateInput,
      ),
    );
  }
}
