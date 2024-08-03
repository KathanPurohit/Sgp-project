import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/src/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../components/my_text_field.dart';
import '../blocs/sign_up_bloc/sign_up_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  bool signUpRequired = false;

  // Password requirement state variables
  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool contains8Length = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          setState(() {
            signUpRequired = false;
          });
        } else if (state is SignUpProcess) {
          setState(() {
            signUpRequired = true;
          });
        } else if (state is SignUpFailure) {
          // Handle failure state
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    MyTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(CupertinoIcons.mail_solid),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please fill in this field';
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$').hasMatch(val)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: obscurePassword,
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: const Icon(CupertinoIcons.lock_fill),
                      onChanged: (val) {
                        setState(() {
                          containsUpperCase = val!.contains(RegExp(r'[A-Z]'));
                          containsLowerCase = val.contains(RegExp(r'[a-z]'));
                          containsNumber = val.contains(RegExp(r'[0-9]'));
                          containsSpecialChar = val.contains(RegExp(r'[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]'));
                          contains8Length = val.length >= 8;
                        });
                      },
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                            iconPassword = obscurePassword ? CupertinoIcons.eye_fill : CupertinoIcons.eye_slash_fill;
                          });
                        },
                        icon: Icon(iconPassword),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please fill in this field';
                        } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$').hasMatch(val)) {
                          return 'Please enter a valid password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildPasswordRequirement("1 uppercase", containsUpperCase),
                              _buildPasswordRequirement("1 lowercase", containsLowerCase),
                              _buildPasswordRequirement("1 number", containsNumber),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildPasswordRequirement("1 special character", containsSpecialChar),
                              _buildPasswordRequirement("8 minimum character", contains8Length),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    MyTextField(
                      controller: nameController,
                      hintText: 'Name',
                      obscureText: false,
                      keyboardType: TextInputType.name,
                      prefixIcon: const Icon(CupertinoIcons.person_fill),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please fill in this field';
                        } else if (val.length > 30) {
                          return 'Name too long';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    if (!signUpRequired)
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              MyUser myUser = MyUser.empty;
                              myUser.emailid = emailController.text;
                              myUser.name = nameController.text;
                              
                              context.read<SignUpBloc>().add(
                                SignUpRequired(myUser, passwordController.text)
                              );
                            }
                          },
                          style: TextButton.styleFrom(
                            elevation: 3.0,
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60)
                            )
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                            child: Text(
                              'Sign Up',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          )
                        ),
                      )
                    else
                      const CircularProgressIndicator()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordRequirement(String text, bool isMet) {
    return Text(
      "⚈  $text",
      style: TextStyle(
        color: isMet ? Colors.green : Theme.of(context).colorScheme.onSurface
      ),
    );
  }
}