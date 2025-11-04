import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snap_spots/providers/user_places.dart';
import 'package:snap_spots/widgets/image_input.dart';
import 'dart:io';

import 'package:snap_spots/widgets/location_input.dart';

class AddplaceScreen extends ConsumerStatefulWidget{
  const AddplaceScreen ({super.key});
  
  @override
  ConsumerState<AddplaceScreen> createState() {
    return _AddplaceScreen();
  }
}
class _AddplaceScreen extends ConsumerState<AddplaceScreen>{
  final _titlecontroller = TextEditingController();
  File? _selectedimage;

  void _saveplace(){
    final enteredtitle = _titlecontroller.text;

    if( enteredtitle.isEmpty || _selectedimage==null){
      return ;
    }

    ref
        .read(userplaceProvider.notifier)
        .addplace(enteredtitle,_selectedimage!,);
    Navigator.of(context).pop();
  }

  @override
  void dispose(){
    _titlecontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titlecontroller,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            //Image Input
            const SizedBox(height: 16,),
            ImageInput(
              onPickImage: (
                  image){
                _selectedimage = image;
                },
            ),
            const SizedBox(height: 10,),
            Locationinput(),
            const SizedBox(height: 16,),
            ElevatedButton.icon(
                onPressed: _saveplace,
                icon: const Icon(Icons.add),
                label: Text('Add place'),
            )
          ],
        ),
      ),
    );
  }
}