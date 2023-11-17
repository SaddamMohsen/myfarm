import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:myfarm/features/authentication/application/supabase_auth_provider.dart';
import 'package:myfarm/config/routes.dart';
import 'package:myfarm/features/home/presentation/screen/home_page.dart';
import 'package:myfarm/utilities/constants.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod/riverpod.dart';
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
  late User user;
  bool showPassword = false;

  @override
  void initState() {
    super.initState();

    currentColorScheme = const ColorScheme.light();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateImage(widget.image);
    });
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
              data: (data) => data != null
                  ? {
                      user = data,
                      // print('in data'),
                      // print(user.userMetadata),
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
    return Scaffold(
      //appBar: appBar(context, 'تسجيل الدخول'),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 350),
          //height: MediaQuery.of(context).size.height * 0.1,
          decoration: const BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage('images/mag8.jpg'),
              repeat: ImageRepeat.repeatY,
              fit: BoxFit.fitWidth,
              //scale: 0.5,
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Container(
              color: Theme.of(context).colorScheme.onBackground,
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 60,
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
                          // showErrors: (control) =>
                          //     control.invalid &&
                          //     control.touched &&
                          //     control.dirty,
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
                        child: Stack(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ReactiveTextField(
                                formControlName: 'password',
                                validationMessages: {
                                  'required': (error) =>
                                      'لا يمكن الدخول بدون كتابة كلمة السر'
                                },
                                showErrors: (control) =>
                                    control.invalid && control.dirty,
                                textInputAction: TextInputAction.done,
                                obscureText: !showPassword,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  contentPadding: EdgeInsets.only(top: 10.0),
                                  hintText: "كلمة السر",
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
                                controller: passController,
                                obscuringCharacter: "*",
                              ),
                              Positioned(
                                  right: -5,
                                  top: 0,
                                  child: IconButton(
                                    icon: Icon(showPassword == false
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        showPassword = !showPassword;
                                      });
                                    },
                                  )),
                            ]),
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
                                                            .showSnackBar(
                                                                mySnackBar(
                                                                    context,
                                                                    'تأكد من كتابة البريد الالكتروني بشكل صحيح'))
                                                      else if (form
                                                          .control('password')
                                                          .invalid)
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                mySnackBar(
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
                                                                  .control(
                                                                      'email')
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
                                                child:
                                                    const Text("تسجيل الدخول"),
                                              )
                                            : ElevatedButton.icon(
                                                icon: Icon(Icons.login,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onBackground),
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
        ),
      ),
    );
  }

  Future<void> _updateImage(ImageProvider provider) async {
    final ColorScheme newcolorScheme = await ColorScheme.fromImageProvider(
        provider: provider, brightness: Brightness.light);
    setState(() {
      currentColorScheme = newcolorScheme;
      //print(currentColorScheme.toString());
    });
  }
}
