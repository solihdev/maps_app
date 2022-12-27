import 'package:flutter/material.dart';
import 'package:mapping_app/ui/map_screen/map_screen.dart';
import 'package:mapping_app/view_models/splash_view_model.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SplashViewModel(),
      builder: (context, child) {
        return Scaffold(
          body: Consumer<SplashViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.latLong != null) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MapScreen(latLong: viewModel.latLong!),
                    ));
              }
              return Center(
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Splash Screen"),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Map"),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
