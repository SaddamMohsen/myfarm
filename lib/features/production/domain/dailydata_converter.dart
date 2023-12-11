import 'package:myfarm/features/production/domain/entities/dailydata.dart';
import 'package:myfarm/features/production/domain/entities/items_movement.dart';

import 'repositories/ambers_repository.dart';

class DailyDataConverter {
  //return dailyData as list
  static List<DailyDataModel> toList(dynamic data) {
    return (data as List<dynamic>)
        .map((e) => DailyDataModel.fromSupabaseJson(e as Map<String, dynamic>))
        .toList();
  }

  static DailyDataModel toSingle(dynamic data) {
    return DailyDataModel.fromSupabaseJson(
        (data as List).first as Map<String, dynamic>);
  }

//return items as list
  static List<Item> itemtoList(dynamic data) {
    return (data as List<dynamic>)
        .map((e) => Item.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  ///return itemsMovement as a list from Database
  static List<ItemsMovement> itemMovtoList(dynamic data) {
    return (data as List<dynamic>)
        .map((e) => ItemsMovement.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  ///return only Single
  static ItemsMovement itemsMovToSingle(dynamic data) {
    return ItemsMovement.fromJson(
      (data as List).first as Map<String, dynamic>,
    );
  }
}
