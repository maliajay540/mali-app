import 'package:flutter/material.dart';

class LatestJobsSection extends StatelessWidget {
  final List<String> jobs;

  const LatestJobsSection({super.key, required this.jobs});

  static const List<Color> _tagColors = [
    Color(0xFF16A34A),
    Color(0xFF2563EB),
    Color(0xFFD97706),
    Color(0xFFDB2777),
    Color(0xFF7C3AED),
  ];

  static const List<String> _jobTypes = [
    "Full Time",
    "Part Time",
    "Contract",
    "Freelance",
    "Internship",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          final color = _tagColors[index % _tagColors.length];
          final jobType = _jobTypes[index % _jobTypes.length];

          return Container(
            width: 190,
            margin: const EdgeInsets.only(right: 14),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Job type tag
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    jobType,
                    style: TextStyle(
                      color: color,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Job title
                Text(
                  jobs[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: Color(0xFF0F172A),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const Spacer(),

                // Location row
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 13,
                      color: Color(0xFF64748B),
                    ),
                    const SizedBox(width: 3),
                    const Text(
                      "Indore, MP",
                      style: TextStyle(color: Color(0xFF64748B), fontSize: 11),
                    ),
                    const Spacer(),
                    // Apply button
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "Apply",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
