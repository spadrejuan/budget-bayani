import 'package:flutter/material.dart';
class RoundButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  const RoundButton({super.key, required this.icon, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16),
        backgroundColor: const Color(0xff6A8595),
        foregroundColor: const Color(0xff2B4D5E),
      ),
      child: Icon(icon, color: const Color(0xffCCD3D9),),
    );
  }
}