import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app/ui/onboarding/onboarding_child_page.dart';
import 'package:todo_list_app/ui/utils.enums/onboarding_page_posistion.dart';

import '../welcome/welcome_page.dart';

class OnboardingPageView extends StatefulWidget {
  const OnboardingPageView({super.key});

  @override
  State<OnboardingPageView> createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends State<OnboardingPageView> {
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        // không cho người dùng lướt sang
        children: [
          OnboardingChildPage(
            onboardingPagePosition: OnboardingPagePosistion.page1,
            onNextButtonPressed: () {
              pageController.jumpToPage(1);
            },
            onPreviousButtonPressed: () {},
            onSkipButtonPressed: () {
              _markOnboardingCompleted();

              _goToWelcomePage();
            },
          ),
          OnboardingChildPage(
            onboardingPagePosition: OnboardingPagePosistion.page2,
            onNextButtonPressed: () {
              pageController.jumpToPage(2);
            },
            onPreviousButtonPressed: () {
              pageController.jumpToPage(0);
            },
            onSkipButtonPressed: () {
              _markOnboardingCompleted();

              _goToWelcomePage();
            },
          ),
          OnboardingChildPage(
            onboardingPagePosition: OnboardingPagePosistion.page3,
            onNextButtonPressed: () {
              _markOnboardingCompleted();
              _goToWelcomePage();
            },
            onPreviousButtonPressed: () {
              pageController.jumpToPage(1);
            },
            onSkipButtonPressed: () {
              _markOnboardingCompleted();

              _goToWelcomePage();
            },
          ),
        ],
      ),
    );
  }

  void _goToWelcomePage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const WelcomePage(isFistTimeInstall: true)));
  }

  Future<void> _markOnboardingCompleted() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("kOnboardingCompleted", true);
    } catch (e) {
      return;
    }
  }
}
