import 'package:get/get.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:myfarm/Repository/ambers_repository.dart';
import 'package:myfarm/models/dailydata.dart';
import 'package:myfarm/widgets/indicator.dart';

class AmberController extends GetxController {
  //final noOfAmbers = 0.obs;
  FirebaseAmbersRepository repository = FirebaseAmbersRepository();
  final isLoading = true.obs;
  List<Amber> ambers = <Amber>[].obs;

  List<Amber> get getAmbersList => ambers;

  Future<String> addDailyData(
      {required DailyDataModel data, required int ambId}) async {
    Indicator.showLoading();
    final String returnStatus;
    try {
      returnStatus =
          await repository.addDailyData(todayData: data, ambId: ambId);
    } catch (e) {
      return Future.error(e);
    }
    Indicator.closeLoading();
    return returnStatus;
  }

  @override
  void onReady() {
    //  print('in onReady Controller');
    // ignore: todo
    // TODO: implement onReady
    super.onReady();
    Indicator.showLoading();
  }

//Get List of Ambers
  void getAmbers() async {
    print("inController");
    ambers.addAll(await repository.fetchAmbers());
    Indicator.closeLoading();
    // isLoading.value = false;
    update();
  }

  @override
  void onInit() {
    print('on onit controller');
    super.onInit();
    getAmbers();
    // isLoading.value = false;
  }
}
