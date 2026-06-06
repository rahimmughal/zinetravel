import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../theme/colors.dart';
import '../widgets/phone_field_widget.dart';

class BecomeAgentSection extends StatefulWidget {
  final bool isPopup;
  const BecomeAgentSection({super.key, this.isPopup = false});

  @override
  State<BecomeAgentSection> createState() => _BecomeAgentSectionState();
}

class _BecomeAgentSectionState extends State<BecomeAgentSection> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postCodeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isPhoneValid = false;
  String completePhoneNumber = '';

  @override
  void dispose() {
    companyNameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    addressController.dispose();
    cityController.dispose();
    postCodeController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!isPhoneValid || completePhoneNumber.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid phone number.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final agentData = {
      'companyName': companyNameController.text.trim(),
      'firstName': firstNameController.text.trim(),
      'lastName': lastNameController.text.trim(),
      'address': addressController.text.trim(),
      'city': cityController.text.trim(),
      'postCode': postCodeController.text.trim(),
      'email': emailController.text.trim(),
      'phoneNumber': completePhoneNumber,
      'password': passwordController.text.trim(),
    };

    debugPrint(agentData.toString());

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Agent registration submitted successfully.'),
        backgroundColor: Colors.green,
      ),
    );

    clearForm();
  }

  void clearForm() {
    companyNameController.clear();
    firstNameController.clear();
    lastNameController.clear();
    addressController.clear();
    cityController.clear();
    postCodeController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();

    setState(() {
      isPhoneValid = false;
      completePhoneNumber = '';
      isPasswordVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 950;

    return Container(
      width: double.infinity,
      padding: widget.isPopup
    ? EdgeInsets.zero
    : EdgeInsets.symmetric(
        horizontal: isMobile ? 18 : 54,
        vertical: isMobile ? 42 : 70,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFF4F8FF),
            Color(0xFFFFFFFF),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 1320,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(34),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 35,
                offset: Offset(0, 18),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: isMobile
              ? Column(
                  children: [
                    _BecomeAgentVisual(isMobile: isMobile),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 34,
                      ),
                      child: _buildForm(isMobile),
                    ),
                  ],
                )
              : IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 5,
                        child: _BecomeAgentVisual(isMobile: isMobile),
                      ),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 44,
                            vertical: 42,
                          ),
                          child: _buildForm(isMobile),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildForm(bool isMobile) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment:
            isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF2FF),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              'BECOME AN AGENT',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
              ),
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            'Welcome to Zine Travel',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: AppColors.dark,
              fontSize: 32,
              fontWeight: FontWeight.w900,
              height: 1.15,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Create your agent account and start accessing flights, hotels, group bookings, and dedicated travel support.',
            style: TextStyle(
              color: AppColors.muted,
              fontSize: 15,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 28),

          _AgentTextField(
            controller: companyNameController,
            label: 'Company Name *',
            icon: Icons.business_outlined,
            validator: requiredValidator('Company name is required'),
          ),

          const SizedBox(height: 16),

          _ResponsiveFormRow(
            left: _AgentTextField(
              controller: firstNameController,
              label: 'First Name *',
              icon: Icons.person_outline,
              validator: requiredValidator('First name is required'),
            ),
            right: _AgentTextField(
              controller: lastNameController,
              label: 'Last Name *',
              icon: Icons.person_outline,
              validator: requiredValidator('Last name is required'),
            ),
          ),

          const SizedBox(height: 16),

          _AgentTextField(
            controller: addressController,
            label: 'Address *',
            icon: Icons.location_on_outlined,
            validator: requiredValidator('Address is required'),
          ),

          const SizedBox(height: 16),

          _ResponsiveFormRow(
            left: _AgentTextField(
              controller: cityController,
              label: 'City *',
              icon: Icons.location_city_outlined,
              validator: requiredValidator('City is required'),
            ),
            right: _AgentTextField(
              controller: postCodeController,
              label: 'PostCode *',
              icon: Icons.markunread_mailbox_outlined,
              validator: requiredValidator('PostCode is required'),
            ),
          ),

          const SizedBox(height: 16),

          _AgentTextField(
            controller: emailController,
            label: 'Email *',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: emailValidator,
          ),

          const SizedBox(height: 16),

          PhoneFieldWidget(
            controller: phoneController,
            label: 'Phone Number *',
            hintText: 'Enter phone number',
            initialCountryCode: 'GB',
            onInputChanged: (PhoneNumber number) {
              completePhoneNumber = number.phoneNumber ?? '';
            },
            onInputValidated: (bool isValid) {
              isPhoneValid = isValid;
            },
          ),

          const SizedBox(height: 16),

          _AgentTextField(
            controller: passwordController,
            label: 'Password *',
            icon: Icons.lock_outline,
            obscureText: !isPasswordVisible,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
              icon: Icon(
                isPasswordVisible
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.muted,
              ),
            ),
            validator: passwordValidator,
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: submitForm,
              icon: const Icon(Icons.arrow_forward_rounded),
              label: const Text('Create Agent Account'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),

          const SizedBox(height: 18),

          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                const Text(
                  'Already have an account? ',
                  style: TextStyle(
                    color: AppColors.muted,
                    fontSize: 14,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    'Sign in',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String? Function(String?) requiredValidator(String message) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return message;
      }

      return null;
    };
  }

  String? emailValidator(String? value) {
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
  }

  String? passwordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }

    if (value.trim().length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }
}

