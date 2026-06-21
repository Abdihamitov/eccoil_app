import 'package:flutter/material.dart';
import '../widgets/stat_card.dart';
import '../widgets/air_quality_chart.dart';
import '../widgets/animated_ring.dart';
import '../theme/app_theme.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.air, color: AppTheme.primaryColor),
            const SizedBox(width: 8),
            const Text('EcoCoil', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          const CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage('https://i.pravatar.cc/100'),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(-0.5, -0.5),
            radius: 1.5,
            colors: [
              Color(0xFF1E293B), // Lighter slate
              Color(0xFF0F172A), // Dark slate
            ],
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    // Main AQI Ring
                    const AnimatedRing(
                      value: 0.93, // 7 out of max good (e.g., 100 is bad, so inverted or mapped)
                      color: AppTheme.primaryColor,
                      label: '7',
                      subtitle: 'Отлично',
                    ),
                    const SizedBox(height: 40),
                    
                    // Stats Grid
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: 'Снаружи',
                            value: '120',
                            unit: 'μg',
                            icon: Icons.cloud_outlined,
                            color: Colors.orangeAccent,
                            subtitle: 'Умеренно',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: StatCard(
                            title: 'Эффективность',
                            value: '97',
                            unit: '%',
                            icon: Icons.shield_outlined,
                            color: AppTheme.primaryColor,
                            subtitle: 'Активен',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: 'Солнце',
                            value: '18.6',
                            unit: 'W',
                            icon: Icons.wb_sunny_outlined,
                            color: Colors.yellowAccent,
                            subtitle: 'Генерация',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: StatCard(
                            title: 'Батарея',
                            value: '94',
                            unit: '%',
                            icon: Icons.battery_charging_full,
                            color: AppTheme.secondaryColor,
                            subtitle: '22ч ост.',
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'История PM2.5',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          '24 часа',
                          style: TextStyle(color: Colors.white.withOpacity(0.5)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const AirQualityChart(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            selectedItemColor: AppTheme.primaryColor,
            unselectedItemColor: Colors.white.withOpacity(0.4),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.analytics_outlined), label: 'Stats'),
              BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'Settings'),
            ],
          ),
        ),
      ),
    );
  }
}
