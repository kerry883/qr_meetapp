import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Custom time picker field with validation
class TimePickerField extends StatefulWidget {
  final String label;
  final TimeOfDay? initialTime;
  final ValueChanged<TimeOfDay> onTimeSelected;
  final FormFieldValidator<TimeOfDay>? validator;
  final bool readOnly;

  const TimePickerField({
    super.key,
    required this.label,
    this.initialTime,
    required this.onTimeSelected,
    this.validator,
    this.readOnly = false,
  });

  @override
  State<TimePickerField> createState() => _TimePickerFieldState();
}

class _TimePickerFieldState extends State<TimePickerField> {
  late TextEditingController _controller;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _selectedTime = widget.initialTime;
    _updateController();
  }

  void _updateController() {
    if (_selectedTime != null) {
      final now = DateTime.now();
      final dateTime = DateTime(
        now.year,
        now.month,
        now.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );
      _controller.text = DateFormat.jm().format(dateTime);
    } else {
      _controller.clear();
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    if (widget.readOnly) return;
    
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        _updateController();
      });
      widget.onTimeSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: widget.label,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.access_time),
        suffixIcon: IconButton(
          icon: const Icon(Icons.schedule),
          onPressed: widget.readOnly ? null : () => _selectTime(context),
        ),
      ),
      onTap: () => _selectTime(context),
      validator: (value) {
        if (_selectedTime == null) {
          return 'Please select a time';
        }
        return widget.validator?.call(_selectedTime!);
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}