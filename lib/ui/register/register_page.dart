import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_app/common/common.dart';
import 'package:todo_list_app/ui/login/login_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff121212),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined,
                size: 18, color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            _buildForm(false, 'Username', 'Enter your Username'),
            _buildForm(true, 'Password', '* * * * * * * *'),
            _buildForm(true, 'Confirm Password', '* * * * * * * *'),
            _buildButtonLogin(),
            _buildOrSplitDivider(),
            _buildSocialLogin('assets/png/google.png', 'Register with Google'),
            _buildSocialLogin('assets/png/apple.png', 'Register with Facebook'),
            _buildHaveAccount(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: 20).copyWith(top: 10, bottom: 23),
      child: Text(
        'Register',
        style: TextStyle(
          fontFamily: 'Lato',
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildForm(bool isPassword, String title, String hintText) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24).copyWith(bottom: 25),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Lato',
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                    fontFamily: 'Lato',
                    color: Color(0xff535353),
                    fontSize: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  fillColor: Color(0xff1D1D1D),
                  filled: true,
                ),
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: Colors.white,
                  fontSize: 16,
                ),
                obscureText: isPassword,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonLogin() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: CustomButton(
        onPressed: () {},
        textButton: 'Register',
        backgroundColor: Color(0xff8875FF),
        // disabledBackgroundColor: Color(0xff8875FF).withOpacity(0.5),
        //  nếu có disabledBackgroundColor thì sẽ trở thành onPressed = null
      ),
    );
  }

  Widget _buildOrSplitDivider() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24).copyWith(top: 18, bottom: 9),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: Color(0xff979797),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 4),
            child: const Text(
              'or',
              style: TextStyle(
                fontFamily: 'Lato',
                color: Color(0xff979797),
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              height: 2,
              color: Color(0xff979797),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLogin(String asset, String textButton) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24).copyWith(top: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: Color(0xff8875FF),
          )),
      child: InkWell(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              asset,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 14.5).copyWith(left: 10),
              child: Text(
                textButton,
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHaveAccount(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 36, bottom: 20),
      alignment: Alignment.center,
      child: RichText(
          text: TextSpan(
        text: 'Already have an account?',
        style: TextStyle(
          fontFamily: 'Lato',
          color: Colors.white,
          fontSize: 16,
        ),
        children: [
          TextSpan(
            text: ' Login',
            style: TextStyle(
              fontFamily: 'Lato',
              color: Color(0xff8875FF),
              fontSize: 16,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                _goToLoginPage(context);
              },
          ),
        ],
      )),
    );
  }

  void _goToLoginPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));
  }
}
