import 'package:flutter/material.dart';

class BubbleMarker extends StatelessWidget {
  final String categoryIconUrl;
  final String description;
  final void Function() onTap;

  const BubbleMarker({
    super.key,
    required this.categoryIconUrl,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRect( // Clip overflow if necessary
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              categoryIconUrl,
              width: 40,
              height: 40,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.location_on,
                color: Colors.blue,
                size: 40,
              ),
            ),
            Flexible( // Make description fit within constraints
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  description,
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis, // Avoid overflow
                  maxLines: 1, // Limit to one line if space is constrained
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
