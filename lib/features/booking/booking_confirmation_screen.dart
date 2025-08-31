import 'package:flutter/material.dart';
import 'package:qr_meetapp/core/constants/app_colors.dart';

import 'package:qr_meetapp/core/constants/app_styles.dart';
import 'package:qr_meetapp/core/widgets/buttons/primary_button.dart';
import 'package:qr_meetapp/data/models/appointment_model.dart';


/// Booking Confirmation Screen
class BookingConfirmationScreen extends StatelessWidget {
  final Appointment appointment;

  const BookingConfirmationScreen({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmed'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Success illustration
            const Icon(
              Icons.check_circle,
              size: 120,
              color: AppColors.success,
            ),
            const SizedBox(height: 24),
            
            // Title
            Text(
              'Booking Confirmed!',
              style: AppStyles.headlineMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            
            // Description
            Text(
              'Your meeting has been successfully scheduled. Details have been sent to your email.',
              style: AppStyles.bodyLarge.copyWith(color: AppColors.grey600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            
            // Appointment details card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.grey50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.grey200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailItem(Icons.person, 'Host', appointment.hostName),
                  const SizedBox(height: 12),
                  _buildDetailItem(Icons.title, 'Title', appointment.title),
                  const SizedBox(height: 12),
                  _buildDetailItem(Icons.calendar_today, 'Date', appointment.formattedDate),
                  const SizedBox(height: 12),
                  _buildDetailItem(Icons.access_time, 'Time', appointment.formattedTime),
                  const SizedBox(height: 12),
                  _buildDetailItem(Icons.location_on, 'Location', appointment.location),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            // QR Code section
            const Text(
              'Scan QR Code at Venue',
              style: AppStyles.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Placeholder for QR code
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.grey300),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Placeholder(
                fallbackHeight: 200,
                color: AppColors.primaryLight,
              ),
            ),
            const SizedBox(height: 24),
            
            // Action buttons
            PrimaryButton(
              onPressed: () {
                // TODO: Implement share booking
              },
              label: 'Share Booking',
            ),
            const SizedBox(height: 16),
            PrimaryButton(
              onPressed: () {
                // TODO: Implement add to calendar
              },
              label: 'Add to Calendar',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.grey600),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppStyles.bodySmall.copyWith(color: AppColors.grey600),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: AppStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}