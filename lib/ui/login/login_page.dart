import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/common/common.dart';
import 'package:todo_list_app/ui/login/bloc/login_cubit.dart';
import 'package:todo_list_app/ui/register/register_page.dart';

import '../../domains/authentication_repository/authentication_repository.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
          return LoginCubit(authenticationRepository);
        },
        child: LoginView(),
      ),
    );
  }
}

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  var _autoValidateMode = AutovalidateMode.disabled;
  var _emailTextController = TextEditingController();
  var _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          _buildForm(),
          _buildButtonLogin(),
          _buildOrSplitDivider(),
          _buildSocialLogin('assets/png/google.png', 'login_with_google'.tr()),
          _buildSocialLogin('assets/png/apple.png', 'login_with_facebook'.tr()),
          _buildHaveNotAccount(context),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: 20).copyWith(top: 30, bottom: 53),
      child: Text(
        'Login'.tr(),
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

  Widget _buildForm() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24).copyWith(bottom: 25),
      child: Form(
        key: _formKey,
        autovalidateMode: _autoValidateMode,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildChildrenForm(false, 'username'.tr(), 'enter_username'.tr()),
            SizedBox(height: 10),
            _buildChildrenForm(true, 'password'.tr(), '* * * * * * * *')
          ],
        ),
      ),
    );
  }

  Widget _buildChildrenForm(bool isPassword, String title, String hintText) {
    return Column(
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
            controller:
                isPassword ? _passwordTextController : _emailTextController,
            validator: (String? value) {
              if (!isPassword) {
                if (value == null || value.isEmpty) {
                  return 'email_is_required'.tr();
                }
                final bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value);
                if (!emailValid) {
                  // email không hợp lệ
                  return 'email_not_valid'.tr();
                }
                return null;
              } else {
                if (value == null || value.isEmpty) {
                  return 'password_is_required'.tr();
                }
                if (value.length < 8) {
                  return 'password_must_be_at_least_8_characters'.tr();
                }
                return null;
              }
            },
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
    );
  }

  Widget _buildButtonLogin() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: CustomButton(
        onPressed: () {
          _onHandleLoginSubmit();
        },
        textButton: 'login'.tr(),
        backgroundColor: Color(0xff8875FF),
        // disabledBackgroundColor: Color(0xff8875FF).withOpacity(0.5),
        //  nếu có disabledBackgroundColor thì sẽ trở thành onPressed = null
      ),
    );
  }

  Widget _buildOrSplitDivider() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24).copyWith(top: 40, bottom: 9),
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

  Widget _buildHaveNotAccount(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 46, bottom: 30),
      alignment: Alignment.center,
      child: RichText(
          text: TextSpan(
        text: 'no_account'.tr(),
        style: TextStyle(
          fontFamily: 'Lato',
          color: Colors.white,
          fontSize: 16,
        ),
        children: [
          TextSpan(
            text: 'register'.tr(),
            style: TextStyle(
              fontFamily: 'Lato',
              color: Color(0xff8875FF),
              fontSize: 16,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                _goToRegisterPage(context);
              },
          ),
        ],
      )),
    );
  }

  void _goToRegisterPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterPage(),
      ),
    );
  }

  void _onHandleLoginSubmit() {
    final loginCubit = BlocProvider.of<LoginCubit>(context);
    final email = _emailTextController.text;
    final password = _passwordTextController.text;

    if (_autoValidateMode == AutovalidateMode.disabled) {
      setState(() {
        _autoValidateMode = AutovalidateMode.always;
      });
    }
    final isValid = _formKey.currentState?.validate() ?? false;
    if (isValid) {
      // call api login
      loginCubit.login(email, password);
    } else {
      // khong lam gi cả
    }
  }
}
