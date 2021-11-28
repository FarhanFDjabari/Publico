import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:publico/presentation/widgets/primary_button.dart';
import 'package:publico/presentation/widgets/publico_snackbar.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class EditSourcesPage extends StatefulWidget {
  static const routeName = '/admin-edit-sources';
  final Map<String, dynamic> source;
  const EditSourcesPage({Key? key, required this.source}) : super(key: key);

  @override
  _EditSourcesPageState createState() => _EditSourcesPageState();
}

class _EditSourcesPageState extends State<EditSourcesPage> {
  final _sumberController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _imageUrlController = TextEditingController();
  List illustrations = [];
  bool isValidate = false;
  bool showImageField = false;

  @override
  void initState() {
    super.initState();
    _sumberController.text = widget.source['source_name'];
    _deskripsiController.text = widget.source['description'];
    illustrations = widget.source['illustrations'];
    formCheck();
  }

  void formCheck() {
    if (_sumberController.text.isNotEmpty &&
        _deskripsiController.text.isNotEmpty &&
        illustrations.isNotEmpty) {
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

  Future<File?> compressFile(File file) async {
    final filePath = file.absolute.path;

    final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath,
      quality: 50,
    );

    if (result != null) {
      return result;
    }

    return null;
  }

  Future<bool> imageProcessing(FilePickerResult? file) async {
    if (file != null) {
      if (file.files.first.size < 2500000) {
        File? _imageFile = await compressFile(File(file.files.first.path!));
        illustrations.add(_imageFile);
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _sumberController.dispose();
    _deskripsiController.dispose();
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
          'Edit Sumber',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '   Sumber',
                style: kTextTheme.caption!.copyWith(
                  color: kMikadoOrange,
                ),
              ),
              TextField(
                controller: _sumberController,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Masukkan sumber',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: kMikadoOrange,
                    ),
                  ),
                ),
                onChanged: (value) {
                  Timer(const Duration(milliseconds: 500), () {
                    formCheck();
                  });
                },
                style: kTextTheme.bodyText2!.copyWith(
                  color: kRichBlack,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                '   Deskripsi',
                style: kTextTheme.caption!.copyWith(
                  color: kMikadoOrange,
                ),
              ),
              TextField(
                controller: _deskripsiController,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Masukkan deskripsi',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: kMikadoOrange,
                    ),
                  ),
                ),
                onChanged: (value) {
                  Timer(const Duration(milliseconds: 500), () {
                    formCheck();
                  });
                },
                style: kTextTheme.bodyText2!.copyWith(
                  color: kRichBlack,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                '   Ilustrasi',
                style: kTextTheme.caption!.copyWith(
                  color: kMikadoOrange,
                ),
              ),
              Column(
                children: illustrations
                    .map((illustration) => Container(
                          margin: const EdgeInsets.only(bottom: 5, top: 5),
                          padding: const EdgeInsets.all(0),
                          child: Stack(
                            fit: StackFit.loose,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: illustration,
                                  progressIndicatorBuilder: (_, __, progress) {
                                    return SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor: kMikadoOrange,
                                          value: progress.progress,
                                          strokeWidth: 3,
                                        ),
                                      ),
                                    );
                                  },
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      illustrations.remove(illustration);
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
                        ))
                    .toList(),
              ),
              const SizedBox(height: 15),
              showImageField
                  ? TextField(
                      controller: _imageUrlController,
                      autofocus: false,
                      decoration: InputDecoration(
                        hintText: 'Masukkan URL ',
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: kMikadoOrange,
                          ),
                        ),
                      ),
                      onSubmitted: (value) async {
                        try {
                          final response = await http.get(Uri.parse(value));
                          if (response.statusCode == 200) {
                            setState(() {
                              illustrations.add(value);
                              _imageUrlController.clear();
                            });
                          }
                        } catch (e) {
                          Get.showSnackbar(PublicoSnackbar(
                            message: "Url ilustrasi tidak ditemukan",
                          ));
                        }
                      },
                      style: kTextTheme.bodyText2!.copyWith(
                        color: kRichBlack,
                      ),
                    )
                  : Container(),
              const SizedBox(height: 15),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    showImageField = true;
                  });
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: const BorderSide(
                    color: kMikadoOrange,
                  ),
                ),
                child: SizedBox(
                  height: 45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add, color: kMikadoOrange, size: 16),
                      Text(
                        ' Tambah Ilustrasi',
                        style: kTextTheme.button!,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              PrimaryButton(
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
                        final Map<String, dynamic> sourceData = {
                          'source': _sumberController.text,
                          'description': _deskripsiController.text,
                          'illustration': illustrations,
                        };
                        Navigator.pop(context, sourceData);
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
