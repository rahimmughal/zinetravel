import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../widgets/common_widgets.dart';

class ServicesSection extends StatefulWidget {
  const ServicesSection({super.key});

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<ServiceData> services = const [
    ServiceData(
      title: 'Flight Booking',
      shortText: 'Best fares from trusted airlines worldwide.',
      image: 'assets/images/flight_booking.png',
      icon: Icons.flight_takeoff,
      heading:
          'Find the best rates for both domestic and international flights.',
      description:
          'We provide competitive prices, quick booking support, and reliable travel solutions for top airlines around the world.',
      expertise: 'Flight Booking Expertise',
      benefits: [
        'Competitive Fares',
        'Top Airlines',
        'Fast Booking',
        '24/7 Support',
      ],
    ),
    ServiceData(
      title: 'Hotel Booking',
      shortText: 'Book domestic and international hotels easily.',
      image: 'assets/images/hotel_booking.png',
      icon: Icons.hotel,
      heading:
          'Domestic and international hotels available on one simple platform.',
      description:
          'Find and book hotels worldwide with a smooth, secure, and user-friendly booking experience.',
      expertise: 'Hotel Booking Expertise',
      benefits: [
        'Worldwide Hotels',
        'Easy Booking',
        'Secure Process',
        'Best Rates',
      ],
    ),
    ServiceData(
      title: 'Group Booking',
      shortText: 'Flexible travel solutions for groups of all sizes.',
      image: 'assets/images/group_image.png',
      icon: Icons.groups,
      heading: 'Group bookings made simple for all group sizes.',
      description:
          'We manage group travel with flights, hotels, transport, and activities. You can book flights only or let us handle everything end-to-end.',
      expertise: 'Group Booking Expertise',
      benefits: [
        'Special Group Rates',
        'Flexible Planning',
        'Flights & Hotels',
        'End-to-End Support',
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: services.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void changeTab(int index) {
    setState(() {
      _tabController.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFF5F9FF),
            Color(0xFFFFFFFF),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Section(
        child: Column(
          children: [
            const SectionTitle(
              smallTitle: 'OUR SERVICES',
              title:
                  'Smart travel solutions designed to grow your business.',
              subtitle:
                  'From flights and hotels to group travel, we provide reliable booking support with competitive rates and expert service.',
            ),

            const SizedBox(height: 34),

            _ServiceHighlights(services: services),

            const SizedBox(height: 42),

            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x12000000),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: TabBar(
                controller: _tabController,
                // isScrollable: isMobile,
                tabAlignment: isMobile ? TabAlignment.center : TabAlignment.fill,
                onTap: changeTab,
                overlayColor: WidgetStatePropertyAll(Colors.transparent),
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: AppColors.muted,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
                tabs: services
                    .map(
                      (service) => Tab(
                        height: 62,
                        icon: Icon(service.icon, size: 22),
                        text: service.title,
                      ),
                    )
                    .toList(),
              ),
            ),

            const SizedBox(height: 38),

            SizedBox(
              height: isMobile ? 880 : 470,
              child: TabBarView(
                controller: _tabController,
                children: services
                    .map(
                      (service) => _ServiceTabContent(
                        service: service,
                        isMobile: isMobile,
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceHighlights extends StatelessWidget {
  final List<ServiceData> services;

  const _ServiceHighlights({
    required this.services,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final itemWidth = width < 700
        ? width - 44
        : width < 1050
            ? (width - 120) / 2
            : (width - 190) / 3;

    return Wrap(
      spacing: 22,
      runSpacing: 22,
      alignment: WrapAlignment.center,
      children: services
          .map(
            (service) => SizedBox(
              width: itemWidth,
              child: _MiniServiceCard(service: service),
            ),
          )
          .toList(),
    );
  }
}

class _MiniServiceCard extends StatelessWidget {
  final ServiceData service;

  const _MiniServiceCard({
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 170,
      ),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE5EEF9),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColors.primary,
                  Color(0xFF1E88E5),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              service.icon,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            service.title,
            style: const TextStyle(
              color: AppColors.dark,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            service.shortText,
            style: const TextStyle(
              color: AppColors.muted,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceTabContent extends StatelessWidget {
  final ServiceData service;
  final bool isMobile;

  const _ServiceTabContent({
    required this.service,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 18 : 26),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: isMobile ? 0 : 1,
            child: _ServiceImageCard(service: service),
          ),

          if (!isMobile) const SizedBox(width: 46),
          if (isMobile) const SizedBox(height: 28),

          Expanded(
            flex: isMobile ? 0 : 1,
            child: _ServiceTextContent(service: service),
          ),
        ],
      ),
    );
  }
}

class _ServiceImageCard extends StatelessWidget {
  final ServiceData service;

  const _ServiceImageCard({
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              service.image,
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary,
                        Color(0xFF1E88E5),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Icon(
                    service.icon,
                    size: 90,
                    color: Colors.white,
                  ),
                );
              },
            ),

            // Container(
            //   decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //       colors: [
            //         Colors.black.withOpacity(0.55),
            //         Colors.black.withOpacity(0.08),
            //       ],
            //       begin: Alignment.bottomCenter,
            //       end: Alignment.topCenter,
            //     ),
            //   ),
            // ),

            ],
        ),
      ),
    );
  }
}

class _ServiceTextContent extends StatelessWidget {
  final ServiceData service;

  const _ServiceTextContent({
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          service.heading,
          style: const TextStyle(
            color: AppColors.dark,
            fontSize: 31,
            fontWeight: FontWeight.w900,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          service.description,
          style: const TextStyle(
            color: AppColors.muted,
            fontSize: 16,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 22),

        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: service.benefits
              .map(
                (benefit) => _BenefitChip(text: benefit),
              )
              .toList(),
        ),

        // const SizedBox(height: 28),

        // Row(
        //   children: [
        //     ElevatedButton.icon(
        //       onPressed: () {},
        //       icon: const Icon(Icons.arrow_forward),
        //       label: const Text('Get Started'),
        //       style: ElevatedButton.styleFrom(
        //         backgroundColor: AppColors.primary,
        //         foregroundColor: Colors.white,
        //         padding: const EdgeInsets.symmetric(
        //           horizontal: 22,
        //           vertical: 18,
        //         ),
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(14),
        //         ),
        //       ),
        //     ),
        //     const SizedBox(width: 14),
        //     OutlinedButton.icon(
        //       onPressed: () {},
        //       icon: const Icon(Icons.support_agent),
        //       label: const Text('Talk to Us'),
        //       style: OutlinedButton.styleFrom(
        //         foregroundColor: AppColors.primary,
        //         side: const BorderSide(color: AppColors.primary),
        //         padding: const EdgeInsets.symmetric(
        //           horizontal: 22,
        //           vertical: 18,
        //         ),
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(14),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}

class _BenefitChip extends StatelessWidget {
  final String text;

  const _BenefitChip({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F7FF),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xFFD9E8FF),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle,
            color: AppColors.primary,
            size: 18,
          ),
          const SizedBox(width: 7),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceData {
  final String title;
  final String shortText;
  final String image;
  final IconData icon;
  final String heading;
  final String description;
  final String expertise;
  final List<String> benefits;

  const ServiceData({
    required this.title,
    required this.shortText,
    required this.image,
    required this.icon,
    required this.heading,
    required this.description,
    required this.expertise,
    required this.benefits,
  });
}