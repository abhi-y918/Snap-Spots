import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageInput extends StatefulWidget{
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}
class _ImageInputState extends State<ImageInput>{
   File? _selectedimage;
  void _takePicture()async{
    final imagepicker = ImagePicker();
    final pickedimage = await imagepicker.pickImage(source: ImageSource.camera,maxWidth: 600,);

    if(pickedimage==null){
      return;
    }
    setState(() {
      _selectedimage = File(pickedimage.path);
    });


  }
  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      icon : Icon(Icons.camera),
      label: const Text('Take Picture'),
      onPressed: _takePicture,
    );
    if(_selectedimage!=null){
      content = GestureDetector(
        onTap: _takePicture,
        child:Image.file(
          _selectedimage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        )
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}