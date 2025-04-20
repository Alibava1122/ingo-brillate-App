import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/photos/edit_photo/edit_photo_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'edit_profile_widget.dart' show EditProfileWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditProfileModel extends FlutterFlowModel<EditProfileWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField_Name widget.
  FocusNode? textFieldNameFocusNode1;
  TextEditingController? textFieldNameTextController1;
  String? Function(BuildContext, String?)?
      textFieldNameTextController1Validator;
  // State field(s) for TextField_description widget.
  FocusNode? textFieldDescriptionFocusNode;
  TextEditingController? textFieldDescriptionTextController;
  String? Function(BuildContext, String?)?
      textFieldDescriptionTextControllerValidator;
  // State field(s) for TextField_Name widget.
  FocusNode? textFieldNameFocusNode2;
  TextEditingController? textFieldNameTextController2;
  String? Function(BuildContext, String?)?
      textFieldNameTextController2Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldNameFocusNode1?.dispose();
    textFieldNameTextController1?.dispose();

    textFieldDescriptionFocusNode?.dispose();
    textFieldDescriptionTextController?.dispose();

    textFieldNameFocusNode2?.dispose();
    textFieldNameTextController2?.dispose();
  }
}
