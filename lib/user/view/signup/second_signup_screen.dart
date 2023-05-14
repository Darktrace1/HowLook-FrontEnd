import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/common/component/cust_textform_filed.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';
import 'package:howlook/user/view/signin/intro_screen.dart';
import 'package:intl/intl.dart';
import 'package:howlook/user/model/signup_model.dart';
import 'package:howlook/user/provider/signup_provider.dart';
import 'package:howlook/user/repository/signup_repository.dart';

class SecondSignupScreen extends ConsumerStatefulWidget {
  const SecondSignupScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SecondSignupScreen> createState() => _SecondSignupScreenState();
}

class _SecondSignupScreenState extends ConsumerState<SecondSignupScreen> {
  @override
  Widget build(BuildContext context) {
    List<SignupModel> newMember = ref.watch(SignupProvider);

    SignupRepository repos = ref.watch(SignupRepositoryProvider);
    // Dio Connection
    final dio = Dio();

    // localhost
    final emulatorIP = "10.0.2.2:3000";
    final simulatorIP = "127.0.0.1:3000";
    final ip = Platform.isIOS ? simulatorIP : emulatorIP;

    void s_postData() async {
      final storage = ref.read(secureStorageProvider);
      final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
      final resp = await dio.put(
        'http://$API_SERVICE_URI/member/socialedit',
        options: Options(headers: {'authorization': 'Bearer $accessToken'}),
        data: {
          'memberBirthDay': newMember[0].birthDay,
          'memberHeight': newMember[0].height,
          'memberName': newMember[0].name,
          'memberNickName': newMember[0].nickName,
          'memberPhone': newMember[0].phone,
          'memberWeight': newMember[0].weight,
        },
      );
    };

    // validate
    final formkey = GlobalKey<FormState>();
    Future<void> _submit() async {
      if (formkey.currentState!.validate() == false) {
        return;
      } else {
        formkey.currentState!.save();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("가입이 완료되었어요 :)"),
            duration: Duration(seconds: 1),
          ),
        );
      }
      // 소셜이 아닐 때
      if (newMember[0].memberId != null)
        repos.postData(signupModel: newMember[0]);
      else // 소셜일 때
      {
        s_postData();
        ref.watch(SignupProvider.notifier).outputSignupModel();
      }

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => IntroScreen(),
        ),
        (route) => false,
      );
    }

    return DefaultLayout(
      title: '',
      child: Form(
        key: formkey,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: SafeArea(
            top: true,
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Title(),
                  const SizedBox(
                    height: 16.0,
                  ),
                  _SubTitle(),
                  const SizedBox(
                    height: 40.0,
                  ),
                  _LabelText(
                    labelText: "이름",
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextFormField(
                    hintText: "이름을 입력해주세요",
                    onChanged: (String value) {
                      ref.read(SignupProvider)[0].name = value;
                    },
                    validator: (value) {
                      if (value!.length < 2) {
                        return "이름은 2자보다 짧을 수 없어요 :(";
                      }
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  _LabelText(
                    labelText: "별명",
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextFormField(
                    hintText: "별명을 입력해주세요",
                    onChanged: (String value) {
                      ref.read(SignupProvider)[0].nickName = value;
                    },
                    validator: (value) {
                      if (value!.length < 1) {
                        return "별명은 1자보다 짧을 수 없어요 :(";
                      } else if (value!.length > 9) {
                        return "별명은 10자보다 길 수 없어요 :(";
                      }
                      // 닉네임 중복 조회
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  _LabelText(
                    labelText: "휴대폰 번호",
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextFormField(
                    hintText: "(예시) 01012341234",
                    onChanged: (String value) {
                      ref.read(SignupProvider)[0].phone = value;
                    },
                    validator: (value) {
                      if (value!.length < 11) {
                        return "휴대폰 번호는 11자 이상입니다 :(";
                      }
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  _LabelText(
                    labelText: "키",
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextFormField(
                    hintText: "키를 입력해주세요",
                    onChanged: (String value) {
                      ref.read(SignupProvider)[0].height = int.parse(value);
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  _LabelText(
                    labelText: "몸무게",
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextFormField(
                    hintText: "몸무게를 입력해주세요",
                    onChanged: (String value) {
                      ref.read(SignupProvider)[0].weight = int.parse(value);
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  TextButton(
                    onPressed: () {
                      DatePicker.showDatePicker(
                        context,
                        showTitleActions: true,
                        minTime: DateTime(1900, 1, 1),
                        maxTime: DateTime(2022, 12, 31),
                        currentTime: DateTime.now(),
                        locale: LocaleType.ko,
                        onConfirm: (date) {
                          ref.read(SignupProvider)[0].birthDay =
                              DateFormat("yyyy-MM-ddTHH:mm:ss.mmm")
                                  .format(date);
                        },
                      );
                    },
                    child: Text(
                      "당신의 생일을 알려주세요 :)",
                      style: TextStyle(
                        color: PRIMARY_COLOR,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                        colors: [
                          Color(0xFFD07AFF),
                          Color(0xFFa6ceff),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        _submit(); // 제출
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (_) => IntroScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        minimumSize: Size(100, 50),
                      ),
                      child: Text(
                        "가입하기",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 80.0,
                  ),
                ],
              ),
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
      "회원가입✏️",
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w700,
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
      "당신의 정보를 기입해주세요 :)",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w100,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}

class _LabelText extends StatelessWidget {
  final String labelText;
  const _LabelText({
    required this.labelText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '$labelText',
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
