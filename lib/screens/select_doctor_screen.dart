import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patient_app/core/constants/app_colors.dart';

import '../routes/routes_name.dart';

class SelectDoctorScreen extends ConsumerStatefulWidget {
  const SelectDoctorScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SelectDoctorScreen> createState() => _SelectDoctorScreenState();
}

class _SelectDoctorScreenState extends ConsumerState<SelectDoctorScreen> {

  Future<List<Map<String, dynamic>>> fetchDoctors() async {
    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('doctors').get();
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching doctors: $e');
      return [];
    }
  }

  void _showDoctorDetailsDialog(BuildContext context, Map<String, dynamic> doctor) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(backgroundColor: AppColors.whiteColor,
          title: Row(
            children: [
              Icon(Icons.person, color: AppColors.darkBlueColor),
              SizedBox(width: 8),
              Text('Doctor Details'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('UID: ${doctor['uid'] ?? 'N/A'}'),
              SizedBox(height: 8),
              Text('Name: ${doctor['name'] ?? 'Unknown'}'),
              SizedBox(height: 8),
              Text('Specialization: ${doctor['special_area'] ?? 'N/A'}'),
              SizedBox(height: 8),
              Text('Hospital: ${doctor['hospital'] ?? 'N/A'}'),
              SizedBox(height: 8),
              Text('Mobile Number: ${doctor['mobile_number'] ?? 'N/A'}'),

            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.loginScreenColor,
              ),
              onPressed: () {
                Navigator.pop(context); // Close the dialog first
                Navigator.pushNamed(
                  context,
                  RoutesName.formPage,
                  arguments: doctor['uid'].toString(), // Pass the doctor UID
                );
              },
              child: Text('Fill form to Register'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.loginScreenColor,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            'Select Doctor',
            style: TextStyle(
                fontSize: 18,
                color: AppColors.blackColor,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchDoctors(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error loading doctors'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No doctors available'));
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var doctor = snapshot.data![index];
                return Card(
                  color: AppColors.lighterBlue,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(doctor['name'] ?? 'Unknown'),
                    subtitle: Text(
                        '${doctor['special_area']} - ${doctor['hospital']}'),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.darkBlueColor,
                    ),
                    onTap: () => _showDoctorDetailsDialog(context, doctor),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
