import 'package:email_campaign_app/models/form_step_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final formStepsProvider =
    StateNotifierProvider<FormViewmodel, List<FormStepModel>>(
        (ref) => FormViewmodel());

class FormViewmodel extends StateNotifier<List<FormStepModel>> {
  FormViewmodel()
      : super([
          const FormStepModel(
            title: 'Create New Campaign',
            label: 'Fill out these details and get your campaign ready',
            stepNumber: 1,
            isActive: true,
          ),
          const FormStepModel(
            title: 'Create Segments',
            label: 'Get full control over your audience',
            stepNumber: 2,
          ),
          const FormStepModel(
            title: 'Bidding Strategy',
            label: 'Optmize your campaign reach with adsensel',
            stepNumber: 3,
          ),
          const FormStepModel(
            title: 'Site Links',
            label: 'Setup your customer journey flow',
            stepNumber: 4,
          ),
          const FormStepModel(
            title: 'Review Campaign',
            label: 'Double check your campaign is ready to go!',
            stepNumber: 5,
          ),
        ]);

  void markStepCompleted() {
    final stepCatchIndex = state.indexWhere((step) => step.isActive);
    if (stepCatchIndex < state.length - 1) {
      state = [
        for (var i = 0; i < state.length; i++)
          if (i == stepCatchIndex)
            state[i].copyWith(isActive: false, isCompleted: true)
          else if (i == stepCatchIndex + 1)
            state[i].copyWith(isActive: true)
          else
            state[i]
      ];
    }
  }

  void goToAhead(int stepNumber) {
    if (stepNumber <= getCurrentStep() + 1) {
      state = [
        for (var step in state)
          if (step.stepNumber == stepNumber)
            step.copyWith(isActive: true)
          else if (step.stepNumber < stepNumber)
            step.copyWith(isCompleted: true, isActive: false)
          else
            step.copyWith(isActive: false)
      ];
    }
  }

  int getCurrentStep() {
    return state.indexWhere((step) => step.isActive);
  }
}
