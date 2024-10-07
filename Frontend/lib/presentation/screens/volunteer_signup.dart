import 'package:Sebawi/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/providers/volunteer_signup_provider.dart';

class VolunteerSignup extends ConsumerWidget {
  const VolunteerSignup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupNotifier = ref.watch(volunteerSignupProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                  'Sign Up',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
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
                      'Do something good today.',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: TextFormField(
                  controller: signupNotifier.fullNameController,
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
                    labelText: 'Full name',
                    errorText: signupNotifier.fullNameError,
                  ),
                  onChanged: (value) => signupNotifier.setFullName(value),
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: TextFormField(
                  controller: signupNotifier.emailController,
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
                    labelText: 'Enter Email',
                    errorText: signupNotifier.emailError,
                  ),
                  onChanged: (value) => signupNotifier.setEmail(value),
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: TextFormField(
                  controller: signupNotifier.usernameController,
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
                    labelText: 'Create Username',
                    errorText: signupNotifier.usernameError,
                  ),
                  onChanged: (value) => signupNotifier.setUsername(value),
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: TextFormField(
                  controller: signupNotifier.passwordController,
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
                    labelText: 'Create Password',
                    errorText: signupNotifier.passwordError,
                  ),
                  onChanged: (value) => signupNotifier.setPassword(value),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: TextFormField(
                  controller: signupNotifier.confirmPasswordController,
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
                    labelText: 'Confirm Password',
                    errorText: signupNotifier.confirmPasswordError,
                  ),
                  onChanged: (value) =>
                      signupNotifier.setConfirmPassword(value),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 40.0),
              CustomButton(
                  buttonText: 'Signup',
                  buttonColor: Colors.green.shade800,
                  buttonTextColor: Colors.white,
                  buttonAction: () => signupNotifier.signUp(context)),
              if (signupNotifier.signupError != null)
                Padding(
                  padding: const EdgeInsets.all(17),
                  child: Center(
                    child: Text(
                      signupNotifier.signupError!,
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
                        child: Text('Already signed up?'),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.go('/user_login');
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 66, 148, 69),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
