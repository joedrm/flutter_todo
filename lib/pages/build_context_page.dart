import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class BuildContextPage extends StatefulWidget {
  const BuildContextPage({Key? key}) : super(key: key);

  @override
  State<BuildContextPage> createState() => _BuildContextPageState();
}

class _BuildContextPageState extends State<BuildContextPage> {

  LoginViewModel model = LoginViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffffffff),
        body: Center(
            child: Column(
          children: [
            TextButton(
              child: const Text('ShowAlert'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Dialog Title'),
                      content: const Text('This is the content of the dialog.'),
                      actions: [
                        // TextButton(
                        //   onPressed: () => Navigator.pop(context),
                        //   child: const Text('Close'),
                        // ),
                        // TextButton(
                        //   onPressed: () async {
                        //     await Future.delayed(const Duration(seconds: 3));
                        //     if (!mounted) return;
                        //     Navigator.of(context).pop();
                        //   },
                        //   child: const Text('Close'),
                        // ),

                        TextButton(
                          onPressed: () async {
                            var success = await model.login(success: true);
                            if (success) {
                              Navigator.of(context).pushNamed("");
                            }
                          },
                          child: const Text('Close'),
                        ),

                        TextButton(
                          onPressed: () async {
                            await model.login(success: true);
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        )));
  }
}

GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
}

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Future<dynamic>? navigateTo(String routeName) {
    return navigatorKey.currentState?.pushNamed(routeName);
  }

  void goBack() {
    return navigatorKey.currentState?.pop();
  }
}

class LoginViewModel extends ChangeNotifier {
  final NavigationService _navigationService = locator<NavigationService>();
  Future<bool> login({bool success = true}) async {
    /// 模拟网络请求
    await Future.delayed(const Duration(seconds: 1));
    if (success) {
      _navigationService.navigateTo("");
      return true;
    }
    return false;
  }
}

