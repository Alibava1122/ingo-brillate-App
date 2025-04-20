import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/chat/button_sheet_chat_photo/button_sheet_chat_photo_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/instant_timer.dart';
import 'dart:ui';
import '/index.dart';
import 'chat_widget.dart' show ChatWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ChatModel extends FlutterFlowModel<ChatWidget> {
  ///  State fields for stateful widgets in this page.

  InstantTimer? instantTimer;
  // State field(s) for Column_Chat widget.
  ScrollController? columnChat;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {
    columnChat = ScrollController();
  }

  @override
  void dispose() {
    instantTimer?.cancel();
    columnChat?.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
