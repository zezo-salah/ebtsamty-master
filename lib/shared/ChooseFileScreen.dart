
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ChooseFileScreen extends StatefulWidget {
  @override
  _ChooseFileScreenState createState() => _ChooseFileScreenState();
}

class _ChooseFileScreenState extends State<ChooseFileScreen> {
  String? _fileName;

  void _chooseFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose File'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'Selected File:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          _fileName != null
              ? Text(
                  _fileName!,
                  style: TextStyle(fontSize: 18),
                )
              : Text(
                  'No file selected',
                  style: TextStyle(fontSize: 18),
                ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _chooseFile,
            child: Text('Choose File'),
          ),
        ],
      ),
    );
  }
}
