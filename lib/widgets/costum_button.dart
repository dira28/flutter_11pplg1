import 'package:flutter/material.dart';

class reusableButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const reusableButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        // Jika loading, tombol didisable (null), jika tidak, gunakan fungsi onPressed
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2, 
                  color: Colors.white
                ),
              )
            : Text(
                text, 
                style: const TextStyle(fontSize: 16)
              ),
      ),
    );
  }
}