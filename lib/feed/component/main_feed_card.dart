import 'package:flutter/material.dart';
import 'package:howlook/common/const/colors.dart';
import 'package:howlook/feed/model/main_feed_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MainFeedCard extends StatelessWidget {
  // 포스트 아이디
  final int NPostId;
  // 이름
  final String name;
  // 별명
  final String nickname;
  // 프로필 사진
  final Widget profile_image;
  // 이미지
  final List<String> images;
  // 이미지 갯수
  final int PhotoCnt;
  // 몸무게, 키
  final List<double> bodyinfo;

  const MainFeedCard(
      {required this.NPostId,
      required this.name,
      required this.nickname,
      required this.profile_image,
      required this.images,
      required this.PhotoCnt,
      required this.bodyinfo,
      Key? key})
      : super(key: key);

  factory MainFeedCard.fromModel({
    required MainFeedModel model,
  }) {
    return MainFeedCard(
      NPostId: model.NPostId,
      PhotoCnt: model.PhotoCnt,
      images: model.images,
      name: model.name,
      nickname: model.nickname,
      profile_image: CircleAvatar(
        radius: 18,
        // 여기에 프로필 사진 없을 경우, 기본 이미지로 로드하는것도 있어야 할 듯,,,
        /*
        * backgroundImage: profile_image == null
        * ? AssetImage('asset/img/Profile/HL2.JPG')
        * : FileImage(File(profile.path)),
        * */
        backgroundImage: Image.network(
          model.profile_image,
          fit: BoxFit.cover,
        ).image,
      ),
      bodyinfo: model.bodyinfo,
    );
  }

  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(width: 10.0),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: profile_image,
                ),
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
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
        AspectRatio(
          aspectRatio: 1,
          child: PageView.builder(
            controller: _controller,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Image.network(images[index], fit: BoxFit.cover,),
              );
            },
            itemCount: PhotoCnt,
          ),
        ),
        SizedBox(height: 12),
        SmoothPageIndicator(
          controller: _controller,
          count:  PhotoCnt,
          effect: ExpandingDotsEffect(
              spacing:  5.0,
              radius:  8.0,
              dotWidth:  12.0,
              dotHeight:  12.0,
              paintStyle:  PaintingStyle.fill,
              dotColor:  Colors.grey,
              activeDotColor:  PRIMARY_COLOR
          ),
        ),
      ],
    );
  }
}
