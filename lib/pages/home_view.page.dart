import 'package:brimlet/blocs/main.bloc.dart';
import 'package:brimlet/pages/login.page.dart';
import 'package:brimlet/widgets/op_snack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainBloc mainBloc = Provider.of<MainBloc>(context);

    void _goToLogin() {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => const LoginPage(),
        ),
      );
    }

    void _logout() {
      Future logoutFuture = mainBloc.ffLogout();

      logoutFuture.then((value) {
        popSnack(
          context: context,
          text: "Signed Out",
          hue: Colors.green,
        );
        _goToLogin();
      }).onError((error, stackTrace) {
        popSnack(context: context, text: "Sign Out Failed");
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome ${mainBloc.user["displayName"]}",
                style: const TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: _logout,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.arrow_left_rounded,
                        ),
                        Text(
                          "Sign Out",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
