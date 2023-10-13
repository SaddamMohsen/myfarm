import 'package:flutter/material.dart';
import 'package:myfarm/features/production/domain/dailydata.dart';

class MyEditDialog extends StatelessWidget {
  const MyEditDialog({super.key, required this.title, required this.content});
  final String title;
  final DailyDataModel content;
  static const itemText = [
    "رقم العنبر",
    "تاريخ الانتاج",
    "الانتاج طبق",
    "الانتاج كرتون",
    "الخارج طبق",
    "الخارج كرتون",
    "تفاصيل الخارج",
    "وارد علف",
    "مستهلك علف",
    "الميت"
  ];
  @override
  Widget build(BuildContext context) {
    //convert string to list
    //print(myList[0].keys);
    return AlertDialog(
      icon: const Icon(
        Icons.edit_note_outlined,
        color: Colors.red,
        size: 60.0,
      ),
      backgroundColor: const Color(0xffF3F6FC),
      elevation: 15.0,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      // shape: Border.all(
      //     width: 0.5, color: Theme.of(context).colorScheme.onBackground),
      title: Text(title, style: Theme.of(context).textTheme.headlineSmall),
      content: Container(
        height: 250,
        width: 200,
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).cardColor,
        ),
        child: Card(
          //elevation: 2,
          child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {

                return Card(
                  child: ListTile(
                    selected: true,
                    selectedColor: Theme.of(context).primaryColor,
                    // shape: Border.all(
                    //     color: Theme.of(context).primaryColorLight,
                    //     style: BorderStyle.solid),
                    title: Text(
                    '',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Color.fromARGB(255, 16, 8, 22),
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    // leading: InputChip(label: Text(item.values.toString())),
                  ),
                );
              }),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100.0,
              child: ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style,
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('موافق'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}