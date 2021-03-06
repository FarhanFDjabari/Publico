import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:publico/presentation/bloc/video_singkat/video_singkat_cubit.dart';
import 'package:publico/presentation/widgets/loading_button.dart';
import 'package:publico/presentation/widgets/primary_button.dart';
import 'package:publico/presentation/widgets/publico_snackbar.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoSingkatPostPage extends StatefulWidget {
  static const routeName = '/admin-video-singkat-post';
  const VideoSingkatPostPage({Key? key}) : super(key: key);

  @override
  _VideoSingkatPostPageState createState() => _VideoSingkatPostPageState();
}

class _VideoSingkatPostPageState extends State<VideoSingkatPostPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _tautanController = TextEditingController();
  VideoPlayerController? _videoController;
  File? videoFile;
  File? thumbnailImage;
  int? duration;
  bool isValidate = false;
  bool isLoadLocal = false;

  void formCheck() {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _tautanController.text.isNotEmpty &&
        videoFile != null) {
      if (isValidate) {
        return;
      } else {
        setState(() {
          isValidate = true;
        });
      }
    } else {
      setState(() {
        isValidate = false;
      });
    }
  }

  Future<void> videoPlayerInit(File? videoFile) async {
    if (videoFile != null) {
      _videoController = VideoPlayerController.file(videoFile)
        ..addListener(() {
          if (mounted) {
            setState(() {});
          }
        })
        ..setLooping(false)
        ..initialize().then(
          (value) => duration = _videoController?.value.duration.inSeconds,
        );
      String? thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: videoFile.path,
        timeMs: 2000,
        imageFormat: ImageFormat.JPEG,
        quality: 10,
      );
      thumbnailImage = File(thumbnailPath!);
    }
  }

  Future<bool> videoProcessing(XFile value) async {
    if (await value.length() < 4000000) {
      videoFile = File(value.path);
      await videoPlayerInit(videoFile!);
      return true;
    }
    return false;
  }

  @override
  void dispose() async {
    Future.delayed(Duration.zero, () async {
      await _videoController?.dispose();
    });
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
            size: 20,
          ),
        ),
        title: Text(
          'Tambah Video Singkat',
          style: kTextTheme.subtitle1!.copyWith(
            fontSize: 16,
            color: kRichBlack,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  label: const Text('Judul'),
                  hintText: 'Masukkan judul',
                  hintStyle: kTextTheme.bodyText2!.copyWith(
                    color: kLightGrey,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  Timer(const Duration(milliseconds: 750), () {
                    formCheck();
                  });
                },
                style: kTextTheme.bodyText2!.copyWith(
                  color: kRichBlack,
                ),
                autofocus: false,
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  label: const Text('Deskripsi'),
                  hintText: 'Masukkan deskripsi',
                  hintStyle: kTextTheme.bodyText2!.copyWith(
                    color: kLightGrey,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  Timer(const Duration(milliseconds: 750), () {
                    formCheck();
                  });
                },
                style: kTextTheme.bodyText2!.copyWith(
                  color: kRichBlack,
                ),
                autofocus: false,
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _tautanController,
                decoration: InputDecoration(
                  label: const Text('Tautan Tiktok'),
                  hintText: 'Masukkan tautan',
                  hintStyle: kTextTheme.bodyText2!.copyWith(
                    color: kLightGrey,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  Timer(const Duration(milliseconds: 750), () {
                    formCheck();
                  });
                },
                style: kTextTheme.bodyText2!.copyWith(
                  color: kRichBlack,
                ),
                autofocus: false,
              ),
              const SizedBox(height: 15),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: kMikadoOrange,
                  ),
                ),
                child: videoFile != null && _videoController != null
                    ? _videoController!.value.isInitialized
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
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: IconButton(
                                      onPressed: () async {
                                        setState(() {
                                          _videoController = null;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.cancel_rounded,
                                        color: kGrey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.45,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: kMikadoOrange,
                              ),
                            ),
                          )
                    : InkWell(
                        onTap: isLoadLocal
                            ? null
                            : () async {
                                setState(() {
                                  isLoadLocal = true;
                                });
                                await Future.delayed(
                                    const Duration(milliseconds: 500));
                                await ImagePicker()
                                    .pickVideo(
                                  source: ImageSource.gallery,
                                  maxDuration: const Duration(minutes: 5),
                                )
                                    .then(
                                  (value) async {
                                    setState(() {
                                      isLoadLocal = false;
                                    });
                                    if (value != null) {
                                      if (await videoProcessing(value)) {
                                        formCheck();
                                      } else {
                                        videoFile = null;
                                        Get.showSnackbar(PublicoSnackbar(
                                          message:
                                              'Ukuran file tidak boleh lebih dari 3 MB',
                                        ));
                                      }
                                    }
                                  },
                                );
                              },
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.45,
                          child: isLoadLocal
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: kMikadoOrange,
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.camera_alt_outlined,
                                      color: kLightGrey,
                                      size: 35,
                                    ),
                                    Text(
                                      'Unggah Video\nMaks 1 Menit',
                                      textAlign: TextAlign.center,
                                      style: kTextTheme.bodyText2!.copyWith(
                                        color: kLightGrey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
              ),
              const SizedBox(height: 15),
              BlocConsumer<VideoSingkatCubit, VideoSingkatState>(
                listener: (context, state) {
                  if (state is VideoSingkatError) {
                    ScaffoldMessenger.of(context).showMaterialBanner(
                      MaterialBanner(
                        content:
                            Text('Upload video materi error: ${state.message}'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentMaterialBanner();
                            },
                            child: const Text('Oke'),
                          ),
                        ],
                        padding: const EdgeInsets.only(top: 20),
                        leadingPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        leading: const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                        backgroundColor: kRichBlack.withOpacity(0.75),
                      ),
                    );
                  } else if (state is PostVideoSingkatSuccess) {
                    Navigator.pop(context);
                    Get.showSnackbar(
                      PublicoSnackbar(
                        message: state.message,
                      ),
                    );
                  }
                },
                builder: (builderContext, state) {
                  if (state is PostVideoSingkatLoading) {
                    return LoadingButton(
                      borderRadius: 10,
                      primaryColor: kLightGrey,
                      child: const SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: kRichWhite,
                              strokeWidth: 3,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return PrimaryButton(
                    borderRadius: 10,
                    child: SizedBox(
                      height: 45,
                      child: Center(
                        child: Text(
                          'Simpan',
                          style: kTextTheme.button!.copyWith(
                            color: kRichWhite,
                          ),
                        ),
                      ),
                    ),
                    onPressed: !isValidate
                        ? null
                        : () {
                            builderContext
                                .read<VideoSingkatCubit>()
                                .postVideoSingkatFirestore(
                                  _titleController.text,
                                  _descriptionController.text,
                                  _tautanController.text,
                                  'video_singkat',
                                  'video_singkat_thumbnail',
                                  videoFile!,
                                  thumbnailImage!,
                                  duration!,
                                );
                          },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
