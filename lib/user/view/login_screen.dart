import 'dart:convert';
import 'dart:io';

import 'package:actual/common/component/custm_text_form_field.dart';
import 'package:actual/common/const/colors.dart';
import 'package:actual/common/const/data.dart';
import 'package:actual/common/layout/default_layout.dart';
import 'package:actual/common/view/root_tab.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final dio = Dio();

    return DefaultLayout(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Title(),
                SizedBox(
                  height: 16.0,
                ),
                _SubTitle(),
                Image.asset(
                  'asset/img/misc/logo.png',
                  width: MediaQuery.of(context).size.width / 3 * 2,
                ),
                CustomTextFormField(
                  hintText: 'email',
                  onChanged: (String value) {
                    email = value;
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                CustomTextFormField(
                  hintText: 'password',
                  onChanged: (String value) {
                    password = value;
                  },
                  obscureText: true,
                ),
                SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final rawString = '$email:$password';
                    print(rawString);
                    Codec<String, String> stringToBase64 = utf8.fuse(base64);

                    String uri = 'http://$ip/auth/login';
                    print(uri);
                    String token = stringToBase64.encode(rawString);
                    final resp = await dio.post(
                      uri,
                      options: Options(
                        headers: {
                          'authorization': 'Basic $token',
                        },
                      ),
                    );
                    final refreshToken = resp.data['refreshToken'];
                    final accessToken = resp.data['accessToken'];

                    await storage.write(key: REFRESH_TOKEN_KEY, value: refreshToken);
                    await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => RootTab(),
                        ),
                      );
                    print(resp.data);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: PRIMARY_COLOR,
                  ),
                  child: Text(
                    'Sign In',
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextButton(
                  onPressed: () async {
                    try {

                    } on DioError catch (e) {
                      e.toString();
                    }
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Welcome!',
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Please input email and password. :)',
      style: TextStyle(
        fontSize: 16,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}
