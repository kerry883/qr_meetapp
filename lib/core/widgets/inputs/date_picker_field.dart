import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_meetapp/core/constants/app_colors.dart';

/// Custom date picker field with validation
class DatePickerField extends StatefulWidget {
  final String label;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime> onDateSelected;
  final FormFieldValidator<DateTime>? validator;

  const DatePickerField({
    super.key,
    required this.label,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    required this.onDateSelected,
    this.validator,
  });

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  DateTime? _selectedDate;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _updateController();
  }

  void _updateController() {
    if (_selectedDate != null) {
      _controller.text = DateFormat.yMMMMd().format(_selectedDate!);
    } else {
      _controller.clear();
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(2000),
      lastDate: widget.lastDate ?? DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _updateController();
      });
      widget.onDateSelected(picked);
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
        prefixIcon: const Icon(Icons.calendar_today),
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_month),
          onPressed: () => _selectDate(context),
        ),
      ),
      onTap: () => _selectDate(context),
      validator: (value) {
        if (_selectedDate == null) {
          return 'Please select a date';
        }
        return widget.validator?.call(_selectedDate!);
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}