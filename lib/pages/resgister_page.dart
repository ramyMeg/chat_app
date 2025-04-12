import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snackbar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/register_cubit/cubit/register_cubit.dart';
import 'package:chat_app/widget/custom_button.dart';
import 'package:chat_app/widget/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ResgisterPage extends StatelessWidget {
  String? email;

  String? password;
  static String id = 'registerPage';

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoadind) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          Navigator.pushNamed(context, ChatPage.id);
          isLoading = false;
        } else if (state is RegisterFailure) {
          showSnackBar(context, state.errMessage);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: kprimaryColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    Spacer(flex: 1),
                    Image.asset('assets/images/scholar.png'),
                    Text(
                      'Scholar Chat',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'pacifico',
                      ),
                    ),
                    Spacer(flex: 1),
                    Row(
                      children: [
                        Text(
                          'REGITER',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    CustomFormTextField(
                      onChanged: (data) {
                        email = data;
                      },
                      hintText: ' Email',
                    ),
                    SizedBox(height: 10),
                    CustomFormTextField(
                      onChanged: (data) {
                        password = data;
                      },
                      hintText: ' Password',
                    ),
                    SizedBox(height: 30),

                    CustomButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<RegisterCubit>(
                            context,
                          ).registerUser(email: email!, password: password!);
                        } else {}
                      },
                      text: 'Registor',
                    ),
                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context, 'LoginPage');
                          },
                          child: Text(
                            '  Login ',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Spacer(flex: 3),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
