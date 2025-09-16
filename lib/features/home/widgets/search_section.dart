import 'package:flutter/material.dart';
import 'package:qr_meetapp/core/widgets/inputs/app_text_field.dart';

// Search section component for home screen
class SearchSection extends StatelessWidget {
  // Callback when search text changes
  final ValueChanged<String> onSearch;
  // Callback when filter button is pressed
  final VoidCallback onFilterPressed;

  // Constructor with required callbacks
  const SearchSection({
    super.key,
    required this.onSearch,
    required this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Horizontal layout with search field and filter button
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: AppTextField(
              hintText: 'Search meetings, hosts...',
              prefixIcon: Icons.search,
              onChanged: onSearch,
            ),
          ),
          const SizedBox(width: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: ColoredBox(
              color: cs.primary,
              child: IconButton(
                icon: const Icon(Icons.tune, color: Colors.white),
                onPressed: onFilterPressed,
                tooltip: 'Filter',
              ),
            ),
          ),
        ],
      ),
    );
  }
}