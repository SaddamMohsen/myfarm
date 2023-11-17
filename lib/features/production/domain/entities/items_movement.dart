import 'package:supabase_flutter/supabase_flutter.dart';

class ItemsMovement {
  int? farmId;
  final int amberId;
  final String itemCode;
  final DateTime movementDate;
  final String typeMovement;
  final double quantity;
  final String notes;
  ItemsMovement(
      {this.farmId,
      required this.amberId,
      required this.itemCode,
      required this.movementDate,
      required this.typeMovement,
      required this.quantity,
      required this.notes});

  factory ItemsMovement.fromJson(Map<String, dynamic> data) {
    try {
      return ItemsMovement(
          farmId: data['farm_id'] ?? 0,
          amberId: data['amber_id'],
          itemCode: data['item_code'],
          typeMovement: data['type_movement'],
          movementDate: data['movement_date'].runtimeType == String
              ? DateTime.parse(data['movement_date'])
              : data['movement_date'],
          quantity: data['quantity'].runtimeType == String
              ? double.parse(data['quantity'])
              : data['quantity'],
          notes: data['notes']);
    } catch (e) {
      ///TODO remove print
      print(' error in fromJson ${e.toString()}');
      throw e.toString();
    }
    //throw 'error';
  }
  ItemsMovement copyWith(
          {int? amberId,
          double? quantity,
          String? itemCode,
          DateTime? movementDate,
          String? notes,
          String? typeMovement}) =>
      ItemsMovement(
        amberId: amberId ?? this.amberId,
        quantity: quantity ?? this.quantity,
        itemCode: itemCode ?? this.itemCode,
        movementDate: movementDate ?? this.movementDate,
        typeMovement: typeMovement ?? this.typeMovement,
        notes: notes ?? this.notes,
      );

  Map<String, dynamic> toJson() {
    return {
      //'farm_id': farmId,
      'amber_id': amberId,
      'item_code': itemCode,
      'movement_date': toTimestampString(movementDate.toString()),
      'type_movement': typeMovement,
      'quantity': quantity,
      'notes': notes,
    };
  }

  @override
  String toString() =>
      "amberId:$amberId,itemCode:$itemCode,movementDate:$movementDate,quantity:$quantity,type_mov:$typeMovement,notes:$notes";
}
