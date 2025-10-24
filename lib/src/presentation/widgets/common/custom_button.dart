import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;
  final bool isExpanded;
  final IconData? icon;
  final Color textColor;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    required this.label,
    required this.color,
    required this.onPressed,
    this.isExpanded = false,
    this.icon,
    this.textColor = Colors.white,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    Widget button = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(
          vertical: height != null ? 0 : 14,
          horizontal: 16,
        ),
      ),
      onPressed: onPressed,
      child: SizedBox(
        height: height,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: textColor),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );

    if (width != null) {
      button = SizedBox(
        width: width,
        child: button,
      );
    }

    if (isExpanded) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: button,
        ),
      );
    }

    return button;
  }
}
