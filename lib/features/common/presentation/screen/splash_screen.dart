import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:myfarm/config/provider.dart';

import 'dart:math' as math;

import 'package:myfarm/features/authentication/application/supabase_auth_provider.dart';
import 'package:myfarm/features/common/application/network_provider.dart';
import 'package:myfarm/features/common/presentation/widget/my_button.dart';

class SplashScreenAnim extends ConsumerStatefulWidget {
  const SplashScreenAnim({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      AnimatedBuilderDemoState();
}

class AnimatedBuilderDemoState extends ConsumerState<SplashScreenAnim>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; // Define an animation controller

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      // Initialize the animation controller
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _controller.forward().then((value) async {
      // Start the animation and when it's finished, pop the current screen

      var res = await ref.read(networkAwareProvider);
      print('CONNECET RESULT IS INIT STATE $res');
      if (res == NetworkStatus.On) {
        ref.read(authControllerProvider.notifier).currentSession();
      } else {
        // ignore: use_build_context_synchronously
        showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            icon: const Icon(
              Icons.warning,
              size: 50,
              color: Color.fromARGB(255, 240, 52, 77),
            ),
            title: const Text('خطأ'),
            content: Text(
              'تأكد من اتصالك بالانترنت',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              Center(
                child: MyButton(
                    lable: 'إغلاق',
                    onTap: () => {
                          Navigator.of(context).pop(),
                          ref.read(networkAwareProvider),
                        }),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.reset();
    _controller
        .dispose(); // Dispose of the animation controller when the widget is removed from the tree
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
        authControllerProvider,
        (_, state) => state.when(
            error: (error, stackTrace) {
              showDialog(
                context: context,
                builder: (builder) => AlertDialog(
                  icon: const Icon(
                    Icons.warning,
                    size: 50,
                    color: Color.fromARGB(255, 240, 52, 77),
                  ),
                  title: const Text('خطأ'),
                  content: Text(
                    'للأسف هناك خطأ  \n  بيانات الخطأ\n ${error.toString()}\n ',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  actions: <Widget>[
                    Center(
                      child: MyButton(
                          lable: 'إغلاق',
                          onTap: () => {
                                Navigator.of(context).pop(),
                              }),
                    ),
                  ],
                ),
              );
            },
            data: (data) => {
                  if (data != null)
                    {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/homepage', (route) => false),
                    }
                  else
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/loginpage', (route) => false),
                },
            loading: () => const CircularProgressIndicator()));
    return Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        AnimatedBuilder(
          // Use AnimatedBuilder to animate the rotation of the bird image
          animation: _controller,
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 2,
            child: Image.asset("images/logo2.jpg"), // The bird image to animate
          ),
          builder: (BuildContext context, Widget? child) {
            return Transform.rotate(
              angle: _controller.value *
                  2.0 *
                  math.pi, // Rotate the image by the animation value
              child: child,
            );
          },
        ),
        Container(height: 15),
        ShaderMask(
          // Use ShaderMask to add a gradient to the "Flutter UIX" text
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              colors: [Color(0xFF0089CF), Color(0xFF00CDBA)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds, textDirection: TextDirection.rtl);
          },
          child: Text(
            "جاري فتح التطبيق",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        // Text(
        //   "جاري فتح التطبيق",
        //   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        //       fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        //   textAlign: TextAlign.center,
        // ),
      ])),
    );
  }
}
