import 'package:flutter/material.dart';
import 'package:qr_meetapp/core/constants/app_colors.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          // Expand search field to fill available space
          Expanded(
            // Custom text field for search
            child: AppTextField(
              hintText: 'Search meetings, hosts...',
              prefixIcon: Icons.search, // Search icon
              onChanged: onSearch, // Text change callback
            ),
          ),
          const SizedBox(width: 12), // Spacing between elements
          // Filter button container
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary, // Primary color background
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
            // Filter icon button
            child: IconButton(
              icon: const Icon(Icons.tune, color: Colors.white), // White icon
              onPressed: onFilterPressed, // Filter press callback
            ),
          ),
        ],
      ),
    );
  }
}