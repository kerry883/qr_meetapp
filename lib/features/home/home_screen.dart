import 'dart:async' as dart_async;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:qr_meetapp/core/widgets/layout/section_header.dart';
import 'package:qr_meetapp/features/home/widgets/home_app_bar.dart';
import 'package:qr_meetapp/features/home/widgets/search_section.dart';
import 'package:qr_meetapp/features/home/widgets/upcoming_appointments.dart';
import 'package:qr_meetapp/features/home/widgets/appointment_categories.dart';
import 'package:provider/provider.dart';
import 'package:qr_meetapp/state/auth_state.dart';
import 'package:qr_meetapp/state/appointment_state.dart';
import 'package:qr_meetapp/data/models/appointment_model.dart';
import 'package:qr_meetapp/data/models/category_model.dart';
import 'package:qr_meetapp/core/widgets/indicators/empty_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }
  final List<AppointmentCategory> sampleCategories = const [
    AppointmentCategory(id: '1', name: 'Business', icon: Icons.business),
    AppointmentCategory(id: '2', name: 'Health', icon: Icons.health_and_safety),
    AppointmentCategory(id: '3', name: 'Education', icon: Icons.school),
  ];

  @override
  void initState() {
    super.initState();
    // Load appointments for current user if available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final auth = context.read<AuthState>();
      final appt = context.read<AppointmentState>();
      final userId = auth.currentUser?.id;
      if (userId != null && userId.isNotEmpty) {
        appt.loadAppointments(userId);
      }
    });
  }

  dart_async.Timer? _searchDebounce;
  void _onSearch(String query) {
    _searchDebounce?.cancel();
    _searchDebounce = dart_async.Timer(const Duration(milliseconds: 250), () {
      if (!mounted) return;
      context.read<AppointmentState>().setSearchQuery(query);
    });
  }

  void _onFilterPressed() {
    // Example: set a canned search to demonstrate filtering
    context.read<AppointmentState>().setSearchQuery('meeting');
  }

  void _onCategorySelected(AppointmentCategory category) {
    // Navigate to category details page
    context.push('/category/${category.id}', extra: category);
  }

  @override
  Widget build(BuildContext context) {
    final hasAppointments = context.select<AppointmentState, bool>((s) => s.filteredAppointments.isNotEmpty);

    return Scaffold(
      appBar: const HomeAppBar(),
      body: CustomScrollView(
        slivers: [
          // Search section
          SliverToBoxAdapter(
            child: SearchSection(
              onSearch: _onSearch,
              onFilterPressed: _onFilterPressed,
            ),
          ),

          // Upcoming appointments header with slight horizontal padding
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SectionHeader(
                title: 'Upcoming Appointments',
                actionText: hasAppointments ? 'View All' : null,
                onAction: hasAppointments ? () => context.push('/home/appointments') : null,
              ),
            ),
          ),

          // Upcoming appointments or empty state
          SliverToBoxAdapter(
            child: Selector<AppointmentState, List<AppointmentModel>>(
              selector: (_, s) => s.filteredAppointments,
              builder: (context, filteredAppointments, _) {
                if (filteredAppointments.isNotEmpty) {
                  return UpcomingAppointments(appointments: filteredAppointments);
                }
return const Padding(
  padding: EdgeInsets.only(bottom: 12),
  child: SizedBox(
    height: 180,
    child: EmptyState(
      title: 'No upcoming appointments',
      message: 'No meetings scheduled. Tap filter to preview or book one.',
      height: 100,
    ),
  ),
);
              },
            ),
          ),

          // Categories with slight horizontal padding
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: SectionHeader(
                title: 'Categories',
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: AppointmentCategories(
              categories: sampleCategories,
              onCategorySelected: _onCategorySelected,
            ),
          ),

          // Spacer
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }
}
