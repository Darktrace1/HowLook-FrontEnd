import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/feed/component/main_feed_comment_card.dart';
import 'package:howlook/feed/model/main_feed_detail_model.dart';
import 'package:howlook/feed/model/main_feed_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MainFeedDetailCard extends StatelessWidget {
  final UserInfoModel userPostInfo;
  // 포스트 아이디
  final int npostId;
  // 이미지
  final List<PhotoDTOs> photoDTOs;
  // 이미지 갯수
  final int photoCnt;
  // 좋아요
  final int likeCount;
  // 댓글
  final int commentCount;
  // 내용
  final String content;
  // 날짜
  final List<dynamic> regDate;

  const MainFeedDetailCard(
      {required this.userPostInfo,
      required this.npostId,
      required this.photoDTOs,
      required this.photoCnt,
      required this.likeCount,
      required this.commentCount,
      required this.content,
      required this.regDate,
      Key? key})
      : super(key: key);

  factory MainFeedDetailCard.fromModel({
    required MainFeedDetailModel model,
  }) {
    return MainFeedDetailCard(
      userPostInfo:
          model.userPostInfo, //List<UserInfoModel>.from(model.userPostInfo),
      npostId: model.npostId,
      photoDTOs: model.photoDTOs,
      photoCnt: model.photoCnt,
      likeCount: model.likeCount,
      commentCount: model.commentCount,
      content: model.content,
      regDate: model.regDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController();
    // 임시로 리스트 주기
    List<String> list = [
      'asset/img/Profile/HL1.JPG',
      'asset/img/Profile/HL2.JPG',
      'asset/img/Profile/HL3.JPG',
    ];
    // 게시글 날짜 등록
    String Date = '${regDate[0]}.${regDate[1]}.${regDate[2]}';

    List<int> bodyinfo = [userPostInfo.memberHeight, userPostInfo.memberWeight];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(width: 10.0),
                CircleAvatar(
                  radius: 18.0,
                  backgroundImage: Image.asset(
                    //'http://$API_SERVICE_URI/photo/${userPostInfo.profilePhoto}',
                    'asset/img/Profile/HL1.JPG',
                    fit: BoxFit.cover,
                  ).image,
                ),
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userPostInfo.memberId,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      bodyinfo.join(' · '),
                      style: TextStyle(
                        color: BODY_TEXT_COLOR,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: PageView.builder(
                controller: _controller,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    //child: Image.network(images[index], fit: BoxFit.cover,),
                    child: Image.asset(
                      //'http://${API_SERVICE_URI}/photo/${photoDTOs[index].path}',
                      'asset/img/Profile/HL1.JPG',
                      fit: BoxFit.cover,
                    ),
                    // -> 네트워크로 수정하기
                  );
                },
                itemCount: photoCnt,
              ),
            ),
            Positioned(
              bottom: 19,
              right: 18,
              child: SmoothPageIndicator(
                controller: _controller,
                count: photoCnt,
                effect: ExpandingDotsEffect(
                    spacing: 5.0,
                    radius: 14.0,
                    dotWidth: 9.0,
                    dotHeight: 10.0,
                    paintStyle: PaintingStyle.fill,
                    dotColor: Colors.grey,
                    activeDotColor: PRIMARY_COLOR),
              ),
            ),
          ],
        ),
        Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 30),
                        Text(
                          Date,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'NotoSans',
                            fontWeight: FontWeight.w200,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    TextButton.icon(
                      label: Text(''),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return MainFeedDetailComment(
                              npostId: npostId,
                            );
                          },
                          backgroundColor: Colors.transparent,
                        );
                      },
                      icon: Icon(
                        Icons.comment,
                        size: 25.0,
                        color: Colors.black,
                      ),
                      style: TextButton.styleFrom(
                        minimumSize: Size(10, 10),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 25,
                  bottom: 10,
                  right: 0,
                  left: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 30),
                          Text(
                            userPostInfo.memberId,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            content,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                      TextButton.icon(
                        label: Text(''),
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite_border,
                          size: 25.0,
                          color: Colors.black,
                        ),
                        style: TextButton.styleFrom(minimumSize: Size(10, 10)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 100),
              ],
            ),
          ],
        )
      ],
    );
  }
}