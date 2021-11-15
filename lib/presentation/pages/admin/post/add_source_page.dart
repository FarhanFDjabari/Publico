import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:publico/presentation/widgets/primary_button.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class AddSourcePage extends StatefulWidget {
  static const routeName = '/admin-add-source-page';
  const AddSourcePage({Key? key}) : super(key: key);

  @override
  _AddSourcePageState createState() => _AddSourcePageState();
}

class _AddSourcePageState extends State<AddSourcePage> {
  final _sumberController = TextEditingController();
  final _deskripsiController = TextEditingController();
  List illustrations = [];
  bool isValidate = false;

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
          'Tambah Sumber',
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
                  Timer(const Duration(milliseconds: 750), () {
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
                  Timer(const Duration(milliseconds: 750), () {
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
                          margin: const EdgeInsets.only(bottom: 5),
                          height: 180,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  illustration,
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
              OutlinedButton(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.image,
                  );
                  if (result == null) return;
                  File _imageFile = File(result.files.first.path!);
                  setState(() {
                    illustrations.add(_imageFile);
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
                onPressed: !isValidate ? null : () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
