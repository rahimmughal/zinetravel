import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../widgets/common_widgets.dart';

class CtaBanner extends StatelessWidget {
  const CtaBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.dark, AppColors.primary, AppColors.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Section(
        child: Column(
          children: [
            const Text(
              'Join Our Fastest Growing Travel Consolidator',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w900,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 18),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: const Text(
                'We are trusted by over 600+ clients. Join them by using our services and grow your business.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  height: 1.6,
                ),
              ),
            ),
            const SizedBox(height: 36),
            PrimaryButton(
              text: 'Launch Agent Portal',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
