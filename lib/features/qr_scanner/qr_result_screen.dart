import 'package:flutter/material.dart';
import 'package:qr_meetapp/core/constants/app_colors.dart';
import 'package:qr_meetapp/core/constants/app_styles.dart';
import 'package:qr_meetapp/core/widgets/buttons/primary_button.dart';
import 'package:qr_meetapp/data/models/qr_data_model.dart';

/// QR Result Screen
class QRResultScreen extends StatelessWidget {
  final QRDataModel qrData;

  const QRResultScreen({super.key, required this.qrData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scan Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Result icon
            Icon(
              qrData.isValid ? Icons.check_circle : Icons.error,
              size: 80,
              color: qrData.isValid ? AppColors.success : AppColors.error,
            ),
            const SizedBox(height: 24),
            
            // Result title
            Text(
              qrData.isValid ? 'Valid QR Code' : 'Invalid QR Code',
              style: AppStyles.headlineMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: qrData.isValid ? AppColors.success : AppColors.error,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            
            // Result details
            if (qrData.isValid) ...[
              _buildResultCard(qrData),
              const SizedBox(height: 32),
              PrimaryButton(
                onPressed: () {
                  // TODO: Handle action based on QR type
                  if (qrData.type == 'appointment') {
                    // Navigate to appointment details
                  } else if (qrData.type == 'user') {
                    // Navigate to user profile
                  }
                },
                label: qrData.type == 'appointment' 
                    ? 'View Appointment'
                    : 'View Profile',
              ),
            ] else 
              Text(
                'The scanned QR code is not recognized by this application.',
                style: AppStyles.bodyLarge.copyWith(color: AppColors.grey600),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(QRDataModel data) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (data.type == 'appointment')
            _buildDetailItem('Type', 'Appointment'),
          if (data.type == 'user')
            _buildDetailItem('Type', 'User Profile'),
          
          if (data.type == 'appointment') ...[
            _buildDetailItem('Title', data.title ?? ''),
            _buildDetailItem('Host ID', data.hostId ?? ''),
            _buildDetailItem('Time', data.meetingTime?.toString() ?? ''),
            _buildDetailItem('Location', data.location ?? ''),
          ],
          
          if (data.type == 'user') ...[
            _buildDetailItem('Host ID', data.hostId ?? ''),
            _buildDetailItem('Note', data.note ?? ''),
          ],
          
          _buildDetailItem('Scanned At', data.createdAt.toString()),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: AppStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.grey600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: AppStyles.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}