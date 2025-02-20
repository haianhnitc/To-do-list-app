enum OnboardingPagePosistion {
  page1,
  page2,
  page3,
}

extension OnboardingPagePosistionExtension on OnboardingPagePosistion {
  String onboardingPageImage() {
    switch (this) {
      case OnboardingPagePosistion.page1:
        return 'assets/svg/onboarding_page1.svg';
      case OnboardingPagePosistion.page2:
        return 'assets/svg/onboarding_page2.svg';
      case OnboardingPagePosistion.page3:
        return 'assets/svg/onboarding_page3.svg';
    }
  }

  String onboadringPageTitle() {
    switch (this) {
      case OnboardingPagePosistion.page1:
        return 'Manage your tasks';
      case OnboardingPagePosistion.page2:
        return 'Create daily routine';
      case OnboardingPagePosistion.page3:
        return 'Orgonaize your tasks';
    }
  }

  String onboadringPageContent() {
    switch (this) {
      case OnboardingPagePosistion.page1:
        return 'You can easily manage all of your daily tasks in DoMe for free';
      case OnboardingPagePosistion.page2:
        return 'In Uptodo  you can create your personalized routine to stay productive';
      case OnboardingPagePosistion.page3:
        return 'You can organize your daily tasks by adding your tasks into separate categories';
    }
  }
}
