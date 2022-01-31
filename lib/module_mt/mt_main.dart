import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/modulapp/camera/loadingview.dart';
import 'package:hero/hore_route.dart';
import 'package:hero/module_mt/presentation/auth/bloc/auth_cubit.dart';
import 'package:hero/module_mt/presentation/auth/login_mt_page.dart';
import 'package:hero/module_mt/presentation/menu_mt.dart';
import 'package:hero/util/uiutil.dart';

class MTHomeControllpage extends StatefulWidget {
  static const routeName = '/';
  const MTHomeControllpage({Key? key}) : super(key: key);

  @override
  _MTHomeControllpageState createState() => _MTHomeControllpageState();
}

class _MTHomeControllpageState extends State<MTHomeControllpage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..setupData(),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthInitial) {
            return const LoadingNunggu("Mempersiapkan data\n mohon menunggu");
          }

          if (state is AuthLoading) {
            return const LoadingNunggu("Mempersiapkan data\n mohon menunggu");
          }
          if (state is AuthNotLoggedIn) {
            return const LoginPageMt();
          }

          if (state is AuthAlreadyLoggedIn) {
            return const MenuMt();
          }

          return const ErrorPage(message: 'Gagal mendapatkan data');
        },
      ),
    );
  }
}

class MTRootApp extends StatelessWidget {
  MTRootApp({Key? key}) : super(key: key);
  final HoreRoute _route = HoreRoute();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hore Mobile Apps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MTHomeControllpage(),
      navigatorObservers: <NavigatorObserver>[
        SwipeBackObserver(),
      ],
      routes: const <String, WidgetBuilder>{},
      onGenerateRoute: (settings) {
        return _route.getRoute(settings);
      },
    );
  }
}
