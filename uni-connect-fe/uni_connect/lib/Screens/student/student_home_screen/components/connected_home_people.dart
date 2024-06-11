import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uni_connect/shared/services/student_service.dart';
import '../../../../models/student.dart';
import 'package:http/http.dart' as http;
import '../../../other_student/profile/other_student_profile.dart';

class ConnectedPeopleHome extends StatefulWidget {
  final String IDStudent;

  const ConnectedPeopleHome({Key? key, required this.IDStudent}) : super(key: key);

  @override
  _ConnectedPeopleHomeState createState() => _ConnectedPeopleHomeState();
}

class _ConnectedPeopleHomeState extends State<ConnectedPeopleHome> {
  bool isLoading = true;
  List<Student> mutualConnections = [];
  StudentService _studentService = StudentService();

  @override
  void initState() {
    super.initState();
    fetchMutualConnections();
  }

  Future<void> fetchMutualConnections() async {
    try {
      List<Student> connections = await _studentService.fetchMutualConnections(widget.IDStudent);
      setState(() {
        mutualConnections = connections;
        isLoading = false;
      });
    } catch (e) {
      // Handle error
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Persone connesse',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              mutualConnections.isEmpty
                  ? Center(
                child: Text(
                  'Nessuna persona connessa al momento',
                  style: TextStyle(fontSize: 16),
                ),
              )
                  : Expanded(
                child: ListView.builder(
                  itemCount: mutualConnections.length,
                  itemBuilder: (context, index) {
                    final mutualConnection = mutualConnections[index];
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage('../assets/images/welcome.jpg'),
                      ),
                      title: Text(mutualConnection.fullName, style: TextStyle(fontSize: 18)),
                      onTap: () {
                        /// TODO: Chat - Message
                        // Implementa la navigazione al profilo del follower quando viene premuto il ListTile
                        if (mutualConnection != null) {
                          print('Navigating with student:${mutualConnections[index]}');
                          context.go('/other-student/${mutualConnections[index].id}/profile');
                        } else {
                          print('Student is null');
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
