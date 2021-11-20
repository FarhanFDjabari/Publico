import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:publico/presentation/bloc/infographic/infographic_cubit.dart';
import 'package:publico/presentation/widgets/loading_button.dart';
import 'package:publico/presentation/widgets/primary_button.dart';
import 'package:publico/presentation/widgets/publico_snackbar.dart';
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
  void dispose() {
    imageFile = null;
    FilePicker.platform.clearTemporaryFiles();
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
                await Future.delayed(const Duration(milliseconds: 500));
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
            BlocConsumer<InfographicCubit, InfographicState>(
              listener: (listenerContext, state) {
                if (state is InfographicError) {
                  ScaffoldMessenger.of(context).showMaterialBanner(
                    MaterialBanner(
                      content:
                          Text('Gagal menambahkan tema baru: ${state.message}'),
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
                } else if (state is PostInfographicThemeSuccess) {
                  Navigator.pop(context);
                  Get.showSnackbar(
                    PublicoSnackbar(
                      message: state.message,
                    ),
                  );
                }
              },
              builder: (builderContext, state) {
                if (state is InfographicLoading) {
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
                              .read<InfographicCubit>()
                              .postNewInfographicTheme(
                                  _themeNameController.text,
                                  'infographic_themes',
                                  imageFile!);
                        },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
