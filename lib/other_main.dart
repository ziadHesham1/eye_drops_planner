import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

// Settings Cubit - Manages user name
class SettingsCubit extends Cubit<String> {
  SettingsCubit() : super("User");

  Timer? _debounce;

  void setUserName(String name) {
    // Debounce user input to reduce frequent state changes
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      emit(name);
    });
  }
}

// EyeDrops Cubit - Manages a list of eye drops
class EyeDropsCubit extends Cubit<List<String>> {
  EyeDropsCubit() : super(["Drop A", "Drop B"]);

  void setEyeDrops(List<String> drops) {
    emit(drops);
  }
}

// Schedule Cubit - Generates the schedule based on user name and eye drops
class ScheduleCubit extends Cubit<List<String>> {
  ScheduleCubit() : super([]);

  // Memoization for caching
  List<String>? _cachedSchedule;

  Future<void> generateSchedule(String userName, List<String> eyeDrops) async {
    // Offload heavy processing to an isolate
    final schedule = await compute(_processSchedule, [eyeDrops, userName]);
    _cachedSchedule = schedule;
    emit(schedule);
  }
}

// Function to offload heavy schedule generation to isolate (background thread)
List<String> _processSchedule(List<dynamic> params) {
  List<String> eyeDrops = params[0];
  String userName = params[1];
  return eyeDrops.map((drop) => "$drop for $userName").toList();
}

// Main App
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SettingsCubit()),
        BlocProvider(create: (context) => EyeDropsCubit()),
        BlocProvider(create: (context) => ScheduleCubit()),
      ],
      child: const MaterialApp(
        home: ScheduleScreen(),
      ),
    );
  }
}

// Schedule Screen
class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
      ),
      body: Column(
        children: [
          // User Name Input with debouncing
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<SettingsCubit, String>(
              buildWhen: (previous, current) =>
                  previous != current, // Selective rebuild
              builder: (context, userName) {
                return TextField(
                  decoration:
                      const InputDecoration(labelText: "Enter your name"),
                  onChanged: (value) => BlocProvider.of<SettingsCubit>(context)
                      .setUserName(value),
                );
              },
            ),
          ),
          // Eye Drops Input
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<EyeDropsCubit, List<String>>(
              builder: (context, eyeDrops) {
                return TextField(
                  decoration: const InputDecoration(
                      labelText: "Enter eye drops (comma separated)"),
                  onSubmitted: (value) {
                    final drops =
                        value.split(',').map((e) => e.trim()).toList();
                    BlocProvider.of<EyeDropsCubit>(context).setEyeDrops(drops);
                  },
                );
              },
            ),
          ),
          // Schedule Display
          Expanded(
            child: MultiBlocListener(
              listeners: [
                BlocListener<SettingsCubit, String>(
                  listener: (context, userName) {
                    final eyeDrops =
                        BlocProvider.of<EyeDropsCubit>(context).state;
                    BlocProvider.of<ScheduleCubit>(context)
                        .generateSchedule(userName, eyeDrops);
                  },
                ),
                BlocListener<EyeDropsCubit, List<String>>(
                  listener: (context, eyeDrops) {
                    final userName =
                        BlocProvider.of<SettingsCubit>(context).state;
                    BlocProvider.of<ScheduleCubit>(context)
                        .generateSchedule(userName, eyeDrops);
                  },
                ),
              ],
              child: BlocBuilder<ScheduleCubit, List<String>>(
                builder: (context, schedule) {
                  if (schedule.isEmpty) {
                    return const Center(child: Text('No schedule available'));
                  }
                  return ListView.builder(
                    itemCount: schedule.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(schedule[index]),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
