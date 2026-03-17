import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart'; // Added for Google Fonts
import 'package:go_router/go_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  late final Animation<double> _progress;
  late final Animation<double> _logoTranslateY; // logo upar jayega
  late final Animation<double> _bottomTextFade; // built for text fade-in
  late final Animation<double>
  _bottomTextTranslateY; // subtle slide up for premium feel
  late final Animation<double> _middleTextFade; // New: middle text fade-in
  late final Animation<double>
  _middleTextScale; // New: middle text subtle scale
  Future<bool> checkLogin() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");

    return token != null && token.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      // ✅ TOP BAR visible + BOTTOM hide
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [SystemUiOverlay.top],
      );

      // ✅ Status bar styling
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      );
    });
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 4000,
      ), // Longer for premium, luxurious slow reveal
    );

    // Logo fade + scale with elegant overshoot
    _fade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.05,
        0.55,
        curve: Curves.easeInOutSine,
      ), // Smoother curve
    );

    _scale = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ), // Kept overshoot but adjusted begin for subtlety
    );

    // Progress bar starts slightly earlier for fluid transition
    _progress = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.6,
        1.0,
        curve: Curves.easeInOutQuint,
      ), // Premium quint curve for acceleration
    );

    // Logo shifts up smoothly
    _logoTranslateY = Tween<double>(begin: 0.0, end: -120.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.4,
          0.9,
          curve: Curves.easeOutExpo,
        ), // Adjusted for longer duration
      ),
    );

    // Bottom text fades in last
    _bottomTextFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.75, 1.0, curve: Curves.easeOutQuint),
    );

    // Bottom text subtle slide up
    _bottomTextTranslateY = Tween<double>(begin: 20.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.75, 1.0, curve: Curves.easeOutQuint),
      ),
    );

    // New: Middle text fade and scale (appears after logo moves up)
    _middleTextFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.55, 0.85, curve: Curves.easeOutQuint),
    );

    _middleTextScale = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.55, 0.85, curve: Curves.easeOutBack),
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 800), () async {
          if (!mounted) return;

          final isLoggedIn = await checkLogin();

          if (isLoggedIn) {
            context.go('/dashboard'); // ✅ user logged
          } else {
            context.go('/login'); // ❌ not logged
          }
        });
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    // Restore system UI overlays on dispose
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(
      context,
    ).size.width; // Responsive for modern design

    return Scaffold(
      backgroundColor: const Color(0xFFF3FBF6),
      body: Stack(
        // Removed SafeArea as immersive mode handles notches; adjust if needed
        children: [
          /// Subtle depth background with updated gradient for fresher, premium look
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(
                      0xFFE0F7FA,
                    ).withValues(alpha: 0.9), // Softer opacity for elegance
                    const Color(0xFFF3FBF6),
                  ],
                ),
              ),
            ),
          ),

          /// CENTER LOGO + ANIMATION (pehle aaye, phir upar jaye)
          Center(
            child: AnimatedBuilder(
              animation: _logoTranslateY,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _logoTranslateY.value),
                  child: child,
                );
              },
              child: FadeTransition(
                opacity: _fade,
                child: ScaleTransition(
                  scale: _scale,
                  child: Container(
                    padding: const EdgeInsets.all(
                      4,
                    ), // Slightly more padding for polish
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(
                            alpha: 0.04,
                          ), // Softer shadow
                          blurRadius: 50, // Larger blur for premium depth
                          offset: const Offset(0, 20),
                        ),
                        BoxShadow(
                          // Added inner glow for premium shine
                          color: const Color(0xFF16A34A).withValues(alpha: 0.1),
                          blurRadius: 20,
                          spreadRadius: -2, // Inner effect
                        ),
                      ],
                    ),
                    child: Image.asset(
                      "assets/images/Logo.png",
                      width:
                          screenWidth * 0.5, // Responsive for premium scaling
                    ),
                  ),
                ),
              ),
            ),
          ),

          /// NEW: PREMIUM MIDDLE TEXT (between logo and loading, matching the image)
          Positioned(
            bottom: 140, // Positioned above the loading bar
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _middleTextFade,
              child: ScaleTransition(
                scale: _middleTextScale,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Mali Parivar",
                        style: GoogleFonts.playfairDisplay(
                          // Elegant serif for premium feel
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF16A34A), // Brand green
                          letterSpacing: 1.2,
                          shadows: [
                            Shadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8), // Spacing for premium layout
                      Text(
                        "Together we Grow",
                        style: GoogleFonts.playfairDisplay(
                          // Matching font for consistency
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF475569), // Subtle slate
                          letterSpacing: 1.0,
                          shadows: [
                            Shadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// REFINED LOADING BAR (niche, logo upar jaane ke baad fill hoga)
          Positioned(
            bottom: 62,
            left: 32,
            right: 32, // Wider for modern full-width feel
            child: AnimatedBuilder(
              animation: _progress,
              builder: (context, child) {
                return Container(
                  height: 4, // Slightly thicker for visibility
                  decoration: BoxDecoration(
                    color: const Color(0xFFD1FAE5).withValues(
                      alpha: 0.7,
                    ), // Even softer track for premium subtlety
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      // Added shadow for depth
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: _progress.value,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            // Gradient for premium fill effect
                            colors: [Color(0xFF16A34A), Color(0xFF22C55E)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            // Enhanced glow on progress for modern effect
                            BoxShadow(
                              color: const Color(
                                0xFF16A34A,
                              ).withValues(alpha: 0.25),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          /// SABSE NICHE LINE → "Built for Mali Parivar" (premium touch)
          Positioned(
            bottom: 36,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _bottomTextTranslateY,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _bottomTextTranslateY.value),
                  child: FadeTransition(
                    opacity: _bottomTextFade,
                    child: Center(
                      child: Text(
                        "Exquisitely Crafted for Mali Parivar",
                        style: GoogleFonts.playfairDisplay(
                          // Switched to Playfair Display for elegant, premium serif typography
                          fontSize: 15, // Adjusted for premium readability
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF475569).withValues(
                            alpha: 0.9,
                          ), // Higher opacity for sophistication
                          letterSpacing:
                              1.2, // Wider spacing for premium typography
                          height: 1.3,
                          shadows: [
                            Shadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
