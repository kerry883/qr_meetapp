import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:qr_meetapp/core/widgets/cards/appointment_card.dart';
import 'package:qr_meetapp/data/models/appointment_model.dart';
import 'package:qr_meetapp/state/appointment_state.dart';

class AppointmentsListScreen extends StatelessWidget {
  const AppointmentsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppointmentState>();
    final list = state.filteredAppointments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        centerTitle: true,
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : list.isEmpty
              ? const Center(child: Text('No appointments yet'))
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: list.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final appt = list[index];
                    return AppointmentCard(
                      appointment: appt,
                      onTap: () {
                        context.push('/home/appointments/${appt.id}');
                      },
                    );
                  },
                ),
    );
  }
}