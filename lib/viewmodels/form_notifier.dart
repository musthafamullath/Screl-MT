import 'dart:convert';

import 'package:email_campaign_app/models/form_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final formsProvider =
    StateNotifierProvider<FormNotifier, Map<int, FormData>>((ref) {
  return FormNotifier();
});

class FormNotifier extends StateNotifier<Map<int, FormData>> {
  FormNotifier() : super({}) {
    laodBase();
  }

  Future<void> laodBase() async {
    final box = await Hive.openBox<Map<dynamic, dynamic>>('form_data');
    final dataCached = box.get('all_forms');
    if (dataCached != null) {
      state = Map.from(
        dataCached.map(
          (key, value) => MapEntry(
            int.parse(key.toString()),
            FormData(
              sub: value['sub'],
              prevText: value['prevText'],
              name: value['name'],
              email: value['email'],
              runFristTime: value['runFristTime'],
              cAudience: value['cAudience'],
              currentStep: value['currentStep'],
            ),
          ),
        ),
      );
    }
  }

  Future<void> saveToBase() async {
    final box = await Hive.openBox<Map<dynamic, dynamic>>('form_data');
    final dataToSave =
        state.map((key, value) => MapEntry(key.toString(), value.toJson()));
    await box.put('all_forms', dataToSave);
  }

  void updateFormStep(
    int step, {
    String? sub,
    String? prevText,
    String? name,
    String? email,
    bool? runFristTime,
    bool? cAudience,
  }) {
    final currentFormData = state[step] ?? FormData();
    state = {
      ...state,
      step: currentFormData.copyWith(
        sub: sub ?? currentFormData.sub,
        prevText: prevText ?? currentFormData.prevText,
        name: name ?? currentFormData.name,
        email: email ?? currentFormData.email,
        runFristTime: runFristTime ?? currentFormData.runFristTime,
        cAudience: cAudience ?? currentFormData.cAudience,
        currentStep: step,
      ),
    };
    saveToBase();
  }

  void saveDraft(int step) {
    saveToBase();
  }

  void completeForm() {
    final allFormData = state.map(
      (key, value) => MapEntry(
        'Step $key',
        value.toJson(),
      ),
    );
    debugPrint(
      const JsonEncoder.withIndent('  ').convert(allFormData),
    );
  }
}
