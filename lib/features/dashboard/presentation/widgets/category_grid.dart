import 'package:flutter/material.dart';
import 'package:mali_parivar_app/features/dashboard/data/models/category_model.dart';

class CategoryGrid extends StatefulWidget {
  final List<CategoryModel> categories;

  const CategoryGrid({super.key, required this.categories});

  @override
  State<CategoryGrid> createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {
  bool _expanded = false;

  static const int _visibleCount = 7;

  static const List<Color> _bgColors = [
    Color(0xFFDCFCE7),
    Color(0xFFDBEAFE),
    Color(0xFFFEF9C3),
    Color(0xFFFCE7F3),
    Color(0xFFEDE9FE),
    Color(0xFFFFEDD5),
    Color(0xFFD1FAE5),
    Color(0xFFFFE4E6),
  ];

  static const List<Color> _iconColors = [
    Color(0xFF16A34A),
    Color(0xFF2563EB),
    Color(0xFFCA8A04),
    Color(0xFFDB2777),
    Color(0xFF7C3AED),
    Color(0xFFEA580C),
    Color(0xFF059669),
    Color(0xFFE11D48),
  ];

  @override
  Widget build(BuildContext context) {
    final all = widget.categories;
    final hasMore = all.length > _visibleCount;

    // How many category tiles to show
    final showCount = _expanded
        ? all.length
        : (hasMore ? _visibleCount : all.length);

    // Total = category tiles + 1 action button (always at the end)
    final totalTiles = hasMore ? showCount + 1 : showCount;

    return AnimatedSize(
      duration: const Duration(milliseconds: 380),
      curve: Curves.easeInOut,
      alignment: Alignment.topCenter,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: totalTiles,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 0.82,
        ),
        itemBuilder: (context, index) {
          // Last tile is always the action button
          if (hasMore && index == totalTiles - 1) {
            return _ActionTile(
              expanded: _expanded,
              onTap: () => setState(() => _expanded = !_expanded),
            );
          }

          final category = all[index];
          final bgColor = _bgColors[index % _bgColors.length];
          final iconColor = _iconColors[index % _iconColors.length];

          return GestureDetector(
            onTap: () {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: bgColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: iconColor.withValues(alpha: 0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(category.icon, size: 24, color: iconColor),
                ),
                const SizedBox(height: 7),
                Text(
                  category.title,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF374151),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ── Expand / Collapse tile ────────────────────────────────────────────────────
class _ActionTile extends StatelessWidget {
  final bool expanded;
  final VoidCallback onTap;

  const _ActionTile({required this.expanded, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: expanded
                    ? [const Color(0xFF475569), const Color(0xFF94A3B8)]
                    : [const Color(0xFF064E1F), const Color(0xFF16A34A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color:
                      (expanded
                              ? const Color(0xFF64748B)
                              : const Color(0xFF16A34A))
                          .withValues(alpha: 0.30),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: AnimatedRotation(
              turns: expanded ? 0.5 : 0,
              duration: const Duration(milliseconds: 350),
              child: const Icon(
                Icons.expand_more_rounded,
                size: 26,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 7),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Text(
              expanded ? 'Less' : 'More',
              key: ValueKey(expanded),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: expanded
                    ? const Color(0xFF64748B)
                    : const Color(0xFF16A34A),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
