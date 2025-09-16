import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_meetapp/core/widgets/cards/appointment_card.dart';
import 'package:qr_meetapp/data/models/appointment_model.dart';

// Horizontal list of upcoming appointment cards
class UpcomingAppointments extends StatelessWidget {
  // List of appointment data to display
  final List<AppointmentModel> appointments;

  // Constructor with required appointments list
  const UpcomingAppointments({
    super.key,
    required this.appointments,
  });

  @override
  Widget build(BuildContext context) {
    // Fixed height container for horizontal scrolling
    return SizedBox(
      height: 180,
      // Horizontal list builder for efficient rendering
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Horizontal scrolling
        padding: const EdgeInsets.symmetric(horizontal: 16.0), // Horizontal padding
        itemCount: appointments.length, // Number of items
        itemBuilder: (context, index) {
          // Create appointment card for each item
          return Padding(
            // Right padding between cards
            padding: const EdgeInsets.only(right: 16.0),
            // Appointment card widget with navigation to details
            child: AppointmentCard(
              appointment: appointments[index],
              onTap: () => context.push('/home/appointments/${appointments[index].id}'),
            ),
          );
        },
      ),
    );
  }
}