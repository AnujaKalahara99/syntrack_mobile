import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final bool readOnly;
  final Color backgroundColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Widget? prefixIcon;

  const CustomSearchBar({
    super.key,
    this.hintText = 'Where to go next?',
    this.onTap,
    this.controller,
    this.onChanged,
    this.readOnly = false,
    this.backgroundColor = const Color(0xFFF5F5F5),
    this.borderRadius = 20.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.prefixIcon = const Icon(Icons.search, color: Colors.grey),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onTap: onTap,
        readOnly: readOnly,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: prefixIcon,
          border: InputBorder.none,
          contentPadding: padding,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