class _BecomeAgentVisual extends StatelessWidget {
  final bool isMobile;

  const _BecomeAgentVisual({
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isMobile ? 420 : double.infinity,
      constraints: BoxConstraints(
        minHeight: isMobile ? 420 : 760,
      ),
      color: AppColors.dark,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/agent-register.jpg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF061A3A),
                      Color(0xFF0B3D91),
                      Color(0xFF1E88E5),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              );
            },
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.55),
                  Colors.black.withOpacity(0.18),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),

          Positioned(
            top: 32,
            left: 32,
            right: 32,
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: const [
                _VisualChip(
                  icon: Icons.flight_takeoff,
                  text: 'Flights',
                ),
                _VisualChip(
                  icon: Icons.hotel,
                  text: 'Hotels',
                ),
                _VisualChip(
                  icon: Icons.groups,
                  text: 'Groups',
                ),
              ],
            ),
          ),

          Center(
            child: Container(
              height: 92,
              width: 92,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: Colors.white.withOpacity(0.35),
                ),
              ),
              child: const Icon(
                Icons.travel_explore,
                color: Colors.white,
                size: 52,
              ),
            ),
          ),

          Positioned(
            left: 28,
            right: 28,
            bottom: 28,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(26),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x22000000),
                    blurRadius: 24,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Become Our Travel Agent',
                    style: TextStyle(
                      color: AppColors.dark,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Get access to flights, hotels, group booking support, competitive fares, and dedicated travel solutions.',
                    style: TextStyle(
                      color: AppColors.muted,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 18),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _BenefitPill(text: 'Competitive Fares'),
                      _BenefitPill(text: '24/7 Support'),
                      _BenefitPill(text: 'Fast Booking'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResponsiveFormRow extends StatelessWidget {
  final Widget left;
  final Widget right;

  const _ResponsiveFormRow({
    required this.left,
    required this.right,
  });

  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 650;

    if (isSmall) {
      return Column(
        children: [
          left,
          const SizedBox(height: 16),
          right,
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: left),
        const SizedBox(width: 16),
        Expanded(child: right),
      ],
    );
  }
}

class _AgentTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const _AgentTextField({
    required this.controller,
    required this.label,
    required this.icon,
    this.obscureText = false,
    this.keyboardType,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(
        color: AppColors.text,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          icon,
          color: AppColors.primary,
          size: 21,
        ),
        suffixIcon: suffixIcon,
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
      ),
    );
  }
}

class _VisualChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _VisualChip({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.white.withOpacity(0.25),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 17,
          ),
          const SizedBox(width: 7),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _BenefitPill extends StatelessWidget {
  final String text;

  const _BenefitPill({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF2FF),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 12,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}