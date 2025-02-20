import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_list_app/ui/utils.enums/onboarding_page_posistion.dart';

import '../../common/components/custom_button.dart';

class OnboardingChildPage extends StatelessWidget {
  final OnboardingPagePosistion onboardingPagePosition;
  final VoidCallback onNextButtonPressed;
  final VoidCallback onPreviousButtonPressed;
  final VoidCallback onSkipButtonPressed;
  const OnboardingChildPage(
      {super.key,
      required this.onboardingPagePosition,
      required this.onNextButtonPressed,
      required this.onPreviousButtonPressed,
      required this.onSkipButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121212),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildSkipButton(),
            _buildOnboardingImage(),
            _buildOnboardingPageControl(),
            _buildOnboardingTitleAndContent(),
            _buildOnboardingNextAndPreviousButon(),
          ],
        ),
      ),
    );
  }

  Widget _buildSkipButton() {
    return Container(
      alignment: AlignmentDirectional.centerStart,
      margin: EdgeInsets.only(top: 58),
      child: TextButton(
        onPressed: () {
          onSkipButtonPressed();
        },
        child: Text('skip'.tr(),
            style: TextStyle(
              fontFamily: 'Lato',
              color: Colors.white.withOpacity(0.44),
              fontSize: 16,
            )),
      ),
    );
  }

  Widget _buildOnboardingImage() {
    return SvgPicture.asset(
      onboardingPagePosition.onboardingPageImage(),
      height: 296,
      width: 271,
      fit: BoxFit.contain,
    );
  }

  Widget _buildOnboardingPageControl() {
    return Container(
      margin: EdgeInsets.only(top: 42),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8,
        children: [
          Container(
            height: 4,
            width: 26,
            decoration: BoxDecoration(
              color: onboardingPagePosition == OnboardingPagePosistion.page1
                  ? Colors.white
                  : Color.fromARGB(255, 97, 96, 96),
              borderRadius: BorderRadius.circular(56),
            ),
          ),
          Container(
            height: 4,
            width: 26,
            decoration: BoxDecoration(
              color: onboardingPagePosition == OnboardingPagePosistion.page2
                  ? Colors.white
                  : Color.fromARGB(255, 97, 96, 96),
              borderRadius: BorderRadius.circular(56),
            ),
          ),
          Container(
            height: 4,
            width: 26,
            decoration: BoxDecoration(
              color: onboardingPagePosition == OnboardingPagePosistion.page3
                  ? Colors.white
                  : Color.fromARGB(255, 97, 96, 96),
              borderRadius: BorderRadius.circular(56),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOnboardingTitleAndContent() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Column(
        spacing: 42,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              onboardingPagePosition.onboadringPageTitle(),
              style: TextStyle(
                fontFamily: 'Lato',
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 38),
            child: Text(
              onboardingPagePosition.onboadringPageContent(),
              style: TextStyle(
                fontFamily: 'Lato',
                color: Colors.white.withOpacity(0.87),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardingNextAndPreviousButon() {
    return Container(
      margin: EdgeInsets.only(top: 107, left: 24, right: 24),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextButton(
          onPressed: () {
            onPreviousButtonPressed();
          },
          child: Container(
            height: 48,
            child: Center(
              child: Text(
                'BACK',
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: Colors.white.withOpacity(0.44),
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        Spacer(),
        CustomButton(
          onPressed: () {
            onNextButtonPressed();
          },
          textButton: onboardingPagePosition == OnboardingPagePosistion.page3
              ? 'GET STARTED'
              : 'NEXT',
        ),
      ]),
    );
  }
}
