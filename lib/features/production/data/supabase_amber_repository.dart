import 'package:flutter/material.dart';

import 'package:myfarm/features/production/data/Supabase_repos/supabase_table.dart';
import 'package:myfarm/features/production/data/ambers_repository.dart';
import 'package:myfarm/features/production/domain/dailydata.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myfarm/features/authentication/data/supabase_auth_repository.dart';
//import 'package:myfarm/widgets/indicator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/dailydata_converter.dart';

//part 'ambers_repository.dart';

class SupabaseAmbersRepository implements AmberRepository {
  const SupabaseAmbersRepository({required this.supabaseClient,required this.user}):super();
  final SupabaseClient supabaseClient;
  final User user;
  //FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<List<Amber>> fetchAmbers() async {
    debugPrint('inside loadAmbers');
     int _noOfAmber = 0;
    List<Amber> amList = [];
    final int farmId=user.userMetadata?['farm_id'];
// try {
//   farmId= user.userMetadata?['farm_id'] ?? 0;
// }catch(e){
//   print('error in get farmId ${e.toString()}');
// }
print(user.userMetadata?['farm_id'].runtimeType);

    try {
      final response =
          await supabaseClient.from('farms').select().eq('id', farmId).single();

      _noOfAmber = response['no_of_ambers'];
      print('in get ambers $response');
      amList = [for (var i = 1; i <= _noOfAmber; i++) Amber(id: i)].toList();
    } catch (e) {
      //printError();
      throw e;
      //print('Error in fetching from firebase' + e.toString());
    }

    return amList;
  }

  @override
  Future<String> addDailyData(
      {required DailyDataModel todayData}) async {
    String respone = 'success';
    final int farmId=user.userMetadata?['farm_id'];
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

      //return data.toString();
      // print('data in supa');
    } on PostgrestException catch (error) {
      //  Indicator.closeLoading();
      //print('in postgress Ex ${error.message}');
      throw (error.message);
      // return error.message;
      //return error.toString();
    } catch (error) {
      //print('in postgress Ex2${error.toString()}');
      //return error.toString();
      //return error.toString();
      throw (error.toString());
    }
    return respone;
  }

  @override
  Future<List<DailyDataModel>> getProductionData(
      {required DateTime prodDate}) async {
    print(prodDate);
    List<DailyDataModel> listData = [];
    print('in get production$user');
    print(user.userMetadata?['farm_id']);
    final int farmId=user.userMetadata?['farm_id'];
    try {
      listData = await supabaseClient
          .from(const ProductionSupabaseTable().tableName)
          .select()
          .eq(const ProductionSupabaseTable().prodDate, prodDate)
          .filter(const ProductionSupabaseTable().farmId, 'eq',farmId)
          .withConverter<List<DailyDataModel>>(
              (data) => DailyDataConverter.toList(data));
      print(listData);
    } on PostgrestException catch (error) {
      print('in postgress getdata $error');
      throw PostgrestException;
      //print(' in postgress ex1 ${error.details}');
    } catch (error) {
       print(' in error getProduction ${error.toString()}');
      throw (error.toString());
    }
    return listData;
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