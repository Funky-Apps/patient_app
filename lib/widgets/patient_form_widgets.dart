import 'package:flutter/material.dart';
import 'package:patient_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isRequired;
  final bool isPhone;
  final Widget? suffixIcon;
  final Function(String)? onChanged;

  const TextFieldWidget({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.isRequired = false,
    this.suffixIcon,
    this.isPhone = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderGray),
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: TextField(
            style: const TextStyle(fontSize: 12),
            textInputAction: TextInputAction.next,
            controller: controller,
            keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
            decoration: InputDecoration(
              hintText: hint,
              prefixText: isPhone ? '+49 ' : null,
              hintStyle:
                  const TextStyle(fontSize: 12, color: AppColors.hintGray),
              border: InputBorder.none,
              suffixIcon: suffixIcon,
            ),
            onChanged: isPhone
                ? (value) {
                    if (value.isNotEmpty && value[0] == '0') {
                      controller.text =
                          value.substring(1); // Remove the first character
                      controller.selection = TextSelection.fromPosition(
                        TextPosition(
                          offset:
                              controller.text.length, // Reset cursor position
                        ),
                      );
                    }
                  }
                : onChanged,
          ),
        ),
        // The label displayed on top of the border
        Positioned(
          left: 10,
          top: -2, // Move label a bit above for better readability
          child: Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  backgroundColor: Colors.white, // Ensure label is readable
                ),
              ),
              if (isRequired)
                const Text(
                  ' *',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    backgroundColor: Colors.white, // Match background
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class GenderSelector extends StatelessWidget {
  final String? selectedGender;
  final Function(String?) onGenderChange;

  const GenderSelector(
      {super.key, required this.selectedGender, required this.onGenderChange});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Gender: '),
        Radio(
          value: 'Male',
          groupValue: selectedGender,
          onChanged: onGenderChange,
        ),
        Text('Male'),
        Radio(
          value: 'Female',
          groupValue: selectedGender,
          onChanged: onGenderChange,
        ),
        Text('Female'),
        Radio(
          value: 'Other',
          groupValue: selectedGender,
          onChanged: onGenderChange,
        ),
        Text('Other'),
      ],
    );
  }
}

class MedicalConditionsSelector extends StatelessWidget {
  final List<String> selectedConditions;
  final Function(String, bool) onConditionChange;

  const MedicalConditionsSelector(
      {super.key,
      required this.selectedConditions,
      required this.onConditionChange});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: ['Diabetes', 'Hypertension', 'Heart Disease', 'Asthma']
          .map((condition) {
        return CheckboxListTile(
          title: Text(condition),
          value: selectedConditions.contains(condition),
          onChanged: (bool? value) {
            onConditionChange(condition, value!);
          },
        );
      }).toList(),
    );
  }
}

class MedicationSelector extends StatelessWidget {
  final String? selectedMedication;
  final Function(String?) onMedicationChange;

  const MedicationSelector(
      {super.key,
      required this.selectedMedication,
      required this.onMedicationChange});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Are you currently on any medication?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          children: [
            Radio(
              value: 'Yes',
              groupValue: selectedMedication,
              onChanged: onMedicationChange,
            ),
            Text('Yes'),
            Radio(
              value: 'No',
              groupValue: selectedMedication,
              onChanged: onMedicationChange,
            ),
            Text('No'),
          ],
        ),
        if (selectedMedication == 'Yes')
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFieldWidget(
              controller: TextEditingController(),
              label: 'If yes, list medications',
              hint: 'If yes, list medications',
            ),
          ),
      ],
    );
  }
}

class SurgeriesSelector extends StatelessWidget {
  final String? selectedSurgeries;
  final Function(String?) onSurgeriesChange;

