import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:patient_app/core/constants/app_colors.dart';
import 'package:patient_app/core/widgets/round_button.dart';

class FormPageScreen extends StatefulWidget {
  final String doctorUid;

  const FormPageScreen({super.key, required this.doctorUid});

  @override
  _FormPageScreenState createState() => _FormPageScreenState();
}

class _FormPageScreenState extends State<FormPageScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? selectedAnswer1;
  String? selectedAnswer2;
  String? selectedAnswer3;
  String? selectedAnswer4;
  String? selectedAnswer5;

  Future<void> _submitForm() async {
    try {
      await FirebaseFirestore.instance.collection('submissions').doc(_phoneController.text).set({
        'patient_name': _nameController.text,
        'age': _ageController.text,
        'phone_number': _phoneController.text,
        'doctor_uid': widget.doctorUid,
        'do_you_have_allergies': selectedAnswer1,
        'do_you_have_chronic_diseases': selectedAnswer2,
        'do_you_smoke': selectedAnswer3,
        'do_you_have_high_blood_pressure': selectedAnswer4,
        'have_you_had_any_surgeries': selectedAnswer5,
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


  Widget _buildQuestion(
      String question, String? selectedValue, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question),
        Row(
          children: [
            Radio(
                value: 'Yes', groupValue: selectedValue, onChanged: onChanged),
            Text('Yes'),
            Radio(value: 'No', groupValue: selectedValue, onChanged: onChanged),
            Text('No'),
          ],
        ),
      ],
    );
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
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Patient Name'),
                ),
                TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Age'),
                ),
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                ),
                SizedBox(height: 20),
                _buildQuestion('Do you have allergies?', selectedAnswer1,
                    (value) => setState(() => selectedAnswer1 = value)),
                _buildQuestion('Do you have chronic diseases?', selectedAnswer2,
                    (value) => setState(() => selectedAnswer2 = value)),
                _buildQuestion('Do you smoke?', selectedAnswer3,
                    (value) => setState(() => selectedAnswer3 = value)),
                _buildQuestion(
                    'Do you have high blood pressure?',
                    selectedAnswer4,
                    (value) => setState(() => selectedAnswer4 = value)),
                _buildQuestion('Have you had any surgeries?', selectedAnswer5,
                    (value) => setState(() => selectedAnswer5 = value)),
                SizedBox(height: 20),
                RoundButton(
                  color: AppColors.darkBlueColor,
            
                  onPressed: _submitForm,
                  label: 'Submit',
            
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
