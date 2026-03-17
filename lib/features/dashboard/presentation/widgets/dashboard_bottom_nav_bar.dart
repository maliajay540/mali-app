import 'package:flutter/material.dart';

class DashboardBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const DashboardBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final List<_NavItem> _items = const [
    _NavItem(Icons.home_rounded, "Home"),
    _NavItem(Icons.grid_view_rounded, "Services"),
    _NavItem(Icons.favorite_rounded, "Matrimony"),
    _NavItem(Icons.work_rounded, "Jobs"),
    _NavItem(Icons.person_rounded, "Profile"),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_items.length, (index) {
            final isSelected = currentIndex == index;

            return GestureDetector(
              onTap: () => onTap(index), // 👈 IMPORTANT
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF16A34A).withOpacity(0.12)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedScale(
                      scale: isSelected ? 1.2 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        _items[index].icon,
                        size: 24,
                        color: isSelected
                            ? const Color(0xFF16A34A)
                            : const Color(0xFF94A3B8),
                      ),
                    ),
                    const SizedBox(height: 4),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: isSelected ? 1 : 0.6,
                      child: Text(
                        _items[index].label,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: isSelected
                              ? const Color(0xFF16A34A)
                              : const Color(0xFF94A3B8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;

  const _NavItem(this.icon, this.label);
}