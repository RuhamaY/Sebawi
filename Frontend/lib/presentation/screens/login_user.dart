import 'package:Sebawi/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/providers/login_user_provider.dart';

class LoginUser extends ConsumerWidget {
  const LoginUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginNotifier = ref.watch(loginProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 35),
              child: Image.asset(
                'assets/images/sebawilogo.png',
                width: 140.0,
                height: 140.0,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 35),
              child: Text(
                'Login',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 2.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 35.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.0),
                  Text(
                    'Welcome back!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35)
                  .copyWith(bottom: 10),
              child: TextFormField(
                controller: loginNotifier.usernameController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(bottom: 4.0),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 31, 78, 33),
                      style: BorderStyle.solid,
                      width: 2,
                    ),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(213, 213, 213, 1),
                    ),
                  ),
                  labelText: 'Username',
                  errorText: loginNotifier.usernameError,
                  labelStyle: const TextStyle(
                    color: Color.fromARGB(255, 165, 165, 165),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onChanged: loginNotifier.setUsername,
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: TextField(
                controller: loginNotifier.passwordController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(bottom: 4.0),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 31, 78, 33),
                      style: BorderStyle.solid,
                      width: 2,
                    ),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(213, 213, 213, 1),
                    ),
                  ),
                  labelStyle: const TextStyle(
                    color: Color.fromARGB(255, 165, 165, 165),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  labelText: 'Password',
                  errorText: loginNotifier.passwordError,
                ),
                obscureText: true,
                onChanged: loginNotifier.setPassword,
              ),
            ),
            const SizedBox(height: 40.0),
            CustomButton(
              buttonAction: () => loginNotifier.login(context),
              buttonText: 'Login',
              buttonTextColor: Colors.white,
              buttonColor: const Color.fromARGB(255, 83, 171, 71),
            ),
            if (loginNotifier.loginError != null)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                child: Center(
                  child: Text(
                    loginNotifier.loginError!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(17),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 4.0),
                      child: Text('Don\'t have an account?'),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.go('/signup');
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 66, 148, 69),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
