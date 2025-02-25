import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/common/common.dart';
import 'package:todo_list_app/ui/login/login_page.dart';
import 'package:todo_list_app/ui/register/bloc/register_cubit.dart';
import '../../domains/authentication_repository/authentication_repository.dart';

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
      body: BlocProvider(
        create: (context) {
          final authenticationRepository =
              context.read<AuthenticationRepository>();
          return RegisterCubit(authenticationRepository);
        },
        child: RegisterView(),
      ),
    );
  }
}

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmPasswordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          _buildForm(false, false, 'Username', 'Enter your Username'),
          _buildForm(true, false, 'Password', '* * * * * * * *'),
          _buildForm(true, true, 'Confirm Password', '* * * * * * * *'),
          _buildButtonRegister(),
          _buildOrSplitDivider(),
          _buildSocialRegister('assets/png/google.png', 'Register with Google'),
          _buildSocialRegister(
              'assets/png/apple.png', 'Register with Facebook'),
          _buildHaveAccount(context),
        ],
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

  Widget _buildForm(
      bool isPassword, bool isConfirmPassword, String title, String hintText) {
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
                controller: isPassword
                    ? isConfirmPassword
                        ? _confirmPasswordTextController
                        : _passwordTextController
                    : _emailTextController,
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

  Widget _buildButtonRegister() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: CustomButton(
        onPressed: _onTapRegister,

        textButton: 'register'.tr(),
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
            child: Text(
              'or'.tr(),
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

  Widget _buildSocialRegister(String asset, String textButton) {
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
        text: 'already_have_an_account'.tr(),
        style: TextStyle(
          fontFamily: 'Lato',
          color: Colors.white,
          fontSize: 16,
        ),
        children: [
          TextSpan(
            text: 'login'.tr(),
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

  void _onTapRegister() {
    final registerCubit = BlocProvider.of<RegisterCubit>(context);
    final email = _emailTextController.text;
    final password = _passwordTextController.text;

    registerCubit.register(email, password);
  }
}
