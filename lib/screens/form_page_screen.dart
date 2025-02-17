import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:patient_app/core/constants/app_colors.dart';
import '../core/widgets/round_button.dart';
import '../widgets/patient_form_widgets.dart'; // Ensure this import contains your custom widgets

class FormPageScreen extends StatefulWidget {
  final String doctorUid;

  const FormPageScreen({super.key, required this.doctorUid});

  @override
  _FormPageScreenState createState() => _FormPageScreenState();
}

class _FormPageScreenState extends State<FormPageScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emergencyContactController = TextEditingController();
  final TextEditingController _dietaryPreferencesController = TextEditingController();
  final TextEditingController _additionalConcernsController = TextEditingController();

  String? selectedGender = 'Male';
  List<String> selectedConditions = [];
  String? selectedMedication = 'No';
  String? selectedSurgeries = 'No';
  String? selectedAllergies = 'No';
  List<String> selectedSymptoms = [];
  String? selectedPainLevel;
  String? selectedTravel = 'No';
  String? selectedContactWithSickPerson = 'No';
  String? selectedSmoke = 'No';
  String? selectedAlcohol = 'No';
  String? selectedExercise = 'No';
  String? selectedSleep = '6-8';
  String? dietaryPreferences = '';
  String? additionalConcerns = '';
  bool receiveEmail = false;

  Future<void> _submitForm() async {
    try {
      await FirebaseFirestore.instance.collection('submissions').doc(_phoneController.text).set({
        'patient_name': _nameController.text,
        'dob': _dobController.text,
        'email': _emailController.text,
        'phone_number': _phoneController.text,
        'address': _addressController.text,
        'emergency_contact': _emergencyContactController.text,
        'gender': selectedGender,
        'conditions': selectedConditions,
        'medication': selectedMedication,
        'surgeries': selectedSurgeries,
        'allergies': selectedAllergies,
        'symptoms': selectedSymptoms,
        'pain_level': selectedPainLevel,
        'travel': selectedTravel,
        'contact_with_sick_person': selectedContactWithSickPerson,
        'smoke': selectedSmoke,
        'alcohol': selectedAlcohol,
        'exercise': selectedExercise,
        'sleep': selectedSleep,
        'dietary_preferences': dietaryPreferences,
        'additional_concerns': additionalConcerns,
        'receive_email': receiveEmail,
        'doctor_uid': widget.doctorUid,
        'submitted_at': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form submitted successfully!')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit form: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Patient Form',
            style: TextStyle(
                fontSize: 18,
                color: AppColors.blackColor,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: AppColors.loginScreenColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Replacing InputField with TextFieldWidget
                SizedBox(height: 10,),
                TextFieldWidget(
                  label: 'Full Name',
                  hint: 'Enter your full name',
                  controller: _nameController,
                ),
                SizedBox(height: 10,),
                TextFieldWidget(
                  label: 'Date of Birth',
                  hint: 'Enter your date of birth',
                  controller: _dobController,
                ),
                SizedBox(height: 10,),
                GenderSelector(
                  selectedGender: selectedGender,
                  onGenderChange: (value) => setState(() => selectedGender = value),
                ),
                SizedBox(height: 10,),
                TextFieldWidget(
                  label: 'Email',
                  hint: 'Enter your email address',
                  controller: _emailController,
                ),
                SizedBox(height: 10,),
                TextFieldWidget(
                  label: 'Phone Number',
                  hint: 'Enter your phone number',
                  controller: _phoneController,
                  isPhone: true,
                ),
                SizedBox(height: 10,),
                TextFieldWidget(
                  label: 'Address',
                  hint: 'Enter your address',
                  controller: _addressController,
                ),
                SizedBox(height: 10,),
                TextFieldWidget(
                  label: 'Emergency Contact Name & Phone',
                  hint: 'Enter emergency contact details',
                  controller: _emergencyContactController,
                ),
                SizedBox(height: 10,),
                MedicalConditionsSelector(
                  selectedConditions: selectedConditions,
                  onConditionChange: (condition, value) {
                    setState(() {
                      if (value) {
                        selectedConditions.add(condition);
                      } else {
                        selectedConditions.remove(condition);
                      }
                    });
                  },
                ),
                SizedBox(height: 10,),
                MedicationSelector(
                  selectedMedication: selectedMedication,
                  onMedicationChange: (value) => setState(() => selectedMedication = value),
                ),
                SizedBox(height: 10,),
                SurgeriesSelector(
                  selectedSurgeries: selectedSurgeries,
                  onSurgeriesChange: (value) => setState(() => selectedSurgeries = value),
                ),
                SizedBox(height: 10,),
                SymptomsSelector(
                  selectedSymptoms: selectedSymptoms,
                  onSymptomChange: (symptom, value) {
                    setState(() {
                      if (value) {
                        selectedSymptoms.add(symptom);
                      } else {
                        selectedSymptoms.remove(symptom);
                      }
                    });
                  },
                ),
                SizedBox(height: 10,),
                PainLevelSelector(
                  selectedPainLevel: selectedPainLevel,
                  onPainLevelChange: (value) => setState(() => selectedPainLevel = value),
                ),
                SizedBox(height: 10,),
                LifestyleSelector(
                  selectedSmoke: selectedSmoke,
                  selectedAlcohol: selectedAlcohol,
                  selectedExercise: selectedExercise,
                  selectedSleep: selectedSleep,
                  onChange: (field, value) {
                    setState(() {
                      switch (field) {
                        case 'smoke':
                          selectedSmoke = value;
                          break;
                        case 'alcohol':
                          selectedAlcohol = value;
                          break;
                        case 'exercise':
                          selectedExercise = value;
                          break;
                        case 'sleep':
                          selectedSleep = value;
                          break;
                      }
                    });
                  },
                ),
                SizedBox(height: 10,),
                TextFieldWidget(
                  label: 'Dietary Preferences/Restrictions',
                  hint: 'Enter your dietary preferences or restrictions',
                  controller: _dietaryPreferencesController,
                  onChanged: (value) => setState(() => dietaryPreferences = value),
                ),
                SizedBox(height: 10,),
                TextFieldWidget(
                  label: 'Do you have any specific concerns for the doctor?',
                  hint: 'Enter any concerns you might have',
                  controller: _additionalConcernsController,
                  onChanged: (value) => setState(() => additionalConcerns = value),
                ),
                SizedBox(height: 10,),
                EmailCheckbox(
                  receiveEmail: receiveEmail,
                  onChange: (value) => setState(() => receiveEmail = value!),
                ),
                SizedBox(height: 10,),
                // Submit Button with light blue background
                RoundButton(
                  label: 'Submit',
                  onPressed: _submitForm,
                  color: AppColors.lightBlueColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
