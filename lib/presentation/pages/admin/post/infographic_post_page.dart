import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:publico/domain/entities/theme.dart' as theme_entity;
import 'package:publico/presentation/bloc/infographic/infographic_cubit.dart';
import 'package:publico/presentation/pages/admin/post/add_source_page.dart';
import 'package:publico/presentation/widgets/loading_button.dart';
import 'package:publico/presentation/widgets/primary_button.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class InfographicPostPage extends StatefulWidget {
  static const routeName = '/admin-infographics-post';
  final List<theme_entity.Theme> themes;
  const InfographicPostPage({Key? key, required this.themes}) : super(key: key);

  @override
  _InfographicPostPageState createState() => _InfographicPostPageState();
}

class _InfographicPostPageState extends State<InfographicPostPage> {
  final _titleController = TextEditingController();
  List sources = [];
  String? selectedTheme;
  bool isValidate = false;

  void formCheck() {
    if (_titleController.text.isNotEmpty &&
        sources.isNotEmpty &&
        selectedTheme != null) {
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
          'Tambah Infografis',
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
                '   Tema',
                style: kTextTheme.caption!.copyWith(
                  color: kMikadoOrange,
                ),
              ),
              DropdownButtonFormField(
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                items: widget.themes
                    .map(
                      (theme) => DropdownMenuItem(
                        child: Text(
                          theme.themeName,
                          style: kTextTheme.bodyText2!.copyWith(
                            color: kMikadoOrange,
                          ),
                        ),
                        value: theme.id,
                        onTap: () {
                          selectedTheme = theme.id;
                          formCheck();
                        },
                      ),
                    )
                    .toList(),
                isDense: true,
                dropdownColor: kLightGrey2,
                elevation: 0,
                iconEnabledColor: kMikadoOrange,
                autofocus: false,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: kMikadoOrange,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                ),
                onChanged: (value) {},
                hint: Text(
                  'Pilih Tema',
                  style: kTextTheme.bodyText2!.copyWith(
                    color: kGrey,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                '   Judul',
                style: kTextTheme.caption!.copyWith(
                  color: kMikadoOrange,
                ),
              ),
              TextField(
                controller: _titleController,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Masukkan judul',
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
                '   Sumber',
                style: kTextTheme.caption!.copyWith(
                  color: kMikadoOrange,
                ),
              ),
              Column(
                children: sources
                    .map(
                      (source) => Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: TextField(
                          readOnly: true,
                          onTap: () {},
                          controller: TextEditingController(
                            text: source['source'],
                          ),
                          decoration: InputDecoration(
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
                          style: kTextTheme.bodyText2!.copyWith(
                            color: kRichBlack,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              OutlinedButton(
                onPressed: () async {
                  final Map<String, dynamic> result = await Navigator.pushNamed(
                    context,
                    AddSourcePage.routeName,
                  ) as Map<String, dynamic>;
                  setState(() => sources.add(result));
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
                        ' Tambah Sumber',
                        style: kTextTheme.button!,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              BlocConsumer<InfographicCubit, InfographicState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (builderContext, state) {
                  if (state is PostInfographicLoading) {
                    return PrimaryButton(
                        borderRadius: 10,
                        child: const SizedBox(
                            height: 45,
                            child: Center(child: CircularProgressIndicator())),
                        onPressed: null);
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
                                .postInfographicFirestore(
                                    selectedTheme as String,
                                    _titleController.text,
                                    sources,
                                    'infographics');
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
