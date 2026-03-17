import 'package:flutter/material.dart';
import '../../domain/entities/dashboard_entity.dart';
import 'category_model.dart';

class DashboardModel extends DashboardEntity {
  DashboardModel({
    required super.categories,
    required super.services,
    required super.jobs,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      categories: (json['categories'] as List).map((categoryName) {
        return CategoryModel(
          title: categoryName.toString(),
          icon: _getIconForCategory(categoryName.toString()),
        );
      }).toList(),
      services: List<String>.from(json['services']),
      jobs: List<String>.from(json['jobs']),
    );
  }

  static IconData _getIconForCategory(String title) {
  switch (title.toLowerCase()) {

    case 'jobs':
      return Icons.work_outline_rounded;

    case 'garden services':
      return Icons.yard_outlined;

    case 'decoration':
      return Icons.celebration_outlined;

    case 'nursery':
      return Icons.local_florist_outlined;

    case 'matrimony':
      return Icons.favorite_border_rounded;

    case 'skilled workers':
      return Icons.handyman_outlined;

    case 'training':
      return Icons.school_outlined;

    case 'community':
      return Icons.groups_outlined;

    default:
      return Icons.category_outlined;
  }

  }
}
