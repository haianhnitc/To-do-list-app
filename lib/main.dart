import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/app/app_cubit.dart';
import 'package:todo_list_app/app/app_state.dart';
import 'package:todo_list_app/domains/authentication_repository/authentication_repository.dart';
import 'package:todo_list_app/domains/data_source/firebase_auth_service.dart';
import 'package:todo_list_app/ui/login/login_page.dart';
import 'package:todo_list_app/ui/main/main_page.dart';
import 'package:todo_list_app/ui/splash/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_list_app/ui/utils.enums/authentication_status.dart';
import 'firebase_options.dart';

void main() async {
  // đảm bảo thư viện hỗ trợ đa ngôn ngữ easy_localization đã được khởi tạo trước khi runApp
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('vi')],
      path: 'assets/translations',
      child: const App()));
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthenticationRepository _authenticationRepository;
  late final FirebaseAuthService _firebaseAuthService;

  @override
  void initState() {
    super.initState();
    _firebaseAuthService = FirebaseAuthService();
    _authenticationRepository = AuthenticationRepositoryIpl(
      fireBaseAuthService: _firebaseAuthService,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => _authenticationRepository,
          ),
        ],
        child: BlocProvider(
          create: (context) {
            return AppCubit(_authenticationRepository);
          },
          child: MyApp(),
        ));
  }
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      builder: (context, child) {
        return BlocListener<AppCubit, AppState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                // di den man home
                _navigatorKey.currentState!.pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => MainPage(),
                    ),
                    (route) => false);
                break;
              case AuthenticationStatus.unauthenticated:
                // di den man Login
                _navigatorKey.currentState!.pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                    (route) => false);
                break;
              case AuthenticationStatus.unknown:
                // khong lam gi ca
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) {
        return MaterialPageRoute(
          builder: (_) {
            return const SplashScreen();
          },
        );
      },
    );
  }
}
