import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    this.hintText,
    this.labelText,
    this.errorText,
    this.autoFocus,
    this.enabled,
    this.validator,
    this.controller,
    this.focusNode,
    this.obscureListener,
    this.keyboardType,
    super.key,
    this.obscureText = false,
  });

  final String? hintText;
  final String? labelText;
  final String? errorText;
  final bool obscureText;
  final bool? autoFocus;
  final bool? enabled;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<bool>? obscureListener;
  final TextInputType? keyboardType;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late var obscureValue = widget.obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      controller: widget.controller,
      enabled: widget.enabled,
      obscureText: obscureValue,
      autofocus: widget.autoFocus ?? false,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        errorText: widget.errorText,
        border: InputBorder.none,
        suffixIcon: !widget.obscureText
            ? const SizedBox()
            : GestureDetector(
                child: Icon(
                  size: 18,
                  obscureValue ? Icons.lock : Icons.lock_open,
                ),
                onTap: () {
                  setState(() {
                    obscureValue = !obscureValue;
                    widget.obscureListener?.call(obscureValue);
                  });
                },
              ),
      ),
      validator: widget.validator,
    );
  }
}
