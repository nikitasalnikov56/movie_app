import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({
    Key? key,
    required this.color,
    required this.icon,
    required this.text,
    required this.borderColor,
  }) : super(key: key);
  final Color color;
  final Color borderColor;
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            side: BorderSide(
              color: borderColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16),
        ),
        backgroundColor: MaterialStateProperty.all(
          color,
        ),
      ),
      onPressed: () {},
      icon: Icon(
        icon,
        color: const Color(0xFFFFFFFF),
      ),
      label: Text(
        text,
        style: const TextStyle(
          color: Color(0xFFFFFFFF),
        ),
      ),
    );
  }
}
