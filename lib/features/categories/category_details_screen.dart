import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_meetapp/data/models/category_model.dart';
import 'package:qr_meetapp/core/constants/app_styles.dart';
import 'package:qr_meetapp/core/constants/app_colors.dart';
import 'package:qr_meetapp/state/appointment_state.dart';
import 'package:qr_meetapp/features/home/widgets/upcoming_appointments.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final AppointmentCategory category;

  const CategoryDetailsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppointmentState>();

    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: category.color.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(category.icon, color: category.color, size: 32),
                ),
                const SizedBox(width: 16),
                Text(category.name, style: AppStyles.heading3),
              ],
            ),
            const SizedBox(height: 16),
            Text('About ${category.name}', style: AppStyles.heading5),
            const SizedBox(height: 8),
            Text(
              'Discover providers and appointments in ${category.name}.',
              style: AppStyles.bodyMedium.copyWith(color: AppColors.grey700),
            ),
            const SizedBox(height: 24),
            Text('Upcoming in this category', style: AppStyles.heading6),
            const SizedBox(height: 8),
            SizedBox(
              height: 180,
              child: UpcomingAppointments(
                appointments: state.appointments
                    .where((a) => a.categoryId == category.id)
                    .toList(),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}