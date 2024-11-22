import 'package:email_campaign_app/viewmodels/form_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class Sidebar extends ConsumerWidget {
  const Sidebar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formSteps = ref.watch(formStepsProvider);

    return Container(
      width: 350,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: formSteps.length,
            itemBuilder: (BuildContext context, int index) {
              final step = formSteps[index];
              return ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: step.isActive
                        ? null
                        : Border.all(
                            width: 0.5,
                            color: step.isCompleted
                                ? const Color.fromARGB(255, 213, 97, 2)
                                : const Color.fromARGB(255, 39, 39, 39),
                          ),
                  ),
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
                              color: const Color.fromARGB(255, 39, 39, 39)
                                  .withOpacity(0.5),
                            ),
                    ),
                  ),
                ),
                title: Text(
                  step.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.black54.withOpacity(0.75),
                  ).copyWith(
                    color: step.isActive
                        ? const Color.fromARGB(255, 213, 97, 2)
                        : const Color.fromARGB(255, 39, 39, 39),
                  ),
                ),
                subtitle: Text(
                  step.label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    color: Colors.black12.withOpacity(0.25),
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Need Help?',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black54.withOpacity(0.75)),
                ),
                const Text(
                  'Get to know how your compaign',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.black26),
                ),
                const Text(
                  'Can reach a wider audience',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.black26),
                ),
                const SizedBox(
                  height: 10,
                ),
                OutlinedButton(
                  onPressed: () {
                    _makePhoneCall(
                      '+918086404601',
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black, width: 0.5),
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: const Text(
                    'Contact Us',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _makePhoneCall(String phoneNumber) async {
    final Uri url = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
