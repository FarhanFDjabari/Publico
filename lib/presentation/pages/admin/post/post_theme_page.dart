import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:publico/presentation/widgets/primary_button.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class PostThemePage extends StatefulWidget {
  static const routeName = '/admin-post-theme';
  const PostThemePage({Key? key}) : super(key: key);

  @override
  _PostThemePageState createState() => _PostThemePageState();
}

class _PostThemePageState extends State<PostThemePage> {
  final _themeNameController = TextEditingController();
  bool isValidate = false;
  File? imageFile;

  void formCheck() {
    if (_themeNameController.text.isNotEmpty && imageFile != null) {
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
          'Tambah Tema',
          style: kTextTheme.subtitle1!.copyWith(
            fontSize: 16,
            color: kRichBlack,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _themeNameController,
              decoration: InputDecoration(
                label: const Text('Nama Tema'),
                hintText: 'Masukkan nama tema',
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
            InkWell(
              onTap: () async {
                final result = await FilePicker.platform.pickFiles(
                  type: FileType.image,
                );
                if (result == null) return;
                imageFile = File(result.files.first.path!);
                formCheck();
              },
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: kMikadoOrange,
                  ),
                ),
                child: imageFile != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          imageFile!,
                          fit: BoxFit.cover,
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
                            'Unggah Gambar',
                            style: kTextTheme.bodyText2!.copyWith(
                              color: kLightGrey,
                              fontSize: 14,
                            ),
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
              onPressed: !isValidate ? null : () {},
            ),
          ],
        ),
      ),
    );
  }
}
