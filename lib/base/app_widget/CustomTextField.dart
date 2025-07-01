import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';

  class CustomTextField extends StatefulWidget {
    final String label;
    final bool isPassword;
    final TextEditingController? controller; // Optional controller
    final String? Function(String?)? validator; // Optional validator

    const CustomTextField({
      Key? key,
      required this.label,
      required this.isPassword,
      this.controller,
      this.validator,
    }) : super(key: key);

    @override
    State<CustomTextField> createState() => _CustomTextFieldState();
  }

  class _CustomTextFieldState extends State<CustomTextField> {
    bool _obscureText = true;

    @override
    Widget build(BuildContext context) {
      return TextFormField( // Changed to TextFormField to support validation
        controller: widget.controller,
        obscureText: widget.isPassword && _obscureText,
        validator: widget.validator,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: const TextStyle(color: Colors.black54, fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.purple),
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
        ),
      );
    }
  }