/*Stream<DateTime> counterStream([int maxCount = 7]) async* {
  final delay = const Duration(seconds: 1);
  var counter=0;
  DateTime nowDate = DateTime.now();
  int lastday = DateTime(nowDate.year, nowDate.month + 1, 0).day;
  while (true) {
    counter++;
    print(counter);
    if (counter >= 31-nowDate.day) {
      break;
    }
    await Future.delayed(delay);
    yield nowDate.add(Duration(days:counter));
  }
}
void main(){
  print('here we go');
  final stream=counterStream(7);

  //counterStream.foreach()
  try{
        stream.forEach((element)=>{print(element)});
     //for(var value in stream)
      //print(value);
  }catch(e){
    print(e);
  }
// DateTime curdate = DateTime.now();
//   var day=curdate.day;
//   curdate=curdate.subtract(Duration(days:day-1));
//   print('here we go');
//    print(day);
//   print(curdate.toString());

}
*/
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() {
  initializeDateFormatting('ar', null);
  print("hello");
  var format = DateFormat('yMMMMEEEEd', 'ar');

  var localDate = format.format(DateTime.now());
  //localDate = localDate.replaceAll('/', '-');
  print(localDate);
  /*localDate = localDate.substring(
                      localDate.indexOf('،') + 2, localDate.length),
                  localDate = localDate.replaceAll(' ', '/'),*/
  var date1 = DateFormat('yMMMMEEEEd', 'ar').parseUTC(localDate);

  print(date1);
}
