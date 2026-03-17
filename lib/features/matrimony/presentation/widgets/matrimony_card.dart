// presentation/widgets/matrimony_card.dart

import 'package:flutter/material.dart';
import '../../domain/entities/matrimony_profile_entity.dart';

class MatrimonyCard extends StatelessWidget {
  final MatrimonyProfileEntity profile;

  const MatrimonyCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: ListTile(
        title: Text(profile.name),
        subtitle: Text("${profile.age}, ${profile.city}"),
        trailing: ElevatedButton(
          onPressed: () {},
          child: const Text("View"),
        ),
      ),
    );
  }
}