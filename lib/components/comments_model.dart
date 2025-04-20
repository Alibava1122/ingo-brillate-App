import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/comments_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'comments_widget.dart' show CommentsWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CommentsModel extends FlutterFlowModel<CommentsWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField_Comment widget.
  FocusNode? textFieldCommentFocusNode;
  TextEditingController? textFieldCommentTextController;
  String? Function(BuildContext, String?)?
      textFieldCommentTextControllerValidator;
  // State field(s) for TextField_Answer widget.
  FocusNode? textFieldAnswerFocusNode;
  TextEditingController? textFieldAnswerTextController;
  String? Function(BuildContext, String?)?
      textFieldAnswerTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldCommentFocusNode?.dispose();
    textFieldCommentTextController?.dispose();

    textFieldAnswerFocusNode?.dispose();
    textFieldAnswerTextController?.dispose();
  }
}
