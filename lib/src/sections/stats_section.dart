import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../widgets/common_widgets.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.lightBg,
      child: const Section(
        child: ResponsiveWrap(
          children: [
            StatCard(number: '877', label: 'Completed Projects'),
            StatCard(number: '600', label: 'Happy Clients'),
            StatCard(number: '5', label: 'Awards Won'),
          ],
        ),
      ),
    );
  }
}
