import '../../data/models/category_model.dart';

class DashboardEntity {
  final List<CategoryModel> categories;
  final List<String> services;
  final List<String> jobs;

  DashboardEntity({
    required this.categories,
    required this.services,
    required this.jobs,
  });
}
