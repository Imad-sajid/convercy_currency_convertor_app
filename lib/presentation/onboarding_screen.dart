import 'package:Convertify/app_utils/app_routes.dart';
import 'package:Convertify/presentation/widgets/size_config.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,),
      
      body: Column(children: [
        Expanded(
            child: Image.asset('assets/icon/icon.png',
                width: MediaQuery.of(context).size.width / 2)),
        Expanded(
          child: IntroductionScreen(
            pages: [
              PageViewModel(
                title: "Convert Realtime updated rates",
                body:
                    "Your realtime conversion rates at the tap of your button.",
              ),
              PageViewModel(
                title: "Exchange rates for cryptocurrencies",
                body:
                    "View the exchange rates for the desired Cryptocurrency from your fiat currency.",
              ),
            ],
            showNextButton: false,
            done: const Text("DONE"),
            doneStyle: ButtonStyle(
              side: WidgetStateProperty.all(
                BorderSide(color: Colors.black),
              ),
              foregroundColor: WidgetStateProperty.all(Colors.black),
            ),
            onDone: () async {
              // Save onboarding completion state
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.setBool('firstTimeOnboarding', false);

                // Navigate to the main screen
                Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.standardCurrency,
                );
            },
          ),
        ),
      ]),
    );
  }
}