  const SurgeriesSelector(
      {super.key,
      required this.selectedSurgeries,
      required this.onSurgeriesChange});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Have you had any surgeries in the past?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          children: [
            Radio(
              value: 'Yes',
              groupValue: selectedSurgeries,
              onChanged: onSurgeriesChange,
            ),
            Text('Yes'),
            Radio(
              value: 'No',
              groupValue: selectedSurgeries,
              onChanged: onSurgeriesChange,
            ),
            Text('No'),
          ],
        ),
        if (selectedSurgeries == 'Yes')
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFieldWidget(
              controller: TextEditingController(),
              label: 'If yes, specify type and date',
              hint: 'If yes, specify type and date',
            ),
          ),
      ],
    );
  }
}

class SymptomsSelector extends StatelessWidget {
  final List<String> selectedSymptoms;
  final Function(String, bool) onSymptomChange;

  const SymptomsSelector(
      {super.key,
      required this.selectedSymptoms,
      required this.onSymptomChange});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: ['Fever', 'Cough', 'Shortness of breath'].map((symptom) {
        return CheckboxListTile(
          title: Text(symptom),
          value: selectedSymptoms.contains(symptom),
          onChanged: (bool? value) {
            onSymptomChange(symptom, value!);
          },
        );
      }).toList(),
    );
  }
}

class PainLevelSelector extends StatelessWidget {
  final String? selectedPainLevel;
  final Function(String?) onPainLevelChange;

  const PainLevelSelector(
      {super.key,
      required this.selectedPainLevel,
      required this.onPainLevelChange});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Pain Level (Please indicate the pain level from 1-10:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        DropdownButton<String>(
          value: selectedPainLevel,
          onChanged: onPainLevelChange,
          items: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class LifestyleSelector extends StatelessWidget {
  final String? selectedSmoke;
  final String? selectedAlcohol;
  final String? selectedExercise;
  final String? selectedSleep;
  final Function(String, String?) onChange;

  const LifestyleSelector({
    Key? key,
    required this.selectedSmoke,
    required this.selectedAlcohol,
    required this.selectedExercise,
    required this.selectedSleep,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Do you smoke?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Radio(
              value: 'Yes',
              groupValue: selectedSmoke,
              onChanged: (value) => onChange('smoke', value),
            ),
            Text('Yes'),
            Radio(
              value: 'No',
              groupValue: selectedSmoke,
              onChanged: (value) => onChange('smoke', value),
            ),
            Text('No'),
          ],
        ),
        Row(
          children: [
            Text(
              'Do you consume alcohol?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Radio(
              value: 'Yes',
              groupValue: selectedAlcohol,
              onChanged: (value) => onChange('alcohol', value),
            ),
            Text('Yes'),
            Radio(
              value: 'No',
              groupValue: selectedAlcohol,
              onChanged: (value) => onChange('alcohol', value),
            ),
            Text('No'),
          ],
        ),
        Row(
          children: [
            Text(
              'Do you exercise regularly?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Radio(
              value: 'Yes',
              groupValue: selectedExercise,
              onChanged: (value) => onChange('exercise', value),
            ),
            Text('Yes'),
            Radio(
              value: 'No',
              groupValue: selectedExercise,
              onChanged: (value) => onChange('exercise', value),
            ),
            Text('No'),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How many hours do you sleep per night?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Radio(
                  value: '4-6',
                  groupValue: selectedSleep,
                  onChanged: (value) => onChange('sleep', value),
                ),
                Text('4-6 hours'),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: '6-8',
                  groupValue: selectedSleep,
                  onChanged: (value) => onChange('sleep', value),
                ),
                Text('6-8 hours'),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: '8+',
                  groupValue: selectedSleep,
                  onChanged: (value) => onChange('sleep', value),
                ),
                Text('8+ hours'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class EmailCheckbox extends StatelessWidget {
  final bool receiveEmail;
  final Function(bool?) onChange;

  const EmailCheckbox(
      {super.key, required this.receiveEmail, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
            'Would you like to receive health tips or appointment reminders via email?'),
        Checkbox(
          value: receiveEmail,
          onChanged: onChange,
        ),
      ],
    );
  }
}
