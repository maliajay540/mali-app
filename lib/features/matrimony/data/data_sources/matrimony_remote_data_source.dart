// data/data_sources/matrimony_remote_data_source.dart

import '../models/matrimony_profile_model.dart';

abstract class MatrimonyRemoteDataSource {
  Future<List<MatrimonyProfileModel>> getProfiles();
}

class MatrimonyRemoteDataSourceImpl implements MatrimonyRemoteDataSource {
  @override
  Future<List<MatrimonyProfileModel>> getProfiles() async {
    // TODO: replace with real API
    await Future.delayed(const Duration(seconds: 1));

    return [
      MatrimonyProfileModel(
        id: "1",
        name: "Rahul Mali",
        age: 26,
        city: "Jammu",
        profession: "Software Engineer",
        image: "",
      ),
    ];
  }
}