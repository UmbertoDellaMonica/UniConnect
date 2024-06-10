import 'package:flutter/material.dart';
import '../../../../models/student.dart';

class OtherStudentProfileInfo extends StatefulWidget {
  final Student? student;

  const OtherStudentProfileInfo({Key? key, required this.student})
      : super(key: key);

  @override
  _OtherStudentProfileInfoState createState() => _OtherStudentProfileInfoState();
}

class _OtherStudentProfileInfoState extends State<OtherStudentProfileInfo> {
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

                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<String> _showEditDialog(BuildContext context, String currentContent) async {
    TextEditingController _passwordController = TextEditingController();
    String newContent = currentContent;
    String selectedValue = 'Dipartimento di Matematica e fisica';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            'Modifica Post',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedValue,
                  onChanged: (String? newValue) {
                    selectedValue = newValue!;
                    // Aggiorna lo stato per riflettere il cambiamento di selezione
                    setState(() {});
                  },
                  items: <String>['Password', 'Altro Valore']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
              if (selectedValue == 'Password')
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Inserisci nuova password",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              if (selectedValue == 'Altro Valore')
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: TextEditingController(text: currentContent),
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: "Modifica il contenuto del post",
                      border: InputBorder.none,
                    ),
                  ),
                ),
            ],
          ),
          actions: [
            TextButton.icon(
              icon: Icon(Icons.cancel, color: Colors.red),
              label: Text(
                'Annulla',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton.icon(
              icon: Icon(Icons.save, color: Colors.green),
              label: Text(
                'Salva',
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                newContent = selectedValue == 'Password' ? _passwordController.text : _passwordController.text;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    return newContent;
  }
}
