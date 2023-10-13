abstract class SupabaseTable {
  const SupabaseTable();
  String get tableName;
}

//Table Schema in Supabase Database
class ProductionSupabaseTable implements SupabaseTable {
  const ProductionSupabaseTable();
  @override
  String get tableName => 'production';

  String get farmId => "farm_id";
  String get amberId => 'amber_id';
  String get prodDate => "prodDate";
  String get incom_feed => 'incom_feed';
  String get intak_feed => "intak_feed";
  String get prodTray => "prodTray";
  String get prodCarton => "prodCarton";
  String get death => "death";
  String get outEggsTray => "outTray";
  String get outEggsCarton => "outCarton";
  String get outEggsNote => "outEggsNote";
}

class InventoryTable implements SupabaseTable {
  const InventoryTable();
  @override
  String get tableName => 'inventory';
  String get farmId => "farm_id";
  String get amberId => 'amber_id';
  String get itemCode => 'item_code';
  String get quantity => 'quantity';
  String get smallQuantity => 'small_quantity';
}