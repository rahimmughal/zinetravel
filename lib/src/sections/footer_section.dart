import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../widgets/common_widgets.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.dark,
      child: Section(
        child: Column(
          children: [
            Wrap(
              spacing: 40,
              runSpacing: 40,
              alignment: WrapAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 310,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const LogoDark(),
                      const SizedBox(height: 18),
                      const Text(
                        'UK fastest growing travel consolidator. We take care of partnerships and operations so you can focus on serving your customers.',
                        style: TextStyle(
                          color: Colors.white60,
                          height: 1.7,
                        ),
                      ),
                      // const SizedBox(height: 24),
                      // Wrap(
                      //   spacing: 12,
                      //   children: [
                      //     _socialIcon(Icons.facebook),
                      //     _socialIcon(Icons.camera_alt),
                      //     // _socialIcon(Icons.link),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                const FooterColumn(
                  title: 'Contact Info',
                  canCopy: true,
                  items: [
                    'Email: zinetravelltd@outlook.com',
                    'Phone: +44 7821 391065',
                    'WhatsApp: +44 128 2901770 ',
                    'Company Number: 14008504',
                    'Office Address: 200a Every St, Nelson BB9 7JB, UK',
                  ],
                ),
              ],
            ),
            const SizedBox(height: 48),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 24),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.white12),
                ),
              ),
              child: Text(
                '© ${DateTime.now().year} Zine Travel LTD. All rights reserved.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white38,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialIcon(IconData icon) {
    return Container(
      height: 38,
      width: 38,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: Colors.white70, size: 18),
    );
  }
}

class LogoDark extends StatelessWidget {
  const LogoDark({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 42,
          width: 42,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.flight_takeoff,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          'Zine Travel',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
