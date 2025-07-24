import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:qr_meetapp/core/constants/app_colors.dart';
import 'package:qr_meetapp/core/constants/app_styles.dart';
import 'package:qr_meetapp/core/utils/validation_utils.dart';
import 'package:qr_meetapp/core/widgets/buttons/primary_button.dart';
import 'package:qr_meetapp/core/widgets/inputs/app_text_field.dart';
import 'package:qr_meetapp/data/models/user_model.dart';
import 'package:qr_meetapp/features/profile/profile_view_model.dart';
import 'package:provider/provider.dart';

/// Edit Profile Screen
class EditProfileScreen extends StatefulWidget {
  final UserModel user;

  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _profileImageFile;
  late final _nameController = TextEditingController(text: widget.user.name);
  late final _emailController = TextEditingController(text: widget.user.email);
  late final _phoneController = TextEditingController(text: widget.user.phone);
  late final _companyController = TextEditingController(text: widget.user.company);
  
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final profileViewModel = Provider.of<ProfileViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final updatedUser = widget.user.copyWith(
                  name: _nameController.text,
                  email: _emailController.text,
                  phone: _phoneController.text,
                  company: _companyController.text,
                );
                profileViewModel.updateProfile(updatedUser);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Profile photo
              GestureDetector(
                onTap: () async {
                  final picker = ImagePicker();
                  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _profileImageFile = File(pickedFile.path);
                    });
                    final profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);
                    final userId = widget.user.id;
                    final repo = profileViewModel.repository;
                    try {
                      final imageUrl = await repo.uploadProfileImage(userId, pickedFile.path);
                      final updatedUser = widget.user.copyWith(profileImageUrl: imageUrl);
                      await profileViewModel.updateProfile(updatedUser);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Profile photo updated successfully!')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to update photo: $e'), backgroundColor: AppColors.error),
                      );
                    }
                  }
                },
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: _profileImageFile != null
                          ? FileImage(_profileImageFile!)
                          : (widget.user.profileImageUrl != null && widget.user.profileImageUrl!.isNotEmpty
                              ? NetworkImage(widget.user.profileImageUrl!)
                              : const AssetImage('assets/images/default_avatar.png')) as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.edit, color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Name field
              AppTextField(
                controller: _nameController,
                label: 'Full Name',
                prefixIcon: Icons.person,
                validator: (value) => 
                    ValidationUtils.validateRequired(value, 'Name'),
              ),
              const SizedBox(height: 16),
              
              // Email field
              AppTextField(
                controller: _emailController,
                label: 'Email Address',
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: ValidationUtils.validateEmail,
              ),
              const SizedBox(height: 16),
              
              // Phone field
              AppTextField(
                controller: _phoneController,
                label: 'Phone Number',
                prefixIcon: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: ValidationUtils.validatePhoneNumber,
              ),
              const SizedBox(height: 16),
              
              // Company field
              AppTextField(
                controller: _companyController,
                label: 'Company',
                prefixIcon: Icons.business,
              ),
              const SizedBox(height: 32),
              
              // Change password section
              const Text(
                'Change Password',
                style: AppStyles.titleMedium,
              ),
              const SizedBox(height: 16),
              const AppTextField(
                label: 'Current Password',
                prefixIcon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 16),
              const AppTextField(
                label: 'New Password',
                prefixIcon: Icons.lock_outline,
                obscureText: true,
              ),
              const SizedBox(height: 16),
              const AppTextField(
                label: 'Confirm New Password',
                prefixIcon: Icons.lock_reset,
                obscureText: true,
              ),
              const SizedBox(height: 32),
              
              // Update button
              PrimaryButton(
                onPressed: profileViewModel.isLoading
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          final updatedUser = widget.user.copyWith(
                            name: _nameController.text,
                            email: _emailController.text,
                            phone: _phoneController.text,
                            company: _companyController.text,
                          );
                          profileViewModel.updateProfile(updatedUser);
                        }
                      },
                label: 'Save Changes',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _companyController.dispose();
    super.dispose();
  }
}