import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/components/pick_place_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/photos/select_photos/select_photos_widget.dart';
import 'dart:ui';
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'post_widget.dart' show PostWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PostModel extends FlutterFlowModel<PostWidget> {
  ///  State fields for stateful widgets in this page.

  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // State field(s) for TextField_description widget.
  FocusNode? textFieldDescriptionFocusNode;
  TextEditingController? textFieldDescriptionTextController;
  String? Function(BuildContext, String?)?
      textFieldDescriptionTextControllerValidator;
  // Stores action output result for [Bottom Sheet - PickPlace] action in Row widget.
  LatLng? latLngOutPut;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldDescriptionFocusNode?.dispose();
    textFieldDescriptionTextController?.dispose();
  }
}
