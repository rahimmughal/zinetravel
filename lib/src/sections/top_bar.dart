import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../widgets/common_widgets.dart';

class TopBar extends StatelessWidget {
  final VoidCallback onAbout;
  final VoidCallback onServices;
  final VoidCallback onContact;
  final VoidCallback onRegister;

  const TopBar({
    super.key,
    required this.onAbout,
    required this.onServices,
    required this.onContact,
    required this.onRegister,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 850;

    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 18 : 70,
              vertical: 10,
            ),
            color: AppColors.dark,
            child: Row(
              children: [
                const Icon(Icons.email, color: Colors.white70, size: 17),
                const SizedBox(width: 8),
                const Text(
                  'zinetravelltd@outlook.com',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(width: 20),
                if (!isMobile) ...[
                  const Icon(Icons.phone, color: Colors.white70, size: 17),
                  const SizedBox(width: 8),
                  const Text(
                    '0128 2901770',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
                const Spacer(),
                if (!isMobile)
                  const Text(
                    'UK fastest growing travel consolidator',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 18 : 70,
              vertical: 18,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x11000000),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                const Logo(),
                const Spacer(),
                if (isMobile)
                  Builder(
                    builder: (context) {
                      return IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      );
                    },
                  )
                else ...[
                  NavButton(label: 'Home', onTap: () {}),
                  NavButton(label: 'About Us', onTap: onAbout),
                  NavButton(label: 'Services', onTap: onServices),
                  NavButton(label: 'Contact Us', onTap: onContact),
                  const SizedBox(width: 18),
                  PrimaryButton(
                    text: 'Become Agent',
                    onTap: onRegister,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
