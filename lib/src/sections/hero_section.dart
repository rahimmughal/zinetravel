import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../widgets/common_widgets.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onRegister;
  final VoidCallback onContact;
  const HeroSection({super.key, required this.onRegister, required this.onContact});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 22 : 70,
        vertical: isMobile ? 60 : 95,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.dark,
            AppColors.primary,
            AppColors.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Flex(
        direction: isMobile ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: isMobile ? 0 : 1,
            child: Column(
              crossAxisAlignment:
                  isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    'Travel Partner for Growth',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                const Text(
                  'Your Companion for Advancement',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 56,
                    height: 1.08,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 22),
                const Text(
                  'We take care of all the heavy lifting of partnerships and operations so you can focus on serving your customers.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                    height: 1.7,
                  ),
                ),
                const SizedBox(height: 34),
                Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  children: [
                    PrimaryButton(
                      text: 'Become Agent',
                      onTap: onRegister,
                    ),
                    OutlineAppButton(
                      text: 'Contact Us',
                      onTap: onContact,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 50, height: 45),
          Expanded(
            flex: isMobile ? 0 : 1,
            child: const HeroCard(),
          ),
        ],
      ),
    );
  }
}

class HeroCard extends StatelessWidget {
  const HeroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 520),
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 26,
            offset: Offset(0, 16),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Image.asset("assets/images/empower_img.png", alignment: Alignment.center, fit: BoxFit.fill),
      ),
      // child: Column(
      //   children: const [
      //     Icon(
      //       Icons.public,
      //       size: 92,
      //       color: AppColors.primary,
      //     ),
      //     SizedBox(height: 22),
      //     Text(
      //       'Empower your travel business to operate and grow efficiently.',
      //       textAlign: TextAlign.center,
      //       style: TextStyle(
      //         fontSize: 27,
      //         fontWeight: FontWeight.w800,
      //         color: AppColors.dark,
      //         height: 1.25,
      //       ),
      //     ),
      //     SizedBox(height: 18),
      //     Text(
      //       'Flights • Hotels • Groups • 24/7 Support',
      //       textAlign: TextAlign.center,
      //       style: TextStyle(
      //         fontSize: 16,
      //         color: AppColors.muted,
      //         height: 1.5,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
