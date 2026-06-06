import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zinetravel/src/sections/contact_us_section.dart';

import 'theme/colors.dart';
import 'sections/top_bar.dart';
import 'sections/hero_section.dart';
import 'sections/welcome_section.dart';
import 'sections/services_section.dart';
import 'sections/cta_banner.dart';
import 'sections/why_choose_us.dart';
import 'sections/footer_section.dart';

class SkyFlightMcrApp extends StatelessWidget {
  const SkyFlightMcrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zine Travel',
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _openWhatsApp() async {
  const phoneNumber = '447821391065';
  const message = 'Hello Zine Travel, I need travel booking assistance.';

  final Uri whatsappUrl = Uri.parse(
    'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}',
  );

  if (!await launchUrl(
    whatsappUrl,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not open WhatsApp');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      floatingActionButton: FloatingActionButton(
    onPressed: _openWhatsApp,
    backgroundColor: const Color(0xFF25D366),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Image.asset("assets/images/whatsapp.png",))
  ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            TopBar(
              onAbout: () => _scrollTo(_aboutKey),
              onServices: () => _scrollTo(_servicesKey),
              onContact: () => _scrollTo(_contactKey),
              onRegister: () {},
            ),
            HeroSection(
              onContact: () => _scrollTo(_contactKey),
              onRegister: () {},
            ),
            // const StatsSection(),
            
            Container(child: const WelcomeSection()),
            Container(key: _servicesKey, child: const ServicesSection()),
            Container(key: _contactKey, child: const ContactSection()),
            const CtaBanner(),
            const WhyChooseUs(),
            Container(key: _aboutKey, child: const FooterSection()),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppColors.dark),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.flight_takeoff,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Zine Travel',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          _drawerItem('Home', () {}),
          _drawerItem('About Us', () => _scrollTo(_aboutKey)),
          _drawerItem('Services', () => _scrollTo(_servicesKey)),
          _drawerItem('Contact Us', () => _scrollTo(_contactKey)),
          _drawerItem('Become Agent', () {}),
        ],
      ),
    );
  }

  Widget _drawerItem(String label, VoidCallback onTap) {
    return ListTile(
      title: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.text,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}
