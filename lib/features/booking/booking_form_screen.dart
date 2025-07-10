import 'package:flutter/material.dart';

import 'package:qr_meetapp/core/utils/date_time_utils.dart';
import 'package:qr_meetapp/core/widgets/buttons/primary_button.dart';
import 'package:qr_meetapp/core/widgets/inputs/app_text_field.dart';
import 'package:qr_meetapp/core/widgets/inputs/date_picker_field.dart';
import 'package:qr_meetapp/core/widgets/inputs/time_picker_field.dart';
import 'package:qr_meetapp/data/models/appointment_model.dart';
import 'package:qr_meetapp/data/models/category_model.dart';
import 'package:qr_meetapp/features/booking/booking_view_model.dart';
import 'package:provider/provider.dart';

/// Booking Form Screen
class BookingFormScreen extends StatefulWidget {
  final AppointmentCategory? category;
  final String? preFilledHost;

  const BookingFormScreen({
    super.key,
    this.category,
    this.preFilledHost,
  });

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _hostController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    if (widget.preFilledHost != null) {
      _hostController.text = widget.preFilledHost!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookingViewModel = Provider.of<BookingViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category != null 
            ? 'Book ${widget.category!.name}' 
            : 'New Booking'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Host selection
              AppTextField(
                controller: _hostController,
                label: 'Host',
                prefixIcon: Icons.person_search,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a host';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
              // Title
              AppTextField(
                controller: _titleController,
                label: 'Meeting Title',
                prefixIcon: Icons.title,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
              // Date and time
              Row(
                children: [
                  Expanded(
                    child: DatePickerField(
                      label: 'Date',
                      onDateSelected: (date) {
                        setState(() {
                          _selectedDate = date;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TimePickerField(
                      label: 'Time',
                      onTimeSelected: (time) {
                        setState(() {
                          _selectedTime = time;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // Location
              AppTextField(
                controller: _locationController,
                label: 'Location',
                prefixIcon: Icons.location_on,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
              // Description
              AppTextField(
                controller: _descriptionController,
                label: 'Purpose',
                prefixIcon: Icons.description,
                maxLines: 4,
              ),
              const SizedBox(height: 32),
              
              // Submit button
              PrimaryButton(
                onPressed: bookingViewModel.isLoading
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          final appointment = Appointment(
                            id: '', // Will be set by the repository
                            title: _titleController.text,
                            description: _descriptionController.text,
                            location: _locationController.text,
                            startTime: DateTimeUtils.combineDateAndTime(
                                _selectedDate!, _selectedTime!),
                            endTime: DateTimeUtils.combineDateAndTime(
                                    _selectedDate!, _selectedTime!)
                                .add(const Duration(hours: 1)),
                            categoryId: widget.category?.id,
                            hostId: '', // Will be set by the view model
                            hostName: '', // Will be set by the view model
                            status: 'pending',
                            createdAt: DateTime.now(),
                          );
                          
                          bookingViewModel.createAppointment(appointment);
                        }
                      },
                label: 'Send Request',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}