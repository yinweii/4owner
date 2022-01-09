import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:owner_app/api_service/api_service.dart';
import 'package:path/path.dart';

class DirectScreen extends StatefulWidget {
  const DirectScreen({Key? key}) : super(key: key);

  @override
  _DirectScreenState createState() => _DirectScreenState();
}

class _DirectScreenState extends State<DirectScreen> {
  String? loaclPath;
  final url = 'sample_4owner.pdf';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiService.loadFirebase(url).then((value) {
      setState(() {
        loaclPath = value?.path;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final name = basename(loaclPath ?? '');
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.file_download_outlined,
                size: 35,
              ))
        ],
      ),
      body: loaclPath != null
          ? PDFView(
              filePath: loaclPath,
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
