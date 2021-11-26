import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:publico/domain/entities/infographic.dart';
import 'package:publico/presentation/bloc/infographic/infographic_cubit.dart';
import 'package:publico/presentation/pages/admin/edit/edit_sources_page.dart';
import 'package:publico/presentation/pages/admin/post/add_source_page.dart';
import 'package:publico/presentation/widgets/loading_button.dart';
import 'package:publico/presentation/widgets/primary_button.dart';
import 'package:publico/presentation/widgets/publico_snackbar.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class InfographicEditPage extends StatefulWidget {
  static const routeName = '/admin-infographic-edit';
  final Infographic infographic;
  const InfographicEditPage({Key? key, required this.infographic})
      : super(key: key);

  @override
  _InfographicEditPageState createState() => _InfographicEditPageState();
}

class _InfographicEditPageState extends State<InfographicEditPage> {
  final _titleController = TextEditingController();
  List sources = [];
  String? selectedTheme;
  bool isValidate = false;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.infographic.title;
    sources = widget.infographic.sources;
    selectedTheme = widget.infographic.themeName;
  }

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
                items: [
                  DropdownMenuItem(
                    child: Text(
                      widget.infographic.themeName,
                      style: kTextTheme.bodyText2!.copyWith(
                        color: kMikadoOrange,
                      ),
                    ),
                    value: widget.infographic.themeId,
                    onTap: null,
                    enabled: false,
                  ),
                ],
                onTap: null,
                isDense: true,
                dropdownColor: kLightGrey2,
                enableFeedback: false,
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
                onChanged: (value) {
                  Timer(const Duration(milliseconds: 500), () {
                    formCheck();
                  });
                },
                hint: Text(
                  widget.infographic.themeName,
                  style: kTextTheme.bodyText2!.copyWith(
                    color: kMikadoOrange,
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
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              EditSourcesPage.routeName,
                              arguments: source,
                            ).then((value) {
                              if (value != null) {
                                final valueMap = value as Map<String, dynamic>;
                                setState(() {
                                  source['source_name'] = valueMap['source'];
                                  source['description'] =
                                      valueMap['description'];
                                  source['illustrations'] =
                                      valueMap['illustration'];
                                });
                                formCheck();
                              }
                            });
                          },
                          controller: TextEditingController(
                            text: source['source_name'],
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
                            suffixIcon: const Icon(
                              Icons.arrow_forward_ios,
                              color: kMikadoOrange,
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
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AddSourcePage.routeName,
                  ).then((value) {
                    if (value != null) {
                      setState(() => sources.add(value));
                      formCheck();
                    }
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
                        ' Tambah Sumber',
                        style: kTextTheme.button!,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              BlocConsumer<InfographicCubit, InfographicState>(
                listener: (listenerContext, state) {
                  if (state is InfographicError) {
                    Get.showSnackbar(
                      PublicoSnackbar(
                        message: state.message,
                      ),
                    );
                  } else if (state is EditInfographicPostSuccess) {
                    Navigator.pop(context);
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
                                .editInfographicFirestore(
                                  widget.infographic.id,
                                  widget.infographic.themeId,
                                  widget.infographic.themeName,
                                  _titleController.text,
                                  widget.infographic.sources,
                                  sources,
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
