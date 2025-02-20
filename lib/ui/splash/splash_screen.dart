import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app/ui/onboarding/onboarding_page_view.dart';
import 'package:todo_list_app/ui/welcome/welcome_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> _checkAppState(BuildContext context) async {
    // kiểm tra xem kOnboardingCompleted
    final isCompleted = await _isOnboardingCompleted();
    if (isCompleted) {
      if (!context.mounted) {
        // nếu context vẫn còn thì thì mới thực hiện đi tới màn wellcome
        // phải kiểm tra xem context còn hoạt động không vì cảnh báo không sử dụng context trong async
        return;
      }
      // nếu đã hoàn thành --> di chuyển đến màn welcome
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => WelcomePage(isFistTimeInstall: false)));
      // khi đã vào màn wellcome rồi mà không muốn giữ lại màn splash nữa thì dùng pushReplacement
    } else {
      if (!context.mounted) {
        return;
      }
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => OnboardingPageView()));
    }
  }

  Future<bool> _isOnboardingCompleted() async {
    // kiểm tra xem kOnboardingCompleted
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final result = prefs.getBool('kOnboardingCompleted');
      return result ?? false;
      // vi hàm getBool sẽ trả về giá trị bool hoặc null --> cần có ?? kiểm tra thêm
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkAppState(context);
    return Scaffold(
      backgroundColor: Color(0xff121212),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OnboardingPageView(),
              ),
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/svg/logo_app.svg',
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              const Text(
                'UpTodo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
