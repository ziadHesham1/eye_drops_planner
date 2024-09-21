import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/app_colors.dart';
import '../../new_eye_drop/logic/eye_drop_cubit.dart';
import '../../new_eye_drop/presentation/new_eye_drop_screen.dart';
import 'widgets/eye_drop_item_widget.dart';

class EyeDropsListScreen extends StatelessWidget {
  const EyeDropsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eye Drop List'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.read<EyeDropsCubit>().onClearEyeDrops();
            },
            icon: const Icon(
              Icons.delete,
              color: AppColors.error300,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<EyeDropsCubit, EyeDropsState>(
          builder: (context, state) {
            var eyeDropsList = state.eyeDropsListModel.items;
            return Padding(
              padding: EdgeInsets.only(top: 40.h),
              child: ListView(
                children: eyeDropsList.map(
                  (entry) {
                    return Column(
                      children: [
                        EyeDropItemWidget(eyeDrop: entry),
                        SizedBox(height: 20.h)
                      ],
                    );
                  },
                ).toList(),
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
