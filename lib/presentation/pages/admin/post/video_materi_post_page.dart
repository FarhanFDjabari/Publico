import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:publico/presentation/bloc/video_materi/video_materi_cubit.dart';
import 'package:publico/presentation/widgets/loading_button.dart';
import 'package:publico/presentation/widgets/primary_button.dart';
import 'package:publico/presentation/widgets/publico_snackbar.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoMateriPostPage extends StatefulWidget {
  static const routeName = '/admin-video-materi-post';
  const VideoMateriPostPage({Key? key}) : super(key: key);

  @override
  _VideoMateriPostPageState createState() => _VideoMateriPostPageState();
}

class _VideoMateriPostPageState extends State<VideoMateriPostPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  VideoPlayerController? _videoController;
  File? videoFile;
  File? thumbnailImage;
  int? duration;
  bool isValidate = false;
  bool isLoadLocal = false;

  void formCheck() {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
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

  Future<void> videoPlayerInit(File videoFile) async {
    _videoController = VideoPlayerController.file(videoFile)
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      })
      ..setLooping(false)
      ..initialize().then((value) {
        duration = _videoController?.value.duration.inSeconds;
      });
    String? thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: videoFile.path,
      timeMs: 1500,
      imageFormat: ImageFormat.JPEG,
      quality: 10,
    );
    thumbnailImage = File(thumbnailPath!);
  }

  Future<bool> videoProcessing(FilePickerResult value) async {
    if (value.files.first.size < 21000000) {
      videoFile = File(value.files.first.path!);
      await videoPlayerInit(videoFile!);
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    Future.delayed(Duration.zero, () async {
      await FilePicker.platform.clearTemporaryFiles();
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
          'Tambah Video Materi',
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
                              onLongPress: () async {
                                await FilePicker.platform.clearTemporaryFiles();
                                setState(() {
                                  _videoController = null;
                                });
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
                                ],
                              ),
                            ),
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
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
                                await Future.delayed(
                                    const Duration(milliseconds: 500));
                                await FilePicker.platform
                                    .pickFiles(
                                  type: FileType.video,
                                  withData: false,
                                  allowMultiple: false,
                                  allowCompression: true,
                                  onFileLoading: (status) {
                                    setState(() {
                                      isLoadLocal = true;
                                    });
                                  },
                                )
                                    .then(
                                  (value) async {
                                    setState(() {
                                      isLoadLocal = false;
                                    });
                                    if (value != null) {
                                      if (await videoProcessing(value)) {
                                        formCheck();
                                        value.files.clear();
                                      } else {
                                        videoFile = null;
                                        Get.showSnackbar(PublicoSnackbar(
                                          message:
                                              'Ukuran file tidak boleh lebih dari 20 MB',
                                        ));
                                        await FilePicker.platform
                                            .clearTemporaryFiles();
                                        value.files.clear();
                                      }
                                    }
                                  },
                                );
                              },
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
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
                                      'Unggah Video\nMaks 7 Menit',
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
              BlocConsumer<VideoMateriCubit, VideoMateriState>(
                listener: (listenerContext, state) {
                  if (state is VideoMateriError) {
                    Get.showSnackbar(
                      PublicoSnackbar(
                        message: state.message,
                      ),
                    );
                  } else if (state is PostVideoMateriSuccess) {
                    Navigator.pop(context);
                    Get.showSnackbar(
                      PublicoSnackbar(
                        message: state.message,
                      ),
                    );
                  }
                },
                builder: (builderContext, state) {
                  if (state is PostVideoMateriLoading) {
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
                                .read<VideoMateriCubit>()
                                .postVideoMateriFirestore(
                                  _titleController.text,
                                  _descriptionController.text,
                                  'video_materi',
                                  'video_materi_thumbnail',
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
