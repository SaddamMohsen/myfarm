import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:myfarm/features/authentication/presentation/supabase_auth_provider.dart';
import 'package:myfarm/routes.dart';
import 'package:myfarm/screens/home_page.dart';
import 'package:myfarm/utilities/constants.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod/riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  final loginForm = FormGroup({
    'email': FormControl<String>(
        validators: [Validators.email, Validators.required]),
    'password': FormControl<String>(validators: [Validators.required]),
  });

  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  late User user;

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
        authControllerProvider,
        (_, state) => state.when(
              error: (error, stackTrace) {
                setState(() {
                  isLoading = false;
                });
                // print(error.toString());
                showDialog<void>(
                  context: context,
                  builder: (context) => AlertDialog(
                    icon: Icon(
                      Icons.warning,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    title: const Text('خطأ'),
                    content: Text(
                      'معلومات غير صحيحة\nيرجى إعادة المحاولة\n ${error.toString()}\n',
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    ),
                    actions: <Widget>[
                      Center(
                        child: ElevatedButton(
                            child: const Text('موافق'),
                            onPressed: () => {
                                  Navigator.of(context).pop(),
                                }),
                      ),
                    ],
                  ),
                );
              },
              data: (data) => {
                user = data,
                // print('in data'),
                // print(user.userMetadata),
                setState(() {
                  isLoading = false;
                }),
                //if(user.id !=null)
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const MyHomePage(title: 'مزرعتي'))),
                // Navigator.of(context).pushReplacementNamed(RouteGenerator.homePage,
                //         arguments: {'title': 'hhhh'})
                //     .onError((error, stackTrace) =>
                //         print(' error in routing ${error.toString()}')),
                // .of(context)
                //     .pushAndRemoveUntil<void>(
                //         MaterialPageRoute<void>(
                //             builder: (context) => MyHomePage(title: 'مزرعتي')),
                //         ModalRoute.withName('/'))
                //     .onError((error, stackTrace) => print(error.toString())),
                // Navigator.pushAndRemoveUntil(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => MyHomePage(title: 'مزرعتي')),
                //         ModalRoute.withName('/'))
                //     .onError(
                //         (error, stackTrace) => debugPrint(error.toString())),
                //  Navigator.of(context).popAndPushNamed(RouteGenerator.homePage),
                // .pushNamedAndRemoveUntil(
                //     '/', ModalRoute.withName('/'),
                //     arguments: {'title': 'مزرعتي'}),
              },
              loading: () => setState(() {
                isLoading = true;
              }),
            ));
    return Scaffold(
      //appBar: appBar(context, 'تسجيل الدخول'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                Card(
                  margin: const EdgeInsets.all(30),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide.none),
                  //color: Color.fromARGB(255, 234, 238, 240),
                  elevation: 5,
                  //shadowColor: Color.fromARGB(179, 208, 224, 223),
                  child: Image(
                    image: const AssetImage('images/mag2.png'),
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 60.0,
                  // decoration: BoxDecoration(
                  //   border: Border.all(width: 1, color: Colors.black38),
                  //   borderRadius: BorderRadius.circular(12),
                  // ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 5.0),
                  child: ReactiveForm(
                    formGroup: loginForm,
                    child: ReactiveTextField(
                      formControlName: 'email',
                      validationMessages: {
                        'required': (error) =>
                            'لا يمكن الدخول بدون كتابة الايميل',
                        'email': (error) => 'يرجى كتابة الايميل بشكل صحيح'
                      },
                      textInputAction: TextInputAction.next,
                      showErrors: (control) =>
                          control.invalid && control.touched && control.dirty,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        contentPadding: EdgeInsets.only(top: 10.0),
                        hintText: "البريد الالكتروني",
                        fillColor: Colors.white10,
                        focusColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Colors.black,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                /*TextField(
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        contentPadding: EdgeInsets.only(top: 10.0),
                        hintText: "البريد الالكتروني",
                        fillColor: Colors.white10,
                        focusColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Colors.black,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                      controller: emailController,
                    ),
                  ),
                ),*/
                Container(
                  margin: const EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 60.0,
                  // decoration: BoxDecoration(
                  //   border: Border.all(width: 1, color: Colors.black38),
                  //   borderRadius: BorderRadius.circular(12),
                  // ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 5.0),
                  child: ReactiveForm(
                    formGroup: loginForm,
                    child: ReactiveTextField(
                      formControlName: 'password',
                      validationMessages: {
                        'required': (error) =>
                            'لا يمكن الدخول بدون كتابة كلمة السر'
                      },
                      showErrors: (control) =>
                          control.invalid && control.touched && control.dirty,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        contentPadding: EdgeInsets.only(top: 10.0),
                        hintText: "كلمة السر",
                        focusColor: Colors.white10,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Colors.black,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                      controller: passController,
                      obscuringCharacter: "*",
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxHeight: 60, maxWidth: 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 60,
                        child: ReactiveForm(
                          formGroup: loginForm,
                          child: ReactiveFormConsumer(
                              builder: (context, form, child) {
                            return Container(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                //textDirection: TextDirection.rtl,
                                children: [
                                  Expanded(
                                    child: !isLoading
                                        ? ElevatedButton(
                                            onPressed: () => {
                                              // print('press'),
                                              form.unfocus(),
                                              form.markAllAsTouched(),
                                              if (form.invalid)
                                                {
                                                  if (form
                                                      .control('email')
                                                      .invalid)
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(mySnackBar(
                                                            context,
                                                            'تأكد من كتابة البريد الالكتروني بشكل صحيح'))
                                                  else if (form
                                                      .control('password')
                                                      .invalid)
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(mySnackBar(
                                                            context,
                                                            'تأكد من كتابة كلمة المرور'))
                                                }
                                              else
                                                {
                                                  ref
                                                      .read(
                                                          authControllerProvider
                                                              .notifier)
                                                      .login(
                                                          form
                                                              .control('email')
                                                              .value,
                                                          form
                                                              .control(
                                                                  'password')
                                                              .value),
                                                  // Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(
                                                  //       builder: (context) =>
                                                  //           const MyHomePage(title: 'مزرعتي')),
                                                  // )
                                                },
                                            },
                                            child: const Text("تسجيل الدخول"),
                                          )
                                        : ElevatedButton.icon(
                                            icon: Icon(Icons.login,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            onPressed: () {},
                                            label: const Text(
                                              "...دخول",
                                              // softWrap: false,
                                            ),
                                          ),
                                  ),
                                  if (isLoading) ...[
                                    const SizedBox(width: 4),
                                    const CircularProgressIndicator(),
                                  ]
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
