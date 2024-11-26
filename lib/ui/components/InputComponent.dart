import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_app/ui/components/extentions/color_extention.dart';

class InputComponent extends StatelessWidget {
  bool isObscuretext;

  InputComponent({
    super.key,
    required this.controller,
    this.isObscuretext = false,
    this.onChanged,
  });

  final TextEditingController controller;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      obscureText: isObscuretext,
      controller: controller,
      decoration: InputDecoration(
        prefixIconColor: Colors.grey,
        prefixIcon: const Icon(CupertinoIcons.search),
        hintText: 'Search for entire shop',
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        filled: true,
        fillColor: AppColors.backgroundColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
