import 'package:flutter/material.dart';
import 'package:qr_meetapp/core/constants/app_colors.dart';

import 'package:qr_meetapp/core/constants/app_styles.dart';
import 'package:qr_meetapp/core/widgets/buttons/primary_button.dart';
import 'package:qr_meetapp/data/models/appointment_model.dart';
import 'package:qr_meetapp/features/booking/booking_view_model.dart';
import 'package:provider/provider.dart';

/// Host Acceptance Screen
class HostAcceptanceScreen extends StatelessWidget {
  final Appointment appointment;

  const HostAcceptanceScreen({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    final bookingViewModel = Provider.of<BookingViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Request'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Guest info
            Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/placeholders/user.png'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Doe', // Would come from appointment data
                        style: AppStyles.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Requested a meeting',
                        style: AppStyles.bodyLarge.copyWith(color: AppColors.grey600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // Meeting details
            Text(
              'Meeting Details',
              style: AppStyles.titleMedium,
            ),
            const SizedBox(height: 16),
            _buildDetailItem(Icons.title, 'Title', appointment.title),
            _buildDetailItem(Icons.description, 'Description', appointment.description),
            _buildDetailItem(Icons.calendar_today, 'Date', appointment.formattedDate),
            _buildDetailItem(Icons.access_time, 'Time', appointment.formattedTime),
            _buildDetailItem(Icons.location_on, 'Location', appointment.location),
            const SizedBox(height: 32),
            
            // Guest message
            Text(
              'Message from Guest',
              style: AppStyles.titleMedium,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.grey50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Looking forward to discussing the project details with you!',
                style: AppStyles.bodyMedium,
              ),
            ),
            const SizedBox(height: 32),
            
            // Action buttons
            if (bookingViewModel.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (appointment.status == 'pending')
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      onPressed: () {
                        bookingViewModel.updateAppointment(
                          appointment.copyWith(status: 'rejected'),
                        );
                      },
                      label: 'Decline',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: PrimaryButton(
                      onPressed: () {
                        bookingViewModel.updateAppointment(
                          appointment.copyWith(status: 'confirmed'),
                        );
                      },
                      label: 'Accept',
                    ),
                  ),
                ],
              )
            else
              Text(
                appointment.status == 'confirmed'
                    ? 'You have accepted this meeting'
                    : 'You have declined this meeting',
                style: AppStyles.bodyLarge.copyWith(
                  color: appointment.status == 'confirmed'
                      ? AppColors.success
                      : AppColors.error,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  style: AppStyles.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}