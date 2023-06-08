import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howlook/common/layout/default_layout.dart';
import 'package:howlook/review/feedback/view/chart_page_screen.dart';
import 'package:dio/dio.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/review/feedback/model/feedback_result_model.dart';

class FeedbackResultCard extends StatefulWidget {
  // 포스트 아이디
  final int postId;
  // 첫 장 이미지 경로
  final String mainPhotoPath;
  final double averageScore;
  final double maleScore;
  final double femaleScore;

  const FeedbackResultCard({
    Key? key,
    required this.postId,
    required this.mainPhotoPath,
    required this.averageScore,
    required this.maleScore,
    required this.femaleScore,
  }) : super(key: key);

  factory FeedbackResultCard.fromModel({
    required FBResultModel model,
  }) {
    return FeedbackResultCard(
      postId: model.postId,
      mainPhotoPath: model.mainPhotoPath,
      averageScore: model.averageScore,
      maleScore: model.maleScore,
      femaleScore: model.femaleScore,
    );
  }

  @override
  State<FeedbackResultCard> createState() => _FeedbackResultCardState();
}

class _FeedbackResultCardState extends State<FeedbackResultCard> {


  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    print(widget.postId); // postId 값 출력
    return CustomScrollView(
          slivers: [
            SliverAppBar( // 헤더 영역
              expandedHeight: MediaQuery.of(context).size.width * 1.0,  // 헤더의 최대 높이
              pinned: true, // 축소시 상단에 AppBar가 고정되는지 설정
              flexibleSpace: FlexibleSpaceBar(// 늘어나는 영역의 UI 정의
                title: tabTitle(),
                background: //Image.asset(images[0], fit: BoxFit.cover,),
                Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.network('${widget.mainPhotoPath}'),
                      Container(
                        child: Image.network(
                          '${widget.mainPhotoPath}',
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ]),
              ),
              backgroundColor: Colors.black45,
            ),
            SliverFillRemaining(
              // 내용 영역
                child: Column(
                  children: [
                    Text('성별 점수 그래프',style: TextStyle(fontSize: 18, color: Colors.black, fontFamily: 'NotoSans'),),
                    ChartPage(
                      postId: widget.postId,
                    ),
                  ],
                )
            ),
          ],);
  }

  Widget tabTitle(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(''),
            Text('여자 평균', style: TextStyle(color: Colors.white,fontSize: 15),),
            Text('${widget.femaleScore}점', style: TextStyle(color: Colors.white,fontSize: 15),),
          ],
        ),
        // Container(
        //   width: 1,
        //   height: 50,
        //   color: Colors.white,
        // ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,

          children: [
            Text(''),
            Text('종합 평균', style: TextStyle(color: Colors.white,fontSize: 15),),
            Text('${widget.averageScore}점', style: TextStyle(color: Colors.white,fontSize: 15),),
          ],
        ),
        // Container(
        //   width: 1,
        //   height: 50,
        //   color: Colors.white,
        // ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(''),
            Text('남자 평균', style: TextStyle(color: Colors.white,fontSize: 15),),
            Text('${widget.maleScore}점', style: TextStyle(color: Colors.white,fontSize: 15),),
          ],
        )
      ],
    );
  }
}
