import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_app/common/common.dart';
import 'package:todo_list_app/ui/register/register_page.dart';

import '../login/login_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key, required this.isFistTimeInstall});

  final bool isFistTimeInstall;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      appBar: AppBar(
          backgroundColor: Color(0xff121212),
          elevation: 0,
          leading: isFistTimeInstall
              ? IconButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  icon: Icon(Icons.arrow_back_ios_new_outlined,
                      size: 18, color: Colors.white))
              : null),
      body: Container(
        margin: EdgeInsets.only(top: 109, bottom: 67),
        child: Column(
          children: [
            _buildTitleAndDescription(),
            Spacer(),
            _buildButtonChangeLanguage(context),
            _buildButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleAndDescription() {
    return Center(
      child: Column(
        spacing: 26,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "wellcome_title".tr(),
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
              "wellcome_description".tr(),
              style: TextStyle(
                fontFamily: 'Lato',
                color: Colors.white.withOpacity(0.67),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      spacing: 28,
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: CustomButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  }));
                },
                textButton: "login".tr())),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xff8875FF), width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: CustomButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return RegisterPage();
                }));
              },
              textButton: "create_account".tr(),
              backgroundColor: Color(0xff121212),
            )),
      ],
    );
  }

  Widget _buildButtonChangeLanguage(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24).copyWith(bottom: 31),
      child: ElevatedButton(
        onPressed: () {
          if (context.locale == Locale('en')) {
            context.setLocale(Locale('vi'));
          } else {
            context.setLocale(Locale('en'));
          }
        },
        child: Container(
          height: 48,
          child: Center(
            child: Text(
              "change_language".tr(),
              style: TextStyle(
                fontFamily: 'Lato',
                color: Colors.white,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff8875FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
