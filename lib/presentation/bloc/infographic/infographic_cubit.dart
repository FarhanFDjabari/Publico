import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:publico/domain/usecases/admin/post_infographic_theme.dart';

part 'infographic_state.dart';

class InfographicCubit extends Cubit<InfographicState> {
  InfographicCubit({required this.postInfographicTheme})
      : super(InfographicInitial());

  final PostInfographicTheme postInfographicTheme;

  void postNewInfographicTheme(
      String themeName, String destination, File themeImage) async {
    emit(InfographicLoading());
    final result = await postInfographicTheme.execute(
      themeName,
      themeImage,
      destination,
    );
    result.fold(
      (l) => emit(InfographicError(l.message)),
      (r) =>
          emit(const PostInfographicThemeSuccess('Tema berhasil ditambahkan')),
    );
  }
}
