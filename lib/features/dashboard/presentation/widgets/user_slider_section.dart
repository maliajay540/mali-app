import 'dart:async';
import 'package:flutter/material.dart';

/// Auto-sliding promotional banner carousel.
/// Replaces the old "हमारे सदस्य" user profile slider.
class UserSliderSection extends StatefulWidget {
  const UserSliderSection({super.key});

  @override
  State<UserSliderSection> createState() => _UserSliderSectionState();
}

class _UserSliderSectionState extends State<UserSliderSection> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  Timer? _timer;

  // ── Banner data ─────────────────────────────────────────────────────────────
  static const List<_BannerData> _banners = [
    _BannerData(
      title: 'माली परिवार में आपका स्वागत है!',
      subtitle: 'समाज की एकता, हमारी ताकत',
      gradientStart: Color(0xFF0D6B2E),
      gradientEnd: Color(0xFF22C55E),
      icon: Icons.diversity_3_rounded,
    ),
    _BannerData(
      title: 'रोजगार के नए अवसर',
      subtitle: 'अपनी योग्यता के अनुसार नौकरी खोजें',
      gradientStart: Color(0xFF1D4ED8),
      gradientEnd: Color(0xFF38BDF8),
      icon: Icons.work_outline_rounded,
    ),
    _BannerData(
      title: 'विवाह वर-वधू परिचय',
      subtitle: 'योग्य जीवनसाथी खोजें — माली समाज में',
      gradientStart: Color(0xFFBE185D),
      gradientEnd: Color(0xFFF472B6),
      icon: Icons.favorite_outline_rounded,
    ),
    _BannerData(
      title: 'व्यापार & सेवाएं',
      subtitle: 'समाज के व्यापारियों से जुड़ें',
      gradientStart: Color(0xFF92400E),
      gradientEnd: Color(0xFFFBBF24),
      icon: Icons.store_outlined,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      final next = (_currentPage + 1) % _banners.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Banner Slider ──────────────────────────────────────────────────────
        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _controller,
            itemCount: _banners.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (context, index) {
              return _BannerCard(banner: _banners[index]);
            },
          ),
        ),

        const SizedBox(height: 10),

        // ── Dot Indicators ────────────────────────────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_banners.length, (i) {
            final isActive = i == _currentPage;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 22 : 7,
              height: 7,
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(0xFF16A34A)
                    : const Color(0xFF16A34A).withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}

// ── Single Banner Card ────────────────────────────────────────────────────────
class _BannerCard extends StatelessWidget {
  final _BannerData banner;
  const _BannerCard({required this.banner});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [banner.gradientStart, banner.gradientEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: banner.gradientEnd.withValues(alpha: 0.40),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background decorative circle
            Positioned(
              right: -24,
              top: -24,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),
            Positioned(
              right: 20,
              bottom: -30,
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.06),
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
              child: Row(
                children: [
                  // Text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          banner.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          banner.subtitle,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.22),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.40),
                              width: 1,
                            ),
                          ),
                          child: const Text(
                            'अभी देखें →',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Icon
                  Icon(
                    banner.icon,
                    size: 70,
                    color: Colors.white.withValues(alpha: 0.25),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Banner Data Model ─────────────────────────────────────────────────────────
class _BannerData {
  final String title;
  final String subtitle;
  final Color gradientStart;
  final Color gradientEnd;
  final IconData icon;

  const _BannerData({
    required this.title,
    required this.subtitle,
    required this.gradientStart,
    required this.gradientEnd,
    required this.icon,
  });
}
