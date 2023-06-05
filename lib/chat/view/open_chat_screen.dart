import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/chat/component/chat_room_card.dart';
import 'package:howlook/chat/provider/chat_provider.dart';

class OpenChatScreen extends ConsumerStatefulWidget {
  const OpenChatScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<OpenChatScreen> createState() => _OpenChatScreenState();
}

class _OpenChatScreenState extends ConsumerState<OpenChatScreen> {
  int check1 = 0;
  int check2 = 0;

  @override
  void initState() {
    super.initState();
    check1 = 0;
    check2 = 0;
  }

  @override
  Widget build(BuildContext context) {
    final datas = ref.watch(newChatProvider);
    final List<Widget> chatsType = [
      titleText("대화 중인 오픈 톡"),
      titleText("참여 가능한 오픈톡"),
    ];

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(newChatProvider.notifier).getChatList();
      },
      child: ListView.separated(
        itemCount: chatsType.length,
        itemBuilder: (BuildContext context, int index) {
          final chatType = chatsType[index];
          return Card(
            color: Colors.white,
            elevation: 4,
            margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ExpansionTile(
              textColor: Colors.black,
              collapsedTextColor: Colors.black,
              iconColor: Colors.black,
              collapsedIconColor: Colors.black,
              initiallyExpanded: true,
              title: chatType,
              children: datas.map((data) {
                if (index == 0) {
                  // 참여 중인 오픈톡만 출력
                  if (data.enter) {
                    return ChatRoomCard.fromModel(model: data);
                  } else {
                    ++check1;
                    if (check1 == 5) {
                      check1 = 0;
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 10,
                        child: const Center(
                          child: Text(
                            "현재 참여 중인 오픈 톡방이 없습니다.\n다양한 오픈 톡방에 참여하여 패션 이야기를 나눠봐요 :)",
                            style: TextStyle(
                              color: Colors.black87,
                              fontFamily: "NanumSquareNeo",
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }
                } else {
                  if (!data.enter) {
                    return ChatRoomCard.fromModel(model: data);
                  } else {
                    ++check2;
                    if (check2 == 5) {
                      check2 = 0;
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 10,
                        child: const Center(
                          child: Text(
                            "현재 참여 가능한 오픈 톡방이 없습니다.",
                            style: TextStyle(
                              color: Colors.black87,
                              fontFamily: "NanumSquareNeo",
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }
                }
              }).toList(),
            ),
          );
        },
        separatorBuilder: (_, index) {
          return Container();
        },
      ),
    );
  }

  Widget titleText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 22,
          fontFamily: 'NanumSquareNeo',
          fontWeight: FontWeight.w900,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}

// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// SizedBox(
// width: MediaQuery.of(context).size.width,
// child: titleText("대화 중인 오픈톡"),
// ),
// Expanded(
// child: ListView.separated(
// itemCount: data.length,
// itemBuilder: (BuildContext context, int index) {
// return GestureDetector(
// onTap: () {
// // Navigator.of(context).push(
// //   MaterialPageRoute(
// //     builder: (_) => FeedDetailScreen(
// //       postId: pItem.postId,
// //     ),
// //   ),
// // );
// },
// child: data[index].enter
// ? ChatRoomCard.fromModel(model: data[index])
//     : (index == data.length - 1
// ? SizedBox(
// width: 100,
// height: 100,
// child: const Center(
// child: Text("현재 참여 중인 채팅 방이 없습니다"),
// ),
// )
//     : const SizedBox()),
// );
// },
// separatorBuilder: (_, index) {
// return const SizedBox();
// },
// ),
// ),
// const Divider(color: Colors.black45),
// SizedBox(
// width: MediaQuery.of(context).size.width,
// child: titleText("참여 가능한 오픈톡"),
// ),
// Expanded(
// child: ListView.separated(
// itemCount: data.length,
// itemBuilder: (BuildContext context, int index) {
// return GestureDetector(
// onTap: () {
// // Navigator.of(context).push(
// //   MaterialPageRoute(
// //     builder: (_) => FeedDetailScreen(
// //       postId: pItem.postId,
// //     ),
// //   ),
// // );
// },
// child: !data[index].enter
// ? ChatRoomCard.fromModel(model: data[index])
//     : const SizedBox(),
// );
// },
// separatorBuilder: (_, index) {
// return const SizedBox();
// },
// ),
// ),
// ],