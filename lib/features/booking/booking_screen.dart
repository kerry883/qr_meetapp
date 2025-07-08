import 'package:flutter/material.dart';
import 'package:qr_meetapp/core/constants/app_colors.dart';
import 'package:qr_meetapp/core/theme/app_theme.dart';
import 'package:qr_meetapp/core/widgets/layout/section_header.dart';
import 'package:qr_meetapp/data/models/category_model.dart';

class BookingScreen extends StatelessWidget {
  final List<AppointmentCategory> categories = [
    AppointmentCategory(id: '1', name: 'Business', icon: Icons.business),
    AppointmentCategory(id: '2', name: 'Academic', icon: Icons.school),
    AppointmentCategory(id: '3', name: 'Health', icon: Icons.health_and_safety),
    AppointmentCategory(id: '4', name: 'Interview', icon: Icons.people),
    AppointmentCategory(id: '5', name: 'Casual', icon: Icons.coffee),
    AppointmentCategory(id: '6', name: 'Other', icon: Icons.more_horiz),
  ];

  BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Appointment', style: AppTheme.textTheme.displaySmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Select Appointment Type'),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.9,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return _buildCategoryCard(categories[index], context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(AppointmentCategory category, BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showBookingForm(context, category),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(category.icon, size: 32, color: AppColors.primary),
              const SizedBox(height: 8),
              Text(
                category.name,
                style: AppTheme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBookingForm(BuildContext context, AppointmentCategory category) {
    // Show booking form
  }
}
