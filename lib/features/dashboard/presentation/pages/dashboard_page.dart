import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mali_parivar_app/features/dashboard/presentation/widgets/latest_jobs_section.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';
import '../widgets/category_grid.dart';
import '../widgets/top_services_section.dart';
import '../widgets/promotional_banner.dart';
// import '../widgets/dashboard_bottom_nav_bar.dart';
import '../widgets/user_slider_section.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(LoadDashboard());
  }

  @override
  Widget build(BuildContext context) {
  return Material( 
    color: const Color(0xFFF4F6F9),
    child: SafeArea(
      bottom: false,
      child:  BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF16A34A)),
            );
          }

          if (state is DashboardLoaded) {
            return CustomScrollView(
              slivers: [
                // ─── MODERN APP BAR ─────────────────────────────────────
                SliverAppBar(
                  expandedHeight: 80,
                  toolbarHeight: 8,
                  pinned: true, 
                  floating: false,
                  elevation: 0,
                  backgroundColor: const Color(0xFF0D6B2E),
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    // collapseMode: CollapseMode.pin,
                    background: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF064E1F), Color(0xFF16A34A)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Stack(
                        children: [
                          // Decorative blob top-right
                          Positioned(
                            top: -30,
                            right: -30,
                            child: Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withValues(alpha: 0.06),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: -20,
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withValues(alpha: 0.05),
                              ),
                            ),
                          ),
                          // Header content
                          SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Left: Greeting + Location
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              '🌿 ',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            Text(
                                              'नमस्ते, Rohan,',
                                              style: TextStyle(
                                                color: Colors.white.withValues(
                                                  alpha: 0.85,
                                                ),
                                                fontSize: 12.5,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on_rounded,
                                              size: 13,
                                              color: Color(0xFFA7F3D0),
                                            ),
                                            const SizedBox(width: 3),
                                            Text(
                                              'Indore, MP',
                                              style: TextStyle(
                                                color: Colors.white.withValues(
                                                  alpha: 0.75,
                                                ),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(width: 2),
                                            Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              size: 15,
                                              color: Colors.white.withValues(
                                                alpha: 0.60,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Right: Notification + Avatar
                                  Row(
                                    children: [
                                      // Notification bell with badge
                                      Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.white.withValues(
                                                alpha: 0.15,
                                              ),
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.white.withValues(
                                                  alpha: 0.25,
                                                ),
                                                width: 1,
                                              ),
                                            ),
                                            child: const Icon(
                                              Icons.notifications_outlined,
                                              color: Colors.white,
                                              size: 19,
                                            ),
                                          ),
                                          Positioned(
                                            top: -2,
                                            right: -2,
                                            child: Container(
                                              width: 16,
                                              height: 16,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(255, 249, 22, 22),
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: const Color(
                                                    0xFF064E1F,
                                                  ),
                                                  width: 0.5,
                                                ),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  '30',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 7,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(width: 12),

                                      // User Avatar
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: const Color(0xFFA7F3D0),
                                          border: Border.all(
                                            color: Colors.white.withValues(
                                              alpha: 0.50,
                                            ),
                                            width: 2,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withValues(
                                                alpha: 0.20,
                                              ),
                                              blurRadius: 8,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'R',
                                            style: TextStyle(
                                              color: Color(0xFF064E1F),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // ─── SEARCH BAR ──────────────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                    child: Container(
                      height: 52,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.10),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search_rounded,
                            color: Color(0xFF16A34A),
                            size: 22,
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: TextField(
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF1E293B),
                              ),
                              decoration: InputDecoration(
                                hintText: 'सेवाएं, नौकरियां, सदस्य खोजें...',
                                hintStyle: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFFB0BAC7),
                                ),
                                border: InputBorder.none,
                                isCollapsed: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFF16A34A,
                              ).withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.mic_none_rounded,
                              size: 20,
                              color: Color(0xFF16A34A),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // ─── USER SLIDER ─────────────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 24),
                    child: const UserSliderSection(),
                  ),
                ),

                // ─── BODY CONTENT ────────────────────────────────────────
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      // Categories
                      CategoryGrid(categories: state.data.categories),

                      const SizedBox(height: 28),

                      // Section: Top Services
                      _SectionHeader(title: "Top Services", onSeeAll: () {}),
                      const SizedBox(height: 14),
                      TopServicesSection(services: state.data.services),

                      const SizedBox(height: 28),

                      // Section: Latest Jobs
                      _SectionHeader(title: "Latest Jobs", onSeeAll: () {}),
                      const SizedBox(height: 14),
                      LatestJobsSection(jobs: state.data.jobs),

                      const SizedBox(height: 28),

                      // Promo Banner
                      const PromotionalBanner(),
                    ]),
                  ),
                ),
              ],
            );
          }

          if (state is DashboardError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    )
    );
  }
}

// ─── Section Header Widget ────────────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;

  const _SectionHeader({required this.title, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),
        GestureDetector(
          onTap: onSeeAll,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFF16A34A).withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "See All",
              style: TextStyle(
                color: Color(0xFF16A34A),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
