import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_meetapp/core/constants/app_colors.dart';
import 'package:qr_meetapp/core/constants/app_styles.dart';
import 'package:qr_meetapp/state/appointment_state.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  final String id;

  const AppointmentDetailsScreen({
    required this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppointmentState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Details'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: state.selectedAppointment?.id == id ? null : context.read<AppointmentState>().loadById(id),
        builder: (context, snapshot) {
          final appt = context.watch<AppointmentState>().selectedAppointment;
          if (appt == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(appt.title, style: AppStyles.heading3),
                const SizedBox(height: 8),
                Text(appt.description, style: AppStyles.bodyMedium.copyWith(color: AppColors.grey700)),
                const SizedBox(height: 16),
                Row(children: [
                  const Icon(Icons.calendar_today, size: 16),
                  const SizedBox(width: 6),
                  Text(appt.formattedDate),
                  const SizedBox(width: 16),
                  const Icon(Icons.access_time, size: 16),
                  const SizedBox(width: 6),
                  Text(appt.formattedTime),
                ]),
                const SizedBox(height: 16),
                Text('Location: ${appt.location}', style: AppStyles.bodyMedium),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reschedule coming soon')));
                        },
                        child: const Text('Reschedule'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          await context.read<AppointmentState>().cancel(id);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Appointment cancelled')));
                          }
                        },
                        child: const Text('Cancel'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
