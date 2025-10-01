import 'package:flutter/material.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';


class TaskSubmissionPage extends StatefulWidget {
  final String? taskTitle;
  final String? taskSubtitle;
  final IconData? icon;
  final Color? color;

  const TaskSubmissionPage({
    super.key,
    this.taskTitle,
    this.taskSubtitle,
    this.icon,
    this.color,
  });

  @override
  _TaskSubmissionPageState createState() => _TaskSubmissionPageState();
}

class _TaskSubmissionPageState extends State<TaskSubmissionPage> {
  File? _imageFile;
  File? _videoFile;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  String? _submissionText;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _videoFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitTask() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final url = Uri.parse('http://127.0.0.1:8002/api/submissions/');
        final response = await HttpClient().postUrl(url)
          ..headers.contentType = ContentType.json
          ..write('{"submission": "${_submissionText ?? ''}"}');
        final httpResponse = await response.close();
        if (httpResponse.statusCode == 200 || httpResponse.statusCode == 201) {
          if (!mounted) return;
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              backgroundColor: Colors.purple[50],
              title: Column(
                children: [
                  Icon(Icons.celebration, color: Colors.purple, size: 48),
                  const SizedBox(height: 12),
                  const Text('Submitted Successfully!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.deepPurple)),
                ],
              ),
              content: const Text('Your submission has been received. Great job!', textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple)),
                ),
              ],
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Submission failed: ${httpResponse.statusCode}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.taskTitle ?? 'Submit Task'),
        backgroundColor: widget.color ?? Colors.purple,
      ),
      backgroundColor: (widget.color ?? Colors.purple).withOpacity(0.1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.elasticOut,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: widget.color ?? Colors.purple, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: (widget.color ?? Colors.purple).withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(18),
                child: Icon(widget.icon ?? Icons.star, color: widget.color ?? Colors.purple, size: 48),
              ),
              const SizedBox(height: 18),
              Text(
                widget.taskTitle ?? 'Task',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.deepPurple,
                  fontFamily: 'ComicSans',
                ),
                textAlign: TextAlign.center,
              ),
              if (widget.taskSubtitle != null) ...[
                const SizedBox(height: 8),
                Text(
                  widget.taskSubtitle!,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.deepPurple,
                    fontFamily: 'ComicSans',
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            color: Colors.pink[50],
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.pink, width: 2),
                          ),
                          width: 80,
                          height: 80,
                          child: _imageFile == null
                              ? Icon(Icons.photo_camera, color: Colors.pink, size: 40)
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Image.file(_imageFile!, fit: BoxFit.cover),
                                ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text('Photo', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink)),
                    ],
                  ),
                  const SizedBox(width: 32),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: _pickVideo,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.blue, width: 2),
                          ),
                          width: 80,
                          height: 80,
                          child: _videoFile == null
                              ? Icon(Icons.videocam, color: Colors.blue, size: 40)
                              : Icon(Icons.check_circle, color: Colors.blue, size: 40),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text('Video', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Write a note',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onSaved: (value) => _submissionText = value,
                validator: (value) => value == null || value.isEmpty ? 'Please enter something' : null,
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _submitTask,
                icon: const Icon(Icons.send),
                label: const Text('Submit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.color ?? Colors.purple,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
