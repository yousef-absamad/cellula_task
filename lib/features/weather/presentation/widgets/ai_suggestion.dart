import 'package:cellula_task/core/styles/app_colors.dart';
import 'package:cellula_task/core/styles/app_text_styels.dart';
import 'package:cellula_task/features/ai_suggestion/presentation/controller/suggestion_cubit.dart';
import 'package:cellula_task/features/ai_suggestion/presentation/controller/suggestion_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AISuggestion extends StatelessWidget {
  const AISuggestion({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: BlocBuilder<SuggestionCubit, SuggestionState>(
        builder: (context, state) {
          if (state is SuggestionLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          } else if (state is SuggestionError) {
           
          }
          if (state is SuggestionLoaded) {
            return FloatingActionButton.extended(
              backgroundColor: AppColors.primary,
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.blue.shade100,
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (context) => Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "AI Suggestion",
                          style: AppTextStyles.headerStyle.copyWith(
                            color: AppColors.secondary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          state.message,
                          style: AppTextStyles.primaryStyle.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              label: const Text("Should I go outside?"),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
