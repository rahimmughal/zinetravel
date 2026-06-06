import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../theme/colors.dart';

class PhoneFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final String initialCountryCode;
  final PhoneNumber? initialValue;
  final void Function(PhoneNumber phoneNumber)? onInputChanged;
  final void Function(bool isValid)? onInputValidated;
  final String? Function(String?)? validator;

  const PhoneFieldWidget({
    super.key,
    required this.controller,
    this.label = 'Phone Number',
    this.hintText = 'Enter phone number',
    this.initialCountryCode = 'GB',
    this.initialValue,
    this.onInputChanged,
    this.onInputValidated,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FBFF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFDCE8F7),
          width: 1,
        ),
      ),
      child: InternationalPhoneNumberInput(
        onInputChanged: onInputChanged,
        onInputValidated: onInputValidated,
        selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.DROPDOWN,
          showFlags: true,
          useEmoji: true,
          trailingSpace: false,
        ),
        ignoreBlank: false,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        selectorTextStyle: const TextStyle(
          color: AppColors.text,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
        initialValue: initialValue ??
            PhoneNumber(
              isoCode: initialCountryCode,
            ),
        textFieldController: controller,
        formatInput: true,
        keyboardType: const TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        spaceBetweenSelectorAndTextField: 8,
        inputBorder: InputBorder.none,
        inputDecoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          filled: false,
          isDense: true,
          contentPadding: const EdgeInsets.only(
            top: 14,
            bottom: 10,
          ),
          labelStyle: const TextStyle(
            color: AppColors.muted,
            fontSize: 14,
          ),
          hintStyle: const TextStyle(
            color: AppColors.muted,
            fontSize: 14,
          ),
        ),
        validator: validator ??
            (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Phone number is required';
              }

              return null;
            },
      ),
    );
  }
}