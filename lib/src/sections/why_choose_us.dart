import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../widgets/common_widgets.dart';

class WhyChooseUs extends StatelessWidget {
  const WhyChooseUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Section(
        child: Column(
          children: [
              const SectionTitle(
              smallTitle: 'About Us',
            ),
            SizedBox(height: 42),
            const SectionTitle(
              smallTitle: 'WHY CHOOSE Zine Travel LTD?',
              title: 'The reasons to choose us as your business partner.',
              subtitle: '',
            ),
            const SizedBox(height: 48),
            const ResponsiveWrap(
              children: [
                WhyChooseCard(
                  icon: Icons.workspace_premium,
                  title: 'Highly Experienced',
                  description:
                      'We have over 25 years of experience in handling travel for clients of all sizes.',
                ),
                WhyChooseCard(
                  icon: Icons.public,
                  title: 'World-Class Services',
                  description:
                      'Our world-class services are delivered through our self-managed, state-of-the-art booking and issuance portal.',
                ),
                WhyChooseCard(
                  icon: Icons.support_agent,
                  title: 'Top-Notch 24/7 Support',
                  description:
                      'We are here for you round the clock, to serve you and to help you thrive.',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WhyChooseCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const WhyChooseCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 66,
            width: 66,
            decoration: BoxDecoration(
              color: AppColors.lightBg,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: AppColors.primary, size: 34),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.dark,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.muted,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
