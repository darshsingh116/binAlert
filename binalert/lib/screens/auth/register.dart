import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:binalert/bloc/auth/auth_bloc.dart';
import 'package:binalert/bloc/auth/auth_event.dart';
import 'package:binalert/bloc/auth/auth_state.dart';
import 'package:binalert/constants/color_constants.dart';
import 'package:binalert/repositories/firebase_repo.dart';
import 'package:binalert/screens/BottomNavBarScreens/BottomNavBar.dart';
import 'package:binalert/screens/auth/login.dart';
import 'package:binalert/widgets/backgroundContainer.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends HookWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final bioController = useTextEditingController();

    final authRepository = context.read<FirebaseRepository>();

    return Container(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          // TODO: implement listener

          if (state is AuthStateLoggedOut) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          } else if (state is AuthStateLoggedIn) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => NavBarScreens()));
          }
        },
        builder: (context, state) {
          if (state is AuthStateIsInRegistrationView ||
              state is AuthStateIsLoading) {
            return SafeArea(
              child: Scaffold(
                backgroundColor: Color.fromARGB(255, 35, 38, 45),
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 60, 20, 60),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              child: SizedBox(
                                height: 60,
                                child: Text(
                                  "Create Account",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 45,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(30, 20, 30, 5),
                            child: TextField(
                              controller: emailController,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ),
                                fillColor: Colors.black,
                                filled: true,
                                hintText: 'Email',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                            child: TextField(
                              controller: usernameController,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                fillColor: Colors.black,
                                filled: true,
                                hintText: 'Username',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                            child: TextField(
                              controller: bioController,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.description,
                                  color: Colors.white,
                                ),
                                fillColor: Colors.black,
                                filled: true,
                                hintText: 'Bio',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
                            child: TextField(
                              controller: passwordController,
                              obscureText: true,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                fillColor: Colors.black,
                                filled: true,
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state is AuthStateIsLoading) {
                                return CircularProgressIndicator(
                                  color: Colors.white,
                                );
                              }
                              return Container(
                                padding: EdgeInsets.all(10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    final email = emailController.text;
                                    final password = passwordController.text;
                                    final bio = bioController.text;
                                    final username = usernameController.text;
                                    if (email != "" &&
                                        password != "" &&
                                        bio != "" &&
                                        username != "") {
                                      context.read<AuthBloc>().add(Register(
                                            email: email,
                                            password: password,
                                            bio: bio,
                                            username: username,
                                            authRepository: authRepository,
                                          ));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.13,
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          myLightPurple,
                                          myLightPink,
                                          myLightOrange
                                        ],
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Register",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () {
                                context
                                    .read<AuthBloc>()
                                    .add(AuthEventGoToLogin());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Already have an account?  ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      )),
                                  Text("Log in",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          decoration:
                                              TextDecoration.underline)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
