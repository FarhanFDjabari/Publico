import 'package:flutter/material.dart';

class EditSourcesPage extends StatefulWidget {
  static const routeName = '/admin-edit-sources';
  final String sourceId;
  const EditSourcesPage({Key? key, required this.sourceId}) : super(key: key);

  @override
  _EditSourcesPageState createState() => _EditSourcesPageState();
}

class _EditSourcesPageState extends State<EditSourcesPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
