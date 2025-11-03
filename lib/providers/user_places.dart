import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:snap_spots/models/place.dart';

class UserplacesNotifier extends StateNotifier<List<Place>>{
  UserplacesNotifier() : super(const[]);

  void addplace(String title){
    final newplace = Place(title :title);
    state = [newplace, ...state];
  }
}
final userplaceProvider = StateNotifierProvider<UserplacesNotifier,List<Place>>(
    (ref)=>UserplacesNotifier(),
);