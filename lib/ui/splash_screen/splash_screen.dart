import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mapping_app/ui/map_screen/map_screen.dart';
import 'package:mapping_app/utils/my_images.dart';
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
        return SafeArea(
          child: Scaffold(
            body: Consumer<SplashViewModel>(
              builder: (context, viewModel, child) {
                return Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 100,),
                        const Text(
                          "Welcome to Google Map",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 34),
                        ),
                        const SizedBox(height: 100,),
                        SizedBox(
                            width: double.infinity,
                            height: 400,
                            child: Lottie.asset(MyImages.area_map)),
                        const SizedBox(height: 70,),
                        InkWell(
                          child: Container(
                            width: 150,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(6)),
                            child: const Center(
                              child: Text(
                                "Get Started",
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          onTap: () {
                            if (viewModel.latLong != null) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MapScreen(latLong: viewModel.latLong!),
                                  ));
                            }
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
