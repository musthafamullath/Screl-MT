// ignore_for_file: avoid_print

import 'package:email_campaign_app/models/form_data.dart';
import 'package:email_campaign_app/viewmodels/form_notifier.dart';
import 'package:email_campaign_app/viewmodels/form_viewmodel.dart';
import 'package:email_campaign_app/widgets/input_switch.dart';
import 'package:email_campaign_app/widgets/input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewFromDetails extends ConsumerWidget {
  ViewFromDetails({super.key});

  final TextEditingController prevTextController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPhone = MediaQuery.of(context).size.width <= 600;
    final currentStep = ref.watch(formStepsProvider
        .select((state) => state.indexWhere((step) => step.isActive) + 1));
    final formData = ref.watch(formsProvider);
    final currentFormData = formData[currentStep] ?? FormData();
    final campaignSteps = ref.watch(formStepsProvider);

    prevTextController.text = currentFormData.prevText ?? '';
    subjectController.text = currentFormData.sub ?? '';
    nameController.text = currentFormData.name ?? '';
    emailController.text = currentFormData.email ?? '';

    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.circular(9),
      ),
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Spacer(
              flex: isPhone ? 1 : 2,
            ),
            isPhone
                ? SizedBox(
                    height: 50,
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 10,
                          height: 10,
                        );
                      },
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: campaignSteps.length,
                      itemBuilder: (BuildContext context, int index) {
                        final step = campaignSteps[index];
                        return Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: step.isActive
                                  ? null
                                  : Border.all(
                                      width: 0.5,
                                      color: step.isCompleted
                                          ? const Color.fromARGB(
                                              255, 213, 97, 2)
                                          : const Color.fromARGB(
                                              255, 39, 39, 39),
                                    )),
                          child: CircleAvatar(
                            backgroundColor: step.isActive
                                ? const Color.fromARGB(255, 213, 97, 2)
                                : const Color.fromRGBO(255, 255, 255, 1),
                            child: Text(
                              "${step.stepNumber}",
                              style: step.isActive
                                  ? const TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                    )
                                  : TextStyle(
                                      color:
                                          const Color.fromARGB(255, 39, 39, 39)
                                              .withOpacity(0.5)),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const SizedBox(),
            Spacer(flex: isPhone ? 1 : 1),
            const Text(
              'Create New Email Campaign',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
            const Text(
              'Fill out these details to build your broadcast',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Color.fromARGB(255, 200, 200, 200),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            InputText(
              hintText: ' Enter Subject',
              labelText: 'Campaign Subject',
              controller: subjectController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  ('Campaign Subject', value);
                }

                if (!RegExp(r"^[a-zA-Z0-9 .,!?'\-]{5,50}$")
                    .hasMatch(value!.trim())) {
                  return 'Subject must be 5-50 characters and can include letters, numbers, spaces, and basic punctuation.';
                }

                return null;
              },
            ),
            InputText(
              controller: prevTextController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  ('Preview text', value);
                }
                if (!RegExp(r'^.{1,50}$').hasMatch(value!)) {
                  return 'Preview text must not exceed 50 characters.';
                }
                return null;
              },
              hintText: ' Enter text here',
              labelText: 'Preview text',
              isDescription: true,
              descriptionText: 'keep this simple of 50 characters',
              maxLine: 5,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InputText(
                    controller: nameController,
                    hintText: ' From Anne',
                    labelText: '"From" Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        ('"From" Name', value);
                      }
                      if (!RegExp(r"^[a-zA-Z .'-]{2,50}$").hasMatch(value!)) {
                        return 'Name must be 2-50 characters long and contain only letters, spaces, and punctuation.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: InputText(
                    controller: emailController,
                    hintText: ' Anne@example.com',
                    labelText: '"From" Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        ('Email is required.', value);
                      }
                      final emailRegExp =
                          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                      if (!emailRegExp.hasMatch(value!)) {
                        return 'Invalid email address.';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 0.5,
              color: Colors.black26,
            ),
            InputSwitch(
              label: 'Run only once per customer',
              value: currentFormData.runFristTime,
              onChanged: (newValue) {
                ref.read(formsProvider.notifier).updateFormStep(
                      currentStep,
                      sub: subjectController.text,
                      prevText: prevTextController.text,
                      name: nameController.text,
                      email: emailController.text,
                      runFristTime: newValue,
                      cAudience: currentFormData.cAudience,
                    );
              },
            ),
            const Spacer(),
            InputSwitch(
              label: 'Custom audience',
              value: currentFormData.cAudience,
              onChanged: (newValue) {
                ref.read(formsProvider.notifier).updateFormStep(
                      currentStep,
                      sub: subjectController.text,
                      prevText: prevTextController.text,
                      name: nameController.text,
                      email: emailController.text,
                      runFristTime: currentFormData.runFristTime,
                      cAudience: newValue,
                    );
              },
            ),
            const Spacer(flex: 2),
            Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(text: 'You can set up a'),
                    TextSpan(
                      text:
                          ' custom domain or connect your email service provider',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: const Color.fromARGB(255, 213, 97, 2),
                          ),
                    ),
                    const TextSpan(text: ' to change this'),
                  ],
                ),
              ),
            ),
            const Spacer(flex: 2),
            const Divider(
              thickness: 0.5,
              color: Colors.black26,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 37,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color.fromARGB(255, 213, 97, 2),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ref.read(formsProvider.notifier).updateFormStep(
                              currentStep,
                              sub: subjectController.text,
                              prevText: prevTextController.text,
                              name: nameController.text,
                              email: emailController.text,
                              runFristTime: currentFormData.runFristTime,
                              cAudience: currentFormData.cAudience,
                            );
                        ref.read(formsProvider.notifier).saveDraft(currentStep);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Row(
                              children: [
                                Icon(Icons.check_circle, color: Colors.white),
                                SizedBox(width: 8),
                                Text('Draft saved successfully!',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                            backgroundColor: Colors.green,
                            duration: const Duration(seconds: 3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.all(16),
                            elevation: 10,
                            action: SnackBarAction(
                              label: 'Undo',
                              textColor: Colors.white,
                              onPressed: () {
                                print('Undo pressed');
                              },
                            ),
                          ),
                        );
                      }
                    },
                    child: Text(
                      'Save Draft',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: const Color.fromARGB(255, 213, 97, 2),
                          ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 63,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 213, 97, 2),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();

                        ref.read(formsProvider.notifier).updateFormStep(
                              currentStep,
                              sub: subjectController.text,
                              prevText: prevTextController.text,
                              name: nameController.text,
                              email: emailController.text,
                              runFristTime: currentFormData.runFristTime,
                              cAudience: currentFormData.cAudience,
                            );

                        if (currentStep == 5) {
                          ref.read(formsProvider.notifier).completeForm();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Row(
                                children: [
                                  Icon(Icons.check_circle, color: Colors.white),
                                  SizedBox(width: 8),
                                  Text(
                                    'Campaign creation successful! Check console for data.',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              backgroundColor: Colors.blue,
                              duration: const Duration(seconds: 3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.all(16),
                              elevation: 10,
                              action: SnackBarAction(
                                label: 'Close',
                                textColor: Colors.white,
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                },
                              ),
                            ),
                          );
                        } else {
                          ref
                              .read(formStepsProvider.notifier)
                              .markStepCompleted();
                        }
                      }
                    },
                    child: Text(currentStep == 5 ? 'Complete' : 'Next Step'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
