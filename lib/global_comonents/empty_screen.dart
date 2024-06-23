import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState(
      {key,
      this.height,
      required this.image,
      required this.text,
      this.center = false});
  final String image;
  final String text;
  final double? height;
  final bool center;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? MediaQuery.sizeOf(context).height * 0.7,
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image),
          const SizedBox(
            height: 10,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          if (center)
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.2,
            )
        ],
      ),
    );
  }
}
