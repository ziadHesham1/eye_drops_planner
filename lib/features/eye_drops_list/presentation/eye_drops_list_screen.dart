import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/app_colors.dart';
import '../../new_eye_drop/logic/eye_drop_cubit.dart';
import '../../new_eye_drop/presentation/new_eye_drop_screen.dart';
import 'widgets/eye_drop_item_widget.dart';

class EyeDropsListScreen extends StatelessWidget {
  const EyeDropsListScreen({super.key});

  Future<void> _confirmClear(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remove all prescriptions?'),
        content: const Text(
          'This deletes every eye drop you have configured. '
          'You can\'t undo this.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error300),
            child: const Text('Remove all'),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      context.read<EyeDropsCubit>().onClearEyeDrops();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eye Drops'),
        centerTitle: true,
        actions: [
          BlocBuilder<EyeDropsCubit, EyeDropsState>(
            buildWhen: (a, b) =>
                a.eyeDropsListModel.items.isEmpty !=
                b.eyeDropsListModel.items.isEmpty,
            builder: (context, state) {
              if (state.eyeDropsListModel.items.isEmpty) {
                return const SizedBox.shrink();
              }
              return IconButton(
                onPressed: () => _confirmClear(context),
                icon: const Icon(Icons.delete, color: AppColors.error300),
                tooltip: 'Remove all',
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<EyeDropsCubit, EyeDropsState>(
          builder: (context, state) {
            final items = state.eyeDropsListModel.items;
            if (items.isEmpty) {
              return const _EmptyListState();
            }
            return Padding(
              padding: EdgeInsets.only(top: 40.h),
              child: ListView(
                children: items
                    .map((entry) => Column(
                          children: [
                            EyeDropItemWidget(eyeDrop: entry),
                            SizedBox(height: 20.h),
                          ],
                        ))
                    .toList(),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewEyeDropScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _EmptyListState extends StatelessWidget {
  const _EmptyListState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.medication_outlined,
                size: 64, color: Colors.grey),
            SizedBox(height: 12.h),
            Text(
              'No prescriptions yet',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 6.h),
            const Text(
              'Tap + to add your first eye drop.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
