import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/user/view/signup/first_signup_screen.dart';

class MainSignupScreen extends StatelessWidget {
  const MainSignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: '',
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 16.0,
                ),
                _Title(),
                const SizedBox(
                  height: 30,
                ),
                _SubTitle(),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _LabelText(
                      labelText: '내 모습 그대로 당당하게 😄',
                    ),
                    _minText(
                      minText: "나의 정보를 사실대로 올려 주세요.",
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    _LabelText(
                      labelText: '얼굴은 꼭 제외해주세요! 🙅‍',
                    ),
                    _minText(
                      minText: "HowLook의 정체성을 지켜 주세요",
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    _LabelText(
                      labelText: '건전한 게시물 📋',
                    ),
                    _minText(
                      minText: "건전한 게시글 위주로 올려 주세요",
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    _LabelText(
                      labelText: '신고는 적극적으로 🚨',
                    ),
                    _minText(
                      minText: "건전한 HowLook만의 문화를 같이 만들어가요.",
                    ),
                  ],
                ),
                const SizedBox(
                  height: 250,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: PRIMARY_COLOR,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      minimumSize: Size(100, 50),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => FirstSignupScreen(),
                          ),
                      );
                    },
                    child: Text(
                      "계속하기",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                )
              ],
            ),
          ),
        ));
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "HowLook에 오신걸 환영해요! ☺️",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'NotoSans',
        fontSize: 25,
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
      "아래의 규칙들을 꼭 명심해 주세요",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'NotoSans',
        fontSize: 15,
        fontWeight: FontWeight.w200,
        color: Colors.black87,
      ),
    );
  }
}

class _LabelText extends StatelessWidget {
  final String? labelText;

  const _LabelText({
    this.labelText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '     ✓ $labelText',
        style: TextStyle(
          fontFamily: 'NotoSans',
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        //textAlign: TextAlign.left,
      ),
    );
  }
}

class _minText extends StatelessWidget {
  final String? minText;

  const _minText({
    this.minText,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '       $minText',
        style: TextStyle(
          fontFamily: 'NotoSans',
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: PRIMARY_COLOR,
        ),
        //textAlign: TextAlign.left,
      ),
    );
  }
}



