import 'package:flutter/material.dart';

class TitleContent extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const TitleContent({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 20, color: Colors.white70),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            'Lihat Semua',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
