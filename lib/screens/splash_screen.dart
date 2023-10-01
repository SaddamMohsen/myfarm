import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';

import 'dart:math' as math;

import 'package:myfarm/features/authentication/presentation/supabase_auth_provider.dart';

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
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _controller.forward().then((value) async {
      // Start the animation and when it's finished, pop the current screen
      ref.read(authControllerProvider.notifier).currentUser();
    });
  }

  @override
  void dispose() {
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
              if (kDebugMode) {
                print(error);
              }
            },
            data: (data) => {
                  if (data != null)
                    {
                      Navigator.popAndPushNamed(context, '/homepage'),
                      // Navigator.of(context).pushNamed('/homepage')
                    }
                  else
                    Navigator.popAndPushNamed(context, '/loginpage')
                },

            ///TODO remove print statement
            loading: () => {print('loading')}));
    return Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        AnimatedBuilder(
          // Use AnimatedBuilder to animate the rotation of the bird image
          animation: _controller,
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 2,
            child: Image.asset(
                "images/myfarmlogo.png"), // The bird image to animate
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
            ).createShader(bounds);
          },
          child: Text(
            "جاري فتح التطبيق",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ])),
    );
  }
}
