import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/review/normal_review_screen.dart';
import 'package:howlook/review/creater_review_screen.dart';
import 'package:howlook/review/feedback/normal_feedback_screen.dart';

class MainReviewScreen extends StatefulWidget {
  const MainReviewScreen({Key? key}) : super(key: key);

  @override
  State<MainReviewScreen> createState() => _MainReviewScreenState();
}

class _MainReviewScreenState extends State<MainReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'ReviewLook',
      actions: <Widget>[
        IconButton(onPressed: () {}, icon: Icon(Icons.chat_bubble)),
        IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
      ],
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        '지금 ?명이 당신의 평가를 기다리고 있습니다.',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                    ) //인원 수 넣기
                    ), //height of TabBarView,
                // Container(
                //   child: Padding(
                //     padding: EdgeInsets.all(5),
                //     child: Text('  평가하기', style: TextStyle(fontSize: 12, color: Colors.grey,),),
                //   ),
                // ),
                const SizedBox(
                  height: 15.0,
                ),
                Container(
                    width: 500,
                    child: Divider(color: Colors.grey, thickness: 1.0)),
                const SizedBox(
                  height: 10.0,
                ),
                //const SizedBox(height: 15.0,),
                PanelImage(),
                const SizedBox(
                  height: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      '  평가결과',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    ReviewTabBar(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget PanelImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                setState(() {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CreaterReview(),
                    ),
                  );
                });
              } else if (direction == DismissDirection.startToEnd) {
                setState(() {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => NormalReview(),
                    ),
                  );
                });
              }
            },
            background: Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),

                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Color(0xFFD07AFF),
                ),
                child: const Text(
                  '일반 평가',
                  style: TextStyle(color: Colors.white),
                )),
            secondaryBackground: Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),

                alignment: Alignment.centerRight,
                decoration: BoxDecoration(color: Color(0xFFa6ceff),),
                child: const Text(
                  '크리에이터 평가',
                  style: TextStyle(color: Colors.white),
                )),
            child: SizedBox(
                height: 100.0,
                width: MediaQuery.of(context).size.width,
                child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                          colors: [
                            Color(0xFFa6ceff),
                            Color(0xFFD07AFF),
                          ]),
                    ),
                    child: Center(
                      child: Text(
                        '평가하기',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    )))),
      ),
    );
  }

  ReviewTabBar() {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              labelStyle: TextStyle(fontSize: 15),
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 3,
                    color: Colors.deepPurple,
                  ),
                  insets: EdgeInsets.only(left: 10, right: 14, bottom: 4)),
              isScrollable: true,
              labelPadding: EdgeInsets.only(left: 14, right: 2),
              tabs: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Tab(text: '일반'),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Tab(text: '크리에이터'),
                )
              ],
              indicatorColor: Colors.purple,
              indicatorWeight: 2,
            ),
          ),
          Container(
            height: 400,
            decoration: BoxDecoration(
                border:
                    Border(top: BorderSide(color: Colors.white, width: 10))),
            child: TabBarView(
              children: <Widget>[
                Container(
                  child: NormalFeedback(),
                ),
                Container(
                  child: CreaterFeedback(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget CreaterFeedback() {
    return DefaultLayout(
      child: SingleChildScrollView(
          child: SafeArea(
              child: Container(
                  child: Center(
        child: Text('사용하실 수 없습니다.'),
      )))),
    );
  }
}