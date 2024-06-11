import 'package:flutter/material.dart';
import 'package:uni_connect/shared/services/router_service.dart';
import 'package:uni_connect/shared/services/student_service.dart';
import '../../../../models/student.dart';

class ConnectedPeopleHome extends StatefulWidget {
  final String IDStudent;

  const ConnectedPeopleHome({super.key, required this.IDStudent});

  @override
  _ConnectedPeopleHomeState createState() => _ConnectedPeopleHomeState();
}

class _ConnectedPeopleHomeState extends State<ConnectedPeopleHome> {

  /// Variable - Loading Data
  bool _isLoading = true;

  List<Student> mutualConnections = [];

  final StudentService _studentService = StudentService();

  final RouterService _routerService = RouterService();

  @override
  void initState() {
    super.initState();
    /// Fetch the other connections
    _fetchMutualConnections();
  }





  @override
  Widget build(BuildContext context) {

    bool tagPeopleEmpty = mutualConnections.isEmpty;

    if(_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Card(
        margin: const EdgeInsets.all(10),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title of Card
              _buildTitle(),
              const Divider(),

              tagPeopleEmpty ?
              /// Text - Empty - there are no People Oonnected with me
              _buildEmptyTextList() :
              /// List People there are connected with me
              _buildListPeopleConnected()
            ],
          ),
        ),
    );
  }

  /// Fetch - Connection
  /// Method for retrieve the people that i follow and reply
  Future<void> _fetchMutualConnections() async {
    try {
      /// Fetch people
      List<Student> connections = await _studentService.fetchMutualConnections(widget.IDStudent);
      setState(() {
        mutualConnections = connections;
        _isLoading = false;
      });
    } catch (e) {
      // Handle error
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// ------------- Widget ---------///
  Widget _buildListPeopleConnected(){
    return Expanded(
      child: ListView.builder(
        itemCount: mutualConnections.length,
        itemBuilder: (context, index) {

          final Student student = mutualConnections[index];
          String fullName = student.fullName;
          String id = student.id;


          return ListTile(
            leading: const CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage('../assets/images/welcome.jpg'),
            ),
            title: Text(fullName, style: const TextStyle(fontSize: 18)),
            onTap: () {
              /// TODO: Chat - Message
              // Implementa la navigazione al profilo del follower quando viene premuto il ListTile
              _routerService.goOtherStudentProfile(context,id);
              },
          );
        },
      ),
    );
  }

  Widget _buildEmptyTextList(){
    return const Center(
      child: Text(
        'Nessuna persona connessa al momento',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Persone connesse',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

}
