// presentation/pages/matrimony_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/matrimony_bloc.dart';
import '../bloc/matrimony_event.dart';
import '../bloc/matrimony_state.dart';
import '../widgets/matrimony_card.dart';

class MatrimonyPage extends StatefulWidget {
  const MatrimonyPage({super.key});

  @override
  State<MatrimonyPage> createState() => _MatrimonyPageState();
}

class _MatrimonyPageState extends State<MatrimonyPage> {
  @override
  void initState() {
    super.initState();
    context.read<MatrimonyBloc>().add(LoadProfiles());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Matrimony")),
      body: BlocBuilder<MatrimonyBloc, MatrimonyState>(
        builder: (context, state) {
          if (state is MatrimonyLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MatrimonyLoaded) {
            return ListView.builder(
              itemCount: state.profiles.length,
              itemBuilder: (context, index) {
                return MatrimonyCard(profile: state.profiles[index]);
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}