import 'package:flutter/material.dart';
import 'package:todo_list_app/ui/category/category_list_page.dart';
import 'package:todo_list_app/ui/category/create_or_edit_category.dart';
import 'package:todo_list_app/ui/main/main_page.dart';
import 'package:todo_list_app/ui/splash/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  // đảm bảo thư viện hỗ trợ đa ngôn ngữ easy_localization đã được khởi tạo trước khi runApp
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('vi')],
      path: 'assets/translations',
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: SplashScreen(),
    );
  }
}
