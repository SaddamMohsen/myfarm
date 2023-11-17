import 'package:dartz/dartz.dart';
import 'package:myfarm/features/common/domain/failure.dart';
import 'package:myfarm/features/production/data/Supabase_repos/supabase_table.dart';
import 'package:myfarm/features/production/domain/entities/items_movement.dart';
import 'package:myfarm/features/production/domain/repositories/ambers_repository.dart';
import 'package:myfarm/features/production/domain/entities/dailydata.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/dailydata_converter.dart';

//part 'ambers_repository.dart';

class SupabaseAmbersRepository implements FarmRepository {
  const SupabaseAmbersRepository(
      {required this.supabaseClient, required this.user})
      : super();
  final SupabaseClient supabaseClient;
  final User user;
  //FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<List<Amber>> fetchAmbers() async {
    int noOfAmber = 0;
    List<Amber> amList = [];
    final int farmId = user.userMetadata?['farm_id'];
    try {
      final response =
          await supabaseClient.from('farms').select().eq('id', farmId).single();

      noOfAmber = response['no_of_ambers'];

      amList = [for (var i = 1; i <= noOfAmber; i++) Amber(id: i)].toList();
    } catch (e) {
      throw e.toString();
      //print('Error in fetching from firebase' + e.toString());
    }

    return amList;
  }

  @override
  Future<List<Item>> getItemsName() async {
    List<Item> itemsList = [];
    try {
      itemsList = await supabaseClient
          .from('items')
          .select()
          .withConverter<List<Item>>(
              (data) => DailyDataConverter.itemtoList(data));
    } on PostgrestException catch (e) {
      throw e.message.toString();
    }

    return itemsList;
    //throw UnimplementedError(items.toString());
  }

  @override
  Future<String> addDailyData({required DailyDataModel todayData}) async {
    String respone = 'success';
    final int farmId = user.userMetadata?['farm_id'];
    Map<String, dynamic> map = {
      'farm_id': farmId,
      ...todayData.toSupabasJson(),
    };
    // print('in adding data $map');
    //PostgrestResponse respons; // = 'may success';
    try {
      //Indicator.showLoading();
      final List<Map<String, dynamic>> data = await supabaseClient
          .from(const ProductionSupabaseTable().tableName)
          .insert({
        const ProductionSupabaseTable().farmId: map['farm_id'],
        const ProductionSupabaseTable().amberId: todayData.amberId,
        const ProductionSupabaseTable().prodDate:
            toTimestampString(todayData.prodDate.toString()),
        const ProductionSupabaseTable().incom_feed: todayData.incomFeed,
        const ProductionSupabaseTable().intak_feed: todayData.intakFeed,
        const ProductionSupabaseTable().prodTray: todayData.prodTray,
        const ProductionSupabaseTable().prodCarton: todayData.prodCarton,
        const ProductionSupabaseTable().outEggsTray: todayData.outEggsTray,
        const ProductionSupabaseTable().outEggsCarton: todayData.outEggsCarton,
        const ProductionSupabaseTable().outEggsNote: todayData.outEggsNote,
        const ProductionSupabaseTable().death: todayData.death
      }).select();
    } on PostgrestException catch (error) {
      throw (error.message);
    } catch (error) {
      throw (error.toString());
    }
    return respone;
  }

  @override
  Future<List<DailyDataModel>> getProductionData(
      {required DateTime prodDate}) async {
    List<DailyDataModel> listData = [];

    final int farmId = user.userMetadata?['farm_id'];
    try {
      listData = await supabaseClient
          .from(const ProductionSupabaseTable().tableName)
          .select()
          .eq(const ProductionSupabaseTable().prodDate, prodDate)
          .filter(const ProductionSupabaseTable().farmId, 'eq', farmId)
          .order('amber_id', ascending: true)
          .withConverter<List<DailyDataModel>>(
              (data) => DailyDataConverter.toList(data));
    } on PostgrestException catch (error) {
      throw PostgrestException;
    } catch (error) {
      throw (error.toString());
    }
    return listData;
  }

  @override
  Future<void> insertOutItems({required List<ItemsMovement> itemsData}) async {
    try {
      // itemsData.forEach((element) =>
      //     print('${element.runtimeType} :${element.movementDate.runtimeType}'));
      final int farmId = user.userMetadata?['farm_id'];
      //dynamic res;
      ///Check if thes list is empty
      if (itemsData.isEmpty) throw const Failure.empty();
      for (ItemsMovement element in itemsData) {
        Map<String, dynamic> map = {
          'farm_id': farmId,
          ...element.toJson(),
        };

        await supabaseClient
            .from(const ItemsMovementTable().tableName)
            .insert(map)
            .select()
            .withConverter(DailyDataConverter.itemsMovToSingle);
        // await Future.delayed(const Duration(seconds: 4), () {
        //   print('in loading');
        // });

        // print('response from database $res');
      }
      //return right(res);
    } on PostgrestException catch (error) {
      //print(' in insert out postgress exep ${error.message.toString()}');
      throw Failure.unprocessableEntity(message: error.message);
      // throw error.message;
    } catch (error) {
      //print(' in insert out ${error.toString()}');
      throw Failure.unprocessableEntity(message: error.toString());
      //  throw error;
    }
  }

  @override
  Future<void> updateDailyData(
      {required DailyDataModel todayData, required int rowId}) async {
    final int farmId = user.userMetadata?['farm_id'];
    Map<String, dynamic> map = {
      'id': rowId,
      'farm_id': farmId,
      ...todayData.toSupabasJson(),
    };
    // print('in adding data $map');
    //PostgrestResponse respons; // = 'may success';
    try {
      //Indicator.showLoading();
      await supabaseClient
          .from(const ProductionSupabaseTable().tableName)
          .update({
            const ProductionSupabaseTable().farmId: map['farm_id'],
            const ProductionSupabaseTable().amberId: todayData.amberId,
            const ProductionSupabaseTable().prodDate:
                toTimestampString(todayData.prodDate.toString()),
            const ProductionSupabaseTable().incom_feed: todayData.incomFeed,
            const ProductionSupabaseTable().intak_feed: todayData.intakFeed,
            const ProductionSupabaseTable().prodTray: todayData.prodTray,
            const ProductionSupabaseTable().prodCarton: todayData.prodCarton,
            const ProductionSupabaseTable().outEggsTray: todayData.outEggsTray,
            const ProductionSupabaseTable().outEggsCarton:
                todayData.outEggsCarton,
            const ProductionSupabaseTable().outEggsNote: todayData.outEggsNote,
            const ProductionSupabaseTable().death: todayData.death
          })
          .eq('id', rowId)
          .select();
    } on PostgrestException catch (error) {
      throw (error.message);
    } catch (error) {
      throw (error.toString());
    }
    return;
  }
}
 /* await firebaseFirestore
        .collection('DailyData')
        .where('prodDate', isEqualTo: prodDate)
        .get()
        .then(
      (querySnapshot) {
        print("Successfully completed");

        listData = querySnapshot.docs
            .map((e) => DailyDataModel.fromJson(e.data()))
            .toList();
      },
      onError: (e) => Get.showSnackbar(GetSnackBar(
          title: ' خطأ في استرجاع البيانات  ${e.printError()} ',
          messageText: const Text(
              'معذرة لم يتم الحصول على البيانات بنجاح حاول مرة أخرى'))),
              on Postg
    );
*/