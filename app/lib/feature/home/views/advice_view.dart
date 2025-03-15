import 'package:app/static/app_style.dart';
import 'package:flutter/material.dart';

class AdviceView extends StatelessWidget {
  final String advice;

  const AdviceView({required this.advice, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppStyle.secondaryColor1,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.lightbulb,
            color: AppStyle.textColor,
            size: 42,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              advice,
              style: const TextStyle(
                color: AppStyle.textColor,
                fontSize: 16,
              ),
              softWrap: true,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
