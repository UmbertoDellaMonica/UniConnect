import 'package:flutter/material.dart';
import '../../../../models/student.dart';

class StudentProfileInfo extends StatefulWidget {
  final Student? student;

  const StudentProfileInfo({Key? key, required this.student})
      : super(key: key);

  @override
  _PersonalInformationWidgetState createState() =>
      _PersonalInformationWidgetState();
}

class _PersonalInformationWidgetState extends State<StudentProfileInfo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
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
                      Icon(Icons.person, size: 30, color: Colors.blue),
                      SizedBox(width: 10),
                      Text(
                        widget.student!.fullName,
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Row(
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
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.account_balance, size: 30, color: Colors.blue),
                      SizedBox(width: 10),
                      Text(
                        'Dipartimento: ' + widget.student!.departmentUnisa,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.email, size: 30, color: Colors.blue),
                      SizedBox(width: 10),
                      Text(
                        'Email: ' + widget.student!.email,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.lock, size: 30, color: Colors.blue),
                      SizedBox(width: 10),
                      Text(
                        'Password: ••••••••', // Non mostrare la password reale per motivi di sicurezza
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          // Logica per modificare la password
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
