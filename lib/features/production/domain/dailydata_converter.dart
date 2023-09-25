import 'package:myfarm/features/production/domain/dailydata.dart';

class DailyDataConverter {
  static List<DailyDataModel> toList(dynamic data) {
    print('in convertor $data');

    return (data as List<dynamic>)
        .map((e) => DailyDataModel.fromSupabaseJson(e as Map<String, dynamic>))
        .toList();
  }
}