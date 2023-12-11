//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'package:myfarm/features/authentication/application/supabase_auth_provider.dart';
import 'package:myfarm/utilities/constants.dart';
//import 'package:myfarm/utilities/form_model.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  final ImageProvider image = const AssetImage('images/mag8.jpg');
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

  late ColorScheme currentColorScheme;
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late User user;
  bool showPassword = false;

  @override
  void initState() {
    super.initState();

    // currentColorScheme = const ColorScheme.light();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateImage(widget.image);
    });
  }

  String? validateEmail(String? value) {
    RegExp emailRegex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return value!.isNotEmpty && !emailRegex.hasMatch(value)
        ? 'الايميل غير صحيح'
        : value!.isEmpty
            ? 'يجب كتابة البريد الالكتروني'
            : null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passController.dispose();
    //formKey.currentState?.dispose();
    super.dispose();
  }

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
                      'البيانات المدخله غير صحيحة\nيرجى إعادة المحاولة\n ${error.toString()}\n',
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
              data: (data) => data != null
                  ? {
                      user = data,
                      setState(() {
                        isLoading = false;
                      }),
                      if (user.id.isNotEmpty)
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/homepage', (route) => false),
                    }
                  : '',
              loading: () => setState(() {
                isLoading = true;
              }),
            ));
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        //appBar: appBar(context, 'تسجيل الدخول'),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 350),
            //height: MediaQuery.of(context).size.height * 0.1,
            decoration: const BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage('images/mag6.jpg'),
                repeat: ImageRepeat.noRepeat,
                fit: BoxFit.cover,
                //scale: 0.5,
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Container(
                //color: Theme.of(context).colorScheme.surfaceTint,
                decoration: const BoxDecoration(
                    gradient:
                        LinearGradient(colors: [Colors.white10, Colors.black])),
                height: MediaQuery.of(context).size.height * 0.6,
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          // margin: const EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 90,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 5.0),
                          child: TextFormField(
                            textDirection: TextDirection.rtl,
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            validator: validateEmail,
                            decoration: InputDecoration(
                              // labelText: "البريد الالكتروني",
                              label: const Padding(
                                padding: EdgeInsets.only(left: 1.0),
                                child: Text(
                                  "البريد الالكتروني",
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    style: BorderStyle.solid,
                                    color: Theme.of(context).colorScheme.error),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              prefixIcon: const Icon(Icons.email),

                              contentPadding: const EdgeInsets.only(top: 0.0),
                              hintText: "البريد الالكتروني",
                              // fillColor: Colors.white10,
                              focusColor: Colors.white,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    //color: Colors.black,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                            ),
                            /* ReactiveForm(
                            formGroup: loginForm,
                            child: 
                            ReactiveTextField(
                              formControlName: 'email',
                              validationMessages: {
                                'required': (error) =>
                                    'لا يمكن الدخول بدون كتابة الايميل',
                                'email': (error) => 'يرجى كتابة الايميل بشكل صحيح'
                              },
                              textInputAction: TextInputAction.next,
                              // showErrors: (control) =>
                              //     control.invalid &&
                              //     control.touched &&
                              //     control.dirty,
                              decoration: const InputDecoration(
                                // labelText: "البريد الالكتروني",
                                label: Padding(
                                  padding: EdgeInsets.only(left: 18.0),
                                  child: Text(
                                    "البريد الالكتروني",
                                    //textDirection: TextDirection.rtl,
                                    //textAlign: TextAlign.center,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                prefixIcon: Icon(Icons.email),
                                contentPadding: EdgeInsets.only(top: 0.0),
                                hintText: "البريد الالكتروني",
                                // fillColor: Colors.white10,
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      //color: Colors.black,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ),
                                            */
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: 90.0,
                          padding: const EdgeInsets.only(
                              left: 50.0, top: 5.0, right: 50.0),
                          child: Stack(fit: StackFit.expand, children: [
                            /* ReactiveForm(
                              formGroup: loginForm,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ReactiveTextField(
                                  formControlName: 'password',
                                  validationMessages: {
                                    'required': (error) =>
                                        'لا يمكن الدخول بدون كتابة كلمة المرور'
                                  },
                                  showErrors: (control) =>
                                      control.invalid && control.dirty,
                                  textInputAction: TextInputAction.done,
                                  obscureText: !showPassword,
                                  decoration: const InputDecoration(
                                    label: Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text("كلمة المرور"),
                                    ),
                                    prefixIcon: Icon(Icons.lock),
                                    contentPadding: EdgeInsets.only(top: 0.0),
                                    //hintText: "كلمة السر",
                                    focusColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          //color: Colors.black,
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
                            */
                            TextFormField(
                              textInputAction: TextInputAction.done,
                              obscureText: !showPassword,
                              validator: (String? value) {
                                return value!.isEmpty
                                    ? 'لا يمكن الدخول بدون كتابة كلمة المرور'
                                    : null;
                              },
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    backgroundColor:
                                        Color.fromARGB(255, 21, 20, 24)),
                                label: const Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Text("كلمة المرور"),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      style: BorderStyle.solid,
                                      color:
                                          Theme.of(context).colorScheme.error),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(showPassword == false
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      showPassword = !showPassword;
                                    });
                                  },
                                ),
                                prefixIcon: const Icon(Icons.lock),
                                contentPadding: const EdgeInsets.only(top: 0.0),
                                //hintText: "كلمة السر",
                                focusColor: Colors.white,
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      //color: Colors.black,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                              controller: passController,
                              obscuringCharacter: "*",
                            ),
                            // Positioned(
                            //     right: -5,
                            //     top: 0,
                            //     child: IconButton(
                            //       icon: Icon(showPassword == false
                            //           ? Icons.visibility
                            //           : Icons.visibility_off),
                            //       onPressed: () {
                            //         setState(() {
                            //           showPassword = !showPassword;
                            //         });
                            //       },
                            //     )),
                          ]),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                              maxHeight: 60, maxWidth: 100),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 60,
                                child:
                                    //  ReactiveForm(
                                    //   formGroup: loginForm,
                                    //   child: ReactiveFormConsumer(
                                    //       builder: (context, form, child) {
                                    //     bool isValid;
                                    Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    //textDirection: TextDirection.rtl,
                                    children: [
                                      Expanded(
                                        ///if is loading is false then show login button
                                        child: !isLoading
                                            ? ElevatedButton(
                                                onPressed: () => {
                                                  if (formKey.currentState!
                                                              .validate() ==
                                                          false ||
                                                      passController
                                                          .text.isEmpty)
                                                    {
                                                      if (!emailController.value
                                                              .text.isEmail ||
                                                          emailController.value
                                                              .text.isEmpty)
                                                        ScaffoldMessenger
                                                                .of(context)
                                                            .showSnackBar(mySnackBar(
                                                                context,
                                                                ' تأكد من كتابة البريد الالكتروني بشكل صحيح '))
                                                      else if (passController
                                                          .value.text.isEmpty)
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                mySnackBar(
                                                                    context,
                                                                    'تأكد من كتابة كلمة المرور'))
                                                      else
                                                        {}
                                                    }
                                                  else
                                                    {
                                                      ref
                                                          .read(
                                                              authControllerProvider
                                                                  .notifier)
                                                          .login(
                                                              emailController
                                                                  .text,
                                                              passController
                                                                  .text),
                                                    },
                                                },
                                                child:
                                                    const Text("تسجيل الدخول"),
                                              )

                                            /// else show loading button with icon
                                            : ElevatedButton.icon(
                                                icon: Icon(Icons.login,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onBackground),
                                                onPressed: () {},
                                                label: const Text(
                                                  ".جاري تسجيل الدخول",
                                                  style: TextStyle(fontSize: 7),
                                                  // softWrap: false,
                                                ),
                                              ),
                                      ),
                                      if (isLoading) ...[
                                        const SizedBox(width: 2),
                                        const CircularProgressIndicator()
                                      ]
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// get colorscheme from an image
  /// it  used here for experment only
  Future<void> _updateImage(ImageProvider provider) async {
    final ColorScheme newcolorScheme = await ColorScheme.fromImageProvider(
        provider: provider, brightness: Brightness.light);
    setState(() {
      currentColorScheme = newcolorScheme;
      //print(currentColorScheme.toString());
    });
  }
}
