// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// //import 'package:firebase_database/firebase_database.dart';
// import 'package:myfarm/Repository/ambers_repository.dart';
// import 'package:myfarm/models/dailydata.dart';
// import 'package:myfarm/widgets/indicator.dart';
// import 'package:myfarm/Repository/supabase_amber_repository.dart';

// class AmberController extends GetxController {
//   //final noOfAmbers = 0.obs;
//   //FirebaseAmbersRepository repository = FirebaseAmbersRepository();
//   SupabaseAmbersRepository repository = SupabaseAmbersRepository();
//   final isLoading = true.obs;
//   //store List of Ambers coming from database
//   List<Amber> ambers = <Amber>[].obs;
//   // to get list of Ambers from Ui
//   List<Amber> get getAmbersList => ambers;

//   List<DailyDataModel> todayData = <DailyDataModel>[].obs;

//   //List<DailyDataModel> get getDataProd => todayData;

//   getData(DateTime prodDate, int ambId) async {
//     print('in get data controller');
//     todayData.clear();
//     Indicator.showLoading();
//     try {
//       todayData.addAll(
//           await repository.getProductionData(prodDate: prodDate, ambId: ambId));

//       //print(' in controller $todayData');
//       update(todayData);

//       Indicator.closeLoading();
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error in GetData Controller ${e.toString()}');
//       }
//     } finally {
//       Indicator.closeLoading();
//     }
//   }

// //
//   Future<void> addDailyData(
//       {required DailyDataModel data, required int ambId}) async {
//     // Indicator.showLoading();

//     try {
//       await repository.addDailyData(todayData: data, ambId: ambId);
//     } catch (e) {
//       print(e.toString());
//       return Future.error(e);
//     }
//     Indicator.closeLoading();
//   }

//   @override
//   void onReady() {
//     //  print('in onReady Controller');
//     // ignore: todo
//     // TODO: implement onReady
//     super.onReady();
//     Indicator.showLoading();
//   }

// //Get List of Ambers
//   void getAmbers() async {
//     print("inController");
//     ambers.addAll(await repository.fetchAmbers());
//     Indicator.closeLoading();
//     // isLoading.value = false;
//     update();
//   }

//   @override
//   void onInit() {
//     print('on onit controller');
//     super.onInit();
//     getAmbers();
//     // isLoading.value = false;
//   }
// }