import 'package:api_demo/presentation/login/state.dart';
import 'package:api_demo/presentation/dashboard/view.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  _load(context) async => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                20.height,
                Text(
                  'Loading',
                  style: boldTextStyle(color: black),
                )
              ],
            ),
          ));
  @override
  Widget build(BuildContext context) {
    final writer = context.read<LoginProvider>();
    final watcher = context.watch<LoginProvider>();
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login Page",
                style: boldTextStyle(size: 22, color: blackColor),
              ),
              8.height,
              Text(
                "Welcome to our app",
                style: primaryTextStyle(),
              ),
              8.height,
              TextFormField(
                onChanged: (p0) => writer.setEmail(p0),
                validator: (value) => value == null
                    ? "Email cannot be empty"
                    : !value.validateEmail()
                        ? "Please enter a valid email"
                        : null,
                decoration: const InputDecoration(
                    hintText: "Email", prefixIcon: Icon(Icons.email)),
              ),
              8.height,
              TextFormField(
                onChanged: (p0) => writer.setPassword(p0),
                obscureText: watcher.passHidden,
                validator: (value) => value == null
                    ? "Password cannot be empty"
                    : value.length < 6
                        ? "Please enter a valid password"
                        : null,
                decoration: InputDecoration(
                    suffix: IconButton(
                        onPressed: () {
                          writer.setPassHidden();
                        },
                        icon: Icon(watcher.passHidden
                            ? Icons.visibility_off
                            : Icons.visibility)),
                    hintText: "Password",
                    prefixIcon: const Icon(Icons.lock)),
              ),
              18.height,
              ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  onPressed: () async {
                   if(_formKey.currentState!.validate()) {
                     _load(context);
                    await writer.login.then((value) => finish(context));
                    if (writer.success != null) {
                      toast("Successful", bgColor: greenColor);
                      if (mounted) {
                        const DashboardView().launch(context, isNewTask: true);
                      }
                    } else {
                      toast("Error in your credentials", bgColor: errorColor);
                    }
                   }
                  },
                  child: Text("Login", style: boldTextStyle(color: white)))
            ],
          ),
        ),
      ),
    ));
  }
}
