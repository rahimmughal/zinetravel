import 'dart:async';

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zinetravel/src/sections/become_agent_section.dart';
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

  bool _showTopBar = true;
  Timer? _scrollStopTimer;

  static const double _topBarSpace = 112;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    if (!_scrollController.hasClients) {
      return;
    }

    final offset = _scrollController.offset;

    if (offset <= 10) {
      _scrollStopTimer?.cancel();

      if (!_showTopBar) {
        setState(() {
          _showTopBar = true;
        });
      }

      return;
    }

    if (_showTopBar) {
      setState(() {
        _showTopBar = false;
      });
    }

    _scrollStopTimer?.cancel();

    _scrollStopTimer = Timer(
      const Duration(milliseconds: 420),
      () {
        if (mounted) {
          setState(() {
            _showTopBar = true;
          });
        }
      },
    );
  }

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

  void _openBecomeAgentPopup() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        final screenWidth = MediaQuery.of(dialogContext).size.width;
        final screenHeight = MediaQuery.of(dialogContext).size.height;
        final isMobile = screenWidth < 700;

        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(
            horizontal: isMobile ? 14 : 32,
            vertical: isMobile ? 18 : 32,
          ),
          child: Stack(
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: 1250,
                  maxHeight: screenHeight * 0.92,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(37),
                ),
                clipBehavior: Clip.antiAlias,
                child: const SingleChildScrollView(
                  child: BecomeAgentSection(
                    isPopup: true,
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Material(
                  color: Colors.white,
                  shape: const CircleBorder(),
                  elevation: 6,
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {
                      Navigator.pop(dialogContext);
                    },
                    child: const SizedBox(
                      height: 42,
                      width: 42,
                      child: Icon(
                        Icons.close,
                        color: AppColors.dark,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollStopTimer?.cancel();
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
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
          child: Image.asset(
            'assets/images/whatsapp.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: _topBarSpace),
                HeroSection(
                  onContact: () => _scrollTo(_contactKey),
                  onRegister: _openBecomeAgentPopup,
                ),
                const WelcomeSection(),
                Container(
                  key: _servicesKey,
                  child: const ServicesSection(),
                ),
                Container(
                  key: _contactKey,
                  child: const ContactSection(),
                ),
                CtaBanner(
                  onBecomeAgent: _openBecomeAgentPopup,
                ),
                const WhyChooseUs(),
                Container(
                  key: _aboutKey,
                  child: const FooterSection(),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedSlide(
              offset: _showTopBar ? Offset.zero : const Offset(0, -1.1),
              duration: const Duration(milliseconds: 320),
              curve: Curves.easeOutCubic,
              child: AnimatedOpacity(
                opacity: _showTopBar ? 1 : 0,
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOut,
                child: Material(
                  elevation: 8,
                  shadowColor: Colors.black.withOpacity(0.12),
                  child: TopBar(
                    onAbout: () => _scrollTo(_aboutKey),
                    onServices: () => _scrollTo(_servicesKey),
                    onContact: () => _scrollTo(_contactKey),
                    onRegister: _openBecomeAgentPopup,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.dark,
            ),
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
          _drawerItem('Become Agent', _openBecomeAgentPopup),
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
