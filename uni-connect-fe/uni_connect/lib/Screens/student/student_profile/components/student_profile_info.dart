import 'package:flutter/material.dart';
import '../../../../models/student.dart';

class StudentProfileInfo extends StatefulWidget {
  final Student? student;
  final bool enableEditing;

  const StudentProfileInfo({Key? key, required this.student, required this.enableEditing})
      : super(key: key);

  @override
  _PersonalInformationWidgetState createState() =>
      _PersonalInformationWidgetState();
}

class _PersonalInformationWidgetState extends State<StudentProfileInfo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isWideScreen = constraints.maxWidth > 600;

          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.person, size: 30, color: Colors.blue),
                      const SizedBox(width: 10),
                      Text(
                        widget.student!.fullName,
                        style: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Icon(Icons.school, size: 30, color: Colors.blue),
                      SizedBox(width: 10),
                      Text(
                        'Università degli Studi di Salerno',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.account_balance, size: 30, color: Colors.blue),
                      const SizedBox(width: 10),
                      Text(
                        'Dipartimento: ${widget.student!.departmentUnisa}',
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.email, size: 30, color: Colors.blue),
                      const SizedBox(width: 10),
                      Text(
                        'Email: ${widget.student!.email}',
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.lock, size: 30, color: Colors.blue),
                      const SizedBox(width: 10),
                      const Text(
                        'Password: ••••••••', // Non mostrare la password reale per motivi di sicurezza
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      if(widget.enableEditing)
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          /// Todo : Edit personal information about person
                          ///_showEditBioDialog(context, currentBio)
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}
