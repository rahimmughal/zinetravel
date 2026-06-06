import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../widgets/common_widgets.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Section(
        child: Flex(
          direction: isMobile ? Axis.vertical : Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: isMobile ? 0 : 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'WELCOME',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 14,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Leveraging over 10 years of expertise in the travel industry.',
                    style: TextStyle(
                      color: AppColors.dark,
                      fontSize: 38,
                      fontWeight: FontWeight.w900,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'We assist you in managing and expanding your business.',
                    style: TextStyle(
                      color: AppColors.muted,
                      fontSize: 18,
                      height: 1.7,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: const [
                      CheckPill(text: 'Highly Experienced'),
                      CheckPill(text: 'Best and Competitive Fares'),
                      CheckPill(text: 'Highly Experienced Support Team'),
                      CheckPill(text: 'Online Booking - Easy to Use'),
                      CheckPill(text: 'ATOL Protected & IATA Certified'),
                      CheckPill(text: 'Fare Match Policy'),
                    ],
                  ),
                ],
              ),
            ),
            if (!isMobile) const SizedBox(width: 60, height: 45),
            if (isMobile) const SizedBox(height: 40),
            Expanded(
              flex: isMobile ? 0 : 1,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 560, maxHeight: 340),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 22,
                      offset: Offset(0, 12),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    'assets/images/leverage_success.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 340,
                      decoration: BoxDecoration(
                        color: AppColors.lightBg,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.flight_takeoff,
                          size: 80,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
