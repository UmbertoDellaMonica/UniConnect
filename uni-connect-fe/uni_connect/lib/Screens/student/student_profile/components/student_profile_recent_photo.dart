import 'package:flutter/material.dart';

class StudentProfileRecentPhoto extends StatefulWidget {
  final List<String> imagePaths;

  const StudentProfileRecentPhoto({Key? key, required this.imagePaths}) : super(key: key);

  @override
  _StudentProfileRecentPhotoState createState() => _StudentProfileRecentPhotoState();
}

class _StudentProfileRecentPhotoState extends State<StudentProfileRecentPhoto> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      padding: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Foto Recenti:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Flexible(
              fit: FlexFit.loose,
              child: GridView.builder(
                padding: EdgeInsets.all(20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.0,
                  mainAxisExtent: 300,
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.imagePaths.length,
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(
                    widget.imagePaths[index],
                    fit: BoxFit.fill,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
