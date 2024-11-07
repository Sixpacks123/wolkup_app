import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../reporting/domain/report/report.dart';

class ReportDetailsBottomSheet extends ConsumerStatefulWidget {
  final Report report;

  const ReportDetailsBottomSheet({
    super.key,
    required this.report,
  });

  @override
  ConsumerState<ReportDetailsBottomSheet> createState() => _ReportDetailsBottomSheetState();
}

class _ReportDetailsBottomSheetState extends ConsumerState<ReportDetailsBottomSheet> {
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header Section
          Row(
            children: [
              //if (widget.report.categoryIconUrl != null)
                //Image.network(widget.report.categoryIconUrl!, height: 24),
              const SizedBox(width: 8),
              Text(
                widget.report.description,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Community Validation Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Logic for "Still There"
                  },
                  child: const Text("Still There"),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Logic for "No Longer There"
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[700],
                  ),
                  child: const Text("No Longer There"),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Comments Section
          Text(
            'Comments',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // Display a List of Comments
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: const [ //TODO Replace with actual comments
              ListTile(
                title: Text(
                  'User1',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  'This issue is still there!',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              ListTile(
                title: Text(
                  'User2',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  'I passed by yesterday, it seems resolved.',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Add Comment TextField
          TextField(
            controller: commentController,
            maxLines: 2,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[850],
              hintText: "Add a comment...",
              hintStyle: const TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed: () {
                  if (commentController.text.isNotEmpty) {
                    // Add the comment logic
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
