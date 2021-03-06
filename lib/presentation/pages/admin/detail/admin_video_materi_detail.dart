import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:publico/domain/entities/video_materi.dart';
import 'package:publico/presentation/bloc/video_materi/video_materi_cubit.dart';
import 'package:publico/presentation/pages/admin/edit/video_materi_edit_page.dart';
import 'package:publico/presentation/widgets/publico_materi_edit_bottom_sheet.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';
import 'package:video_player/video_player.dart';

class AdminVideoMateriDetailPage extends StatefulWidget {
  static const routeName = '/admin-video-materi-detail';
  final VideoMateri videoMateri;
  const AdminVideoMateriDetailPage({Key? key, required this.videoMateri})
      : super(key: key);

  @override
  _AdminVideoMateriDetailPageState createState() =>
      _AdminVideoMateriDetailPageState();
}

class _AdminVideoMateriDetailPageState
    extends State<AdminVideoMateriDetailPage> {
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    videoPlayerInit(widget.videoMateri.videoUrl);
  }

  void videoPlayerInit(String url) {
    _videoController = VideoPlayerController.network(url)
      ..addListener(() => setState(() {}))
      ..setLooping(false)
      ..initialize();
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kRichWhite,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: kRichBlack,
          ),
        ),
        title: SvgPicture.asset(
          'assets/svg/Publico.svg',
          height: 24,
          width: 50,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: kRichWhite,
                context: context,
                isDismissible: true,
                builder: (_) => PublicoMateriEditBottomSheet(
                  parentContext: context,
                  bookmarkCount: widget.videoMateri.bookmarkCount,
                  onDeletePressed: () {
                    context.read<VideoMateriCubit>().deleteVideoMateriFirestore(
                          widget.videoMateri.id,
                          widget.videoMateri.videoUrl,
                          widget.videoMateri.thumbnailUrl,
                          'video_materi',
                        );
                  },
                  onEditPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      VideoMateriEditPage.routeName,
                      arguments: widget.videoMateri,
                    );
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.more_horiz,
              color: kRichBlack,
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kLightGrey2,
                ),
                child: _videoController != null &&
                        _videoController!.value.isInitialized
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            _videoController!.value.isPlaying
                                ? _videoController!.pause()
                                : _videoController!.play();
                          },
                          child: Stack(
                            fit: StackFit.loose,
                            alignment: Alignment.center,
                            children: [
                              AspectRatio(
                                aspectRatio:
                                    _videoController!.value.aspectRatio,
                                child: VideoPlayer(
                                  _videoController!,
                                ),
                              ),
                              Positioned.fill(
                                child: Center(
                                  child: _videoController!.value.isPlaying
                                      ? Container()
                                      : Container(
                                          alignment: Alignment.center,
                                          color: Colors.black26,
                                          child: const Icon(
                                            Icons.play_arrow,
                                            color: kRichWhite,
                                            size: 80,
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: kMikadoOrange,
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: Text(
                  widget.videoMateri.title,
                  maxLines: 1,
                  style: kTextTheme.caption!.copyWith(color: kRichBlack),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                child: Text(
                  widget.videoMateri.description,
                  overflow: TextOverflow.fade,
                  style: kTextTheme.caption!.copyWith(
                    color: kGrey,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
