import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:zinetravel/src/widgets/phone_field_widget.dart';

import '../theme/colors.dart';
import '../widgets/common_widgets.dart';
import 'package:http/http.dart' as http;

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  PhoneNumber? phoneNumber;
  String? completePhoneNumber;
  bool isPhoneValid = false;

  final List<String> departments = const [
    'Sales',
    'Marketing',
    'Customer Support',
  ];

  String? selectedDepartment;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.dispose();
  }

    // ─── Reset entire form ─────────────────────────────────────────────────────
  void _resetForm() {
    _formKey.currentState?.reset();
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneController.clear();
    messageController.clear();
    setState(() {
      selectedDepartment  = null;
      completePhoneNumber = null;
      isPhoneValid        = false;
      phoneNumber         = null;
    });
  }

  Future<void> submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!isPhoneValid || (completePhoneNumber?.trim().isEmpty == true)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid phone number.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    const String googleScriptUrl =
        'https://script.google.com/macros/s/AKfycbwiBzYa52UCUkaUHJazb-ls9cWJB_nQwZRYfSj2RPeitD8iTGSUN7J2fxpI9ZfGEI0X/exec';

    try {
      final response = await http.post(
        Uri.parse(googleScriptUrl),
        body: {
          'firstName': firstNameController.text.trim(),
          'lastName': lastNameController.text.trim(),
          'email': emailController.text.trim(),
          'phoneNumber': completePhoneNumber ?? '',
          'department': selectedDepartment ?? '',
          'message': messageController.text.trim(),
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Message submitted successfully.'),
            backgroundColor: Colors.green,
          ),
        );

        _resetForm();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed. Status code: ${response.statusCode}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFF5F9FF),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Section(
        child: Column(
          children: [
            const SectionTitle(
              smallTitle: 'CONTACT US',
              title: 'Get in touch with our travel experts.',
              subtitle:
                  'Have a question about flights, hotels, group booking, or business support? Send us a message and our team will respond shortly.',
            ),
            const SizedBox(height: 46),
            Container(
              padding: EdgeInsets.all(isMobile ? 22 : 34),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x12000000),
                    blurRadius: 24,
                    offset: Offset(0, 12),
                  ),
                ],
              ),
              child: Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: isMobile ? 0 : 1,
                    child: _ContactInfoCard(isMobile: isMobile),
                  ),
                  if (!isMobile) const SizedBox(width: 42),
                  if (isMobile) const SizedBox(height: 32),
                  Expanded(
                    flex: isMobile ? 0 : 1,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _ResponsiveFields(
                            left: _ContactTextField(
                              controller: firstNameController,
                              label: 'First Name',
                              icon: Icons.person_outline,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'First name is required';
                                }
                                return null;
                              },
                            ),
                            right: _ContactTextField(
                              controller: lastNameController,
                              label: 'Last Name',
                              icon: Icons.person_outline,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Last name is required';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 18),
                          _ContactTextField(
                            controller: emailController,
                            label: 'Email',
                            icon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Email is required';
                              }

                              final emailRegex = RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              );

                              if (!emailRegex.hasMatch(value.trim())) {
                                return 'Enter a valid email address';
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 18),
                          DropdownButtonFormField<String>(
                            value: selectedDepartment,
                            decoration: _inputDecoration(
                              label: 'Select Department',
                              icon: Icons.business_center_outlined,
                            ),
                            items: departments
                                .map(
                                  (department) => DropdownMenuItem<String>(
                                    value: department,
                                    child: Text(department),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedDepartment = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a department';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 18),
                          PhoneFieldWidget(
                            controller: phoneController,
                            label: 'Phone Number',
                            hintText: 'Enter phone number',
                            initialCountryCode: 'GB',
                            onInputChanged: (PhoneNumber number) {
                              phoneNumber = number;
                              completePhoneNumber = number.phoneNumber ?? '';
                            },
                            onInputValidated: (bool isValid) {
                              isPhoneValid = isValid;
                            },
                          ),
                          const SizedBox(height: 18),
                          _ContactTextField(
                            controller: messageController,
                            label: 'Message',
                            icon: Icons.message_outlined,
                            maxLines: 5,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Message is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 28),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: submitForm,
                              icon: const Icon(Icons.send),
                              label: const Text('Send Message'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 20,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactInfoCard extends StatelessWidget {
  final bool isMobile;

  const _ContactInfoCard({
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.primary,
            Color(0xFF1E88E5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment:
            isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: const [
          Icon(
            Icons.support_agent,
            color: Colors.white,
            size: 64,
          ),
          SizedBox(height: 24),
          Text(
            'Need travel support?',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w900,
              height: 1.2,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Our team is ready to help you with flight booking, hotel booking, group travel, and customer support.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
              height: 1.7,
            ),
          ),
          SizedBox(height: 28),
          _ContactBenefit(
            icon: Icons.flight_takeoff,
            text: 'Flight Booking Assistance',
          ),
          _ContactBenefit(
            icon: Icons.hotel,
            text: 'Hotel Booking Support',
          ),
          _ContactBenefit(
            icon: Icons.groups,
            text: 'Group Booking Queries',
          ),
          _ContactBenefit(
            icon: Icons.access_time,
            text: 'Quick Response Team',
          ),
        ],
      ),
    );
  }
}

class _ContactBenefit extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ContactBenefit({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 21,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResponsiveFields extends StatelessWidget {
  final Widget left;
  final Widget right;

  const _ResponsiveFields({
    required this.left,
    required this.right,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 650;

    if (isMobile) {
      return Column(
        children: [
          left,
          const SizedBox(height: 18),
          right,
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: left),
        const SizedBox(width: 18),
        Expanded(child: right),
      ],
    );
  }
}

class _ContactTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final int maxLines;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const _ContactTextField({
    required this.controller,
    required this.label,
    required this.icon,
    this.maxLines = 1,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      decoration: _inputDecoration(
        label: label,
        icon: icon,
      ),
    );
  }
}

InputDecoration _inputDecoration({
  required String label,
  required IconData icon,
}) {
  return InputDecoration(
    labelText: label,
    prefixIcon: Icon(
      icon,
      color: AppColors.primary,
    ),
    filled: true,
    fillColor: const Color(0xFFF8FBFF),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 18,
      vertical: 18,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: Color(0xFFDCE8F7),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: Color(0xFFDCE8F7),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: AppColors.primary,
        width: 1.6,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: Colors.redAccent,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: Colors.redAccent,
        width: 1.6,
      ),
    ),
  );
}
