// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
part 'form_data.g.dart';

@HiveType(typeId: 1)
class FormData extends HiveObject {
  @HiveField(0)
  String? sub;

  @HiveField(1)
  String? prevText;

  @HiveField(2)
  String? name;

  @HiveField(3)
  String? email;

  @HiveField(4)
  bool runFristTime;

  @HiveField(5)
  bool cAudience;

  @HiveField(6)
  int currentStep;

  FormData({
    this.sub,
    this.prevText,
    this.name,
    this.email,
    this.runFristTime = false,
    this.cAudience = false,
    this.currentStep = 1,
  });

  FormData copyWith({
    String? sub,
    String? prevText,
    String? name,
    String? email,
    bool? runFristTime,
    bool? cAudience,
    int? currentStep,
  }) {
    return FormData(
      sub: sub ?? this.sub,
      prevText: prevText ?? this.prevText,
      name: name ?? this.name,
      email: email ?? this.email,
      runFristTime: runFristTime ?? this.runFristTime,
      cAudience: cAudience ?? this.cAudience,
      currentStep: currentStep ?? this.currentStep,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sub': sub,
      'prevText': prevText,
      'name': name,
      'email': email,
      'runFristTime': runFristTime,
      'cAudience': cAudience,
      'currentStep': currentStep,
    };
  }
}
