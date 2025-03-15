import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color bgColor;
  final Color textColor;
  final bool isDisabled;

  const PrimaryButton({
    required this.text,
    required this.onPressed,
    this.bgColor = const Color(0xFF070710),
    this.textColor = Colors.white,
    this.isDisabled = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(50),
        backgroundColor: bgColor,
        foregroundColor: Colors.transparent,
        disabledBackgroundColor: Color(0xFF1E1D2B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor.withOpacity(isDisabled ? 0.5 : 1),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
