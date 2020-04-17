import 'package:Midas/utils/theme.dart';
import 'package:Midas/utils/theme.dart' as prefix1;
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeItemWidget extends StatelessWidget {
  final dynamic data;
  // YoutubePlayerController _controller = YoutubePlayerController();
  YoutubeItemWidget({this.data});
  void listener() async {
    // print(_controller.value);
  }

  @override
  Widget build(BuildContext context) {
    //         {
    // print(data);
    //   "type": "embed",
    //   "data": {
    //     "service": "youtube",
    //     "source": "https://www.youtube.com/watch?v=e_damGE4AXk",
    //     "embed": "https://www.youtube.com/embed/e_damGE4AXk",
    //     "width": 580,
    //     "height": 320,
    //     "caption": ""
    //   }
    // }
    var youtubeId = YoutubePlayer.convertUrlToId(data['source']);
    // var youtubeId =
    //     YoutubePlayer.convertUrlToId('https://youtu.be/XCWfg_S4Bmc');
    // if (youtubeId != null) {
    //   return Container(
    //     height: MediaQuery.of(context).size.height / 2,
    //     padding: EdgeInsets.only(bottom: prefix1.paddingL),
    //     child: YoutubePlayer(
    //         actions: <Widget>[],
    //         context: context,
    //         videoId: youtubeId,
    //         flags: YoutubePlayerFlags(
    //             autoPlay: false,
    //             showVideoProgressIndicator: true,
    //             hideFullScreenButton: false),
    //         videoProgressIndicatorColor: Colors.amber,
    //         onPlayerInitialized: (controller) {
    //           _controller = controller;
    //           _controller.addListener(listener);
    //         }),
    //   );
    // } else {
    //   return Container(
    //     color: colorGrey_2,
    //     width: MediaQuery.of(context).size.width,
    //     height: 50,
    //     child: Center(
    //         child: Row(
    //       // crossAxisAlignment: CrossAxisAlignment.center,
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         Icon(Icons.warning, color: colorGrey_1),
    //         Container(
    //           margin: EdgeInsets.only(left: paddingM),
    //           child: Text("Video không có sẵn", style: style15),
    //         )
    //       ],
    //     )),
    //   );
    // }
  }
}
