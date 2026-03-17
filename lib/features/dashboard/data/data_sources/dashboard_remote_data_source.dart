abstract class DashboardRemoteDataSource {
  Future<Map<String, dynamic>> fetchDashboardData();
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  @override
  Future<Map<String, dynamic>> fetchDashboardData() async {
    await Future.delayed(const Duration(seconds: 1));

    return {
      "categories": [
        "Jobs",
        "Garden Services",
        "Decoration",
        "Nursery",
        "Matrimony",
        "Skilled Workers",
        "Training",
        "Community",
      ],
      "services": ["Service 1", "Service 2", "Service 3"],
      "jobs": ["Job 1", "Job 2", "Job 3"],
    };
  }
}
