import 'package:flutter/material.dart';

class PointsDisplay extends StatelessWidget {
  final int points;

  const PointsDisplay({required this.points, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'WolCoins',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Row(
          children: [
            Text(
              points.toString(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Icon(
              Icons.currency_bitcoin,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(width: 4),
          ],
        )

      ],
    );
  }
}