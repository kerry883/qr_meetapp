import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:qr_meetapp/core/widgets/layout/section_header.dart';
import 'package:qr_meetapp/core/widgets/layout/bottom_nav_bar.dart';
import 'package:qr_meetapp/features/home/widgets/home_app_bar.dart';
import 'package:qr_meetapp/features/home/widgets/search_section.dart';
import 'package:qr_meetapp/features/home/widgets/upcoming_appointments.dart';
import 'package:qr_meetapp/features/home/widgets/appointment_categories.dart';
import 'package:qr_meetapp/data/models/appointment_model.dart';
import 'package:qr_meetapp/data/models/category_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data - in a real app this would come from state management
    final List<AppointmentModel> sampleAppointments = [
      AppointmentModel(
        id: '1',
        title: 'Meeting with John',
        description: 'Discuss project details',
        location: 'Conference Room A',
        startTime: DateTime.now().add(const Duration(hours: 2)),
        endTime: DateTime.now().add(const Duration(hours: 3)),
        status: 'accepted',
        categoryId: 'business',
        hostId: 'host1',
        hostName: 'John Doe',
        guestId: 'guest1',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    final List<AppointmentCategory> sampleCategories = [
      const AppointmentCategory(id: '1', name: 'Business', icon: Icons.business),
      const AppointmentCategory(id: '2', name: 'Health', icon: Icons.health_and_safety),
      const AppointmentCategory(id: '3', name: 'Education', icon: Icons.school),
    ];

    return Scaffold(
      appBar: const HomeAppBar(),
      body: CustomScrollView(
        slivers: [
          // Search section
          SliverToBoxAdapter(
            child: SearchSection(
              onSearch: (query) {
                // Handle search
              },
              onFilterPressed: () {
                // Handle filter
              },
            ),
          ),
          
          // Upcoming appointments
          SliverToBoxAdapter(
            child: SectionHeader(
              title: 'Upcoming Appointments',
              actionText: 'View All',
              onAction: () => context.push('/appointments'),
            ),
          ),
          SliverToBoxAdapter(
            child: UpcomingAppointments(
              appointments: sampleAppointments,
            ),
          ),
          
          // Categories
          const SliverToBoxAdapter(
            child: SectionHeader(
              title: 'Categories',
            ),
          ),
          SliverToBoxAdapter(
            child: AppointmentCategories(
              categories: sampleCategories,
              onCategorySelected: (category) {
                // Handle category selection
              },
            ),
          ),
          
          // Spacer
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
    );
  }
}
