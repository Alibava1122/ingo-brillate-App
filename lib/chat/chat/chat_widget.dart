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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'chat_model.dart';
export 'chat_model.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({
    super.key,
    required this.chatID,
  });

  final String? chatID;

  static String routeName = 'chat';
  static String routePath = '/chat';

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  late ChatModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.instantTimer = InstantTimer.periodic(
        duration: Duration(milliseconds: 1000),
        callback: (timer) async {
          await _model.columnChat?.animateTo(
            _model.columnChat!.position.maxScrollExtent,
            duration: Duration(milliseconds: 100),
            curve: Curves.ease,
          );
          _model.instantTimer?.cancel();
        },
        startImmediately: false,
      );
    });

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChatRecord>>(
      stream: queryChatRecord(
        queryBuilder: (chatRecord) => chatRecord.where(
          'chatID',
          isEqualTo: widget!.chatID,
        ),
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<ChatRecord> chatChatRecordList = snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final chatChatRecord =
            chatChatRecordList.isNotEmpty ? chatChatRecordList.first : null;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              body: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 20.0, 12.0, 0.0),
                    child: StreamBuilder<List<UsersRecord>>(
                      stream: queryUsersRecord(
                        queryBuilder: (usersRecord) => usersRecord.where(
                          'uid',
                          isEqualTo: chatChatRecord?.userA == currentUserUid
                              ? chatChatRecord?.userB
                              : chatChatRecord?.userA,
                        ),
                        singleRecord: true,
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                          );
                        }
                        List<UsersRecord> rowUsersRecordList = snapshot.data!;
                        // Return an empty Container when the item does not exist.
                        if (snapshot.data!.isEmpty) {
                          return Container();
                        }
                        final rowUsersRecord = rowUsersRecordList.isNotEmpty
                            ? rowUsersRecordList.first
                            : null;

                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 6.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.safePop();
                                      },
                                      child: FaIcon(
                                        FontAwesomeIcons
                                            .solidArrowAltCircleLeft,
                                        color: Color(0xFF8B660F),
                                        size: 24.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 0.0, 0.0, 0.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed(
                                            UsersPageWidget.routeName,
                                            queryParameters: {
                                              'user': serializeParam(
                                                rowUsersRecord?.uid,
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey:
                                                  TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType.fade,
                                                duration:
                                                    Duration(milliseconds: 0),
                                              ),
                                            },
                                          );
                                        },
                                        child: Container(
                                          width: 60.0,
                                          height: 60.0,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.network(
                                            rowUsersRecord!.photoUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        rowUsersRecord!.username,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color: Colors.black,
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_back,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Divider(
                    thickness: 2.0,
                    color: FlutterFlowTheme.of(context).alternate,
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      child: SingleChildScrollView(
                        controller: _model.columnChat,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            StreamBuilder<List<MessagesRecord>>(
                              stream: queryMessagesRecord(
                                queryBuilder: (messagesRecord) => messagesRecord
                                    .where(
                                      'chat_ID',
                                      isEqualTo: widget!.chatID,
                                    )
                                    .orderBy('current_time'),
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 40.0,
                                      height: 40.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                List<MessagesRecord> columnMessagesRecordList =
                                    snapshot.data!;

                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: List.generate(
                                      columnMessagesRecordList.length,
                                      (columnIndex) {
                                    final columnMessagesRecord =
                                        columnMessagesRecordList[columnIndex];
                                    return Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        if ((columnMessagesRecord.userID !=
                                                currentUserUid) &&
                                            (columnMessagesRecord.type ==
                                                'Text'))
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 4.0, 0.0, 4.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 0.0,
                                                                10.0, 0.0),
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          1.0,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    80.0,
                                                                    0.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Flexible(
                                                              child: Material(
                                                                color: Colors
                                                                    .transparent,
                                                                elevation: 1.0,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            0.0),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            18.0),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            18.0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            18.0),
                                                                  ),
                                                                ),
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              0.0),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              18.0),
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              18.0),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              18.0),
                                                                    ),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Color(
                                                                          0xFF8B660F),
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          Flexible(
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(10.0, 6.0, 10.0, 0.0),
                                                                              child: Text(
                                                                                columnMessagesRecord.text,
                                                                                textAlign: TextAlign.start,
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Inter',
                                                                                      letterSpacing: 0.0,
                                                                                      lineHeight: 1.0,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                10.0,
                                                                                10.0,
                                                                                10.0,
                                                                                6.0),
                                                                            child:
                                                                                Text(
                                                                              dateTimeFormat(
                                                                                "d/M H:mm",
                                                                                columnMessagesRecord.currentTime!,
                                                                                locale: FFLocalizations.of(context).languageCode,
                                                                              ),
                                                                              textAlign: TextAlign.end,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Inter',
                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                    fontSize: 8.0,
                                                                                    letterSpacing: 0.0,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        if ((columnMessagesRecord.userID ==
                                                currentUserUid) &&
                                            (columnMessagesRecord.type ==
                                                'Text'))
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 4.0, 0.0, 4.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 0.0,
                                                                10.0, 0.0),
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          1.0,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    80.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Flexible(
                                                              child: Material(
                                                                color: Colors
                                                                    .transparent,
                                                                elevation: 1.0,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            18.0),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            0.0),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            18.0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            18.0),
                                                                  ),
                                                                ),
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xFF78D18A),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              18.0),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              0.0),
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              18.0),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              18.0),
                                                                    ),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Color(
                                                                          0xFF8B660F),
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          Flexible(
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(10.0, 6.0, 10.0, 0.0),
                                                                              child: Text(
                                                                                columnMessagesRecord.text,
                                                                                textAlign: TextAlign.start,
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Inter',
                                                                                      letterSpacing: 0.0,
                                                                                      lineHeight: 1.0,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                10.0,
                                                                                10.0,
                                                                                10.0,
                                                                                6.0),
                                                                            child:
                                                                                Text(
                                                                              dateTimeFormat(
                                                                                "d/M H:mm",
                                                                                columnMessagesRecord.currentTime!,
                                                                                locale: FFLocalizations.of(context).languageCode,
                                                                              ),
                                                                              textAlign: TextAlign.end,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Inter',
                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                    fontSize: 8.0,
                                                                                    letterSpacing: 0.0,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        if ((columnMessagesRecord.userID !=
                                                currentUserUid) &&
                                            (columnMessagesRecord.type ==
                                                'Image') &&
                                            ((columnMessagesRecord.images
                                                            .elementAtOrNull(
                                                                0) !=
                                                        null &&
                                                    columnMessagesRecord.images
                                                            .elementAtOrNull(
                                                                0) !=
                                                        '') &&
                                                (columnMessagesRecord.images
                                                            .elementAtOrNull(
                                                                1) ==
                                                        null ||
                                                    columnMessagesRecord.images
                                                            .elementAtOrNull(
                                                                1) ==
                                                        '')))
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 0.0,
                                                                10.0, 8.0),
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          1.0,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  18.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  18.0),
                                                          topLeft:
                                                              Radius.circular(
                                                                  0.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  18.0),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    10.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Flexible(
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            10.0,
                                                                            8.0),
                                                                child:
                                                                    Container(
                                                                  width: 170.0,
                                                                  height: 190.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Flexible(
                                                                        child:
                                                                            Material(
                                                                          color:
                                                                              Colors.transparent,
                                                                          elevation:
                                                                              1.0,
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              bottomLeft: Radius.circular(0.0),
                                                                              bottomRight: Radius.circular(18.0),
                                                                              topLeft: Radius.circular(18.0),
                                                                              topRight: Radius.circular(18.0),
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                180.0,
                                                                            height:
                                                                                198.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              borderRadius: BorderRadius.only(
                                                                                bottomLeft: Radius.circular(0.0),
                                                                                bottomRight: Radius.circular(18.0),
                                                                                topLeft: Radius.circular(18.0),
                                                                                topRight: Radius.circular(18.0),
                                                                              ),
                                                                              border: Border.all(
                                                                                color: Color(0xFF8B660F),
                                                                                width: 1.0,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    await Navigator.push(
                                                                                      context,
                                                                                      PageTransition(
                                                                                        type: PageTransitionType.fade,
                                                                                        child: FlutterFlowExpandedImageView(
                                                                                          image: Image.network(
                                                                                            columnMessagesRecord.images.elementAtOrNull(0)!,
                                                                                            fit: BoxFit.contain,
                                                                                          ),
                                                                                          allowRotation: false,
                                                                                          tag: columnMessagesRecord.images.elementAtOrNull(0)!,
                                                                                          useHeroAnimation: true,
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                  child: Hero(
                                                                                    tag: columnMessagesRecord.images.elementAtOrNull(0)!,
                                                                                    transitionOnUserGestures: true,
                                                                                    child: ClipRRect(
                                                                                      borderRadius: BorderRadius.only(
                                                                                        bottomLeft: Radius.circular(8.0),
                                                                                        bottomRight: Radius.circular(8.0),
                                                                                        topLeft: Radius.circular(8.0),
                                                                                        topRight: Radius.circular(8.0),
                                                                                      ),
                                                                                      child: Image.network(
                                                                                        columnMessagesRecord.images.elementAtOrNull(0)!,
                                                                                        width: 170.0,
                                                                                        height: 170.0,
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                  children: [
                                                                                    Flexible(
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                        child: Text(
                                                                                          dateTimeFormat(
                                                                                            "d/M H:mm",
                                                                                            columnMessagesRecord.currentTime!,
                                                                                            locale: FFLocalizations.of(context).languageCode,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Inter',
                                                                                                fontSize: 8.0,
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        if ((columnMessagesRecord.userID ==
                                                currentUserUid) &&
                                            (columnMessagesRecord.type ==
                                                'Image') &&
                                            ((columnMessagesRecord.images
                                                            .elementAtOrNull(
                                                                0) !=
                                                        null &&
                                                    columnMessagesRecord.images
                                                            .elementAtOrNull(
                                                                0) !=
                                                        '') &&
                                                (columnMessagesRecord.images
                                                            .elementAtOrNull(
                                                                1) ==
                                                        null ||
                                                    columnMessagesRecord.images
                                                            .elementAtOrNull(
                                                                1) ==
                                                        '')))
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          10.0, 0.0, 10.0, 8.0),
                                                  child: Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        1.0,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(
                                                                18.0),
                                                        bottomRight:
                                                            Radius.circular(
                                                                18.0),
                                                        topLeft:
                                                            Radius.circular(
                                                                0.0),
                                                        topRight:
                                                            Radius.circular(
                                                                18.0),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  10.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Flexible(
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          10.0,
                                                                          8.0),
                                                              child: Container(
                                                                width: 170.0,
                                                                height: 190.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            18.0),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            0.0),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            18.0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            18.0),
                                                                  ),
                                                                ),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Flexible(
                                                                      child:
                                                                          Material(
                                                                        color: Colors
                                                                            .transparent,
                                                                        elevation:
                                                                            1.0,
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            bottomLeft:
                                                                                Radius.circular(18.0),
                                                                            bottomRight:
                                                                                Radius.circular(0.0),
                                                                            topLeft:
                                                                                Radius.circular(18.0),
                                                                            topRight:
                                                                                Radius.circular(18.0),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              180.0,
                                                                          height:
                                                                              198.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Color(0xFF78D18A),
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              bottomLeft: Radius.circular(18.0),
                                                                              bottomRight: Radius.circular(0.0),
                                                                              topLeft: Radius.circular(18.0),
                                                                              topRight: Radius.circular(18.0),
                                                                            ),
                                                                            border:
                                                                                Border.all(
                                                                              color: Color(0xFF8B660F),
                                                                              width: 1.0,
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              InkWell(
                                                                                splashColor: Colors.transparent,
                                                                                focusColor: Colors.transparent,
                                                                                hoverColor: Colors.transparent,
                                                                                highlightColor: Colors.transparent,
                                                                                onTap: () async {
                                                                                  await Navigator.push(
                                                                                    context,
                                                                                    PageTransition(
                                                                                      type: PageTransitionType.fade,
                                                                                      child: FlutterFlowExpandedImageView(
                                                                                        image: Image.network(
                                                                                          columnMessagesRecord.images.elementAtOrNull(0)!,
                                                                                          fit: BoxFit.contain,
                                                                                        ),
                                                                                        allowRotation: false,
                                                                                        tag: columnMessagesRecord.images.elementAtOrNull(0)!,
                                                                                        useHeroAnimation: true,
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                },
                                                                                child: Hero(
                                                                                  tag: columnMessagesRecord.images.elementAtOrNull(0)!,
                                                                                  transitionOnUserGestures: true,
                                                                                  child: ClipRRect(
                                                                                    borderRadius: BorderRadius.only(
                                                                                      bottomLeft: Radius.circular(8.0),
                                                                                      bottomRight: Radius.circular(8.0),
                                                                                      topLeft: Radius.circular(8.0),
                                                                                      topRight: Radius.circular(8.0),
                                                                                    ),
                                                                                    child: Image.network(
                                                                                      columnMessagesRecord.images.elementAtOrNull(0)!,
                                                                                      width: 170.0,
                                                                                      height: 170.0,
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                children: [
                                                                                  Flexible(
                                                                                    child: Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                      child: Text(
                                                                                        dateTimeFormat(
                                                                                          "d/M h:mm a",
                                                                                          columnMessagesRecord.currentTime!,
                                                                                          locale: FFLocalizations.of(context).languageCode,
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              fontFamily: 'Inter',
                                                                                              fontSize: 8.0,
                                                                                              letterSpacing: 0.0,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        if ((columnMessagesRecord.userID !=
                                                currentUserUid) &&
                                            (columnMessagesRecord.type ==
                                                'Image') &&
                                            ((columnMessagesRecord.images
                                                            .elementAtOrNull(
                                                                1) !=
                                                        null &&
                                                    columnMessagesRecord.images
                                                            .elementAtOrNull(
                                                                1) !=
                                                        '') &&
                                                (columnMessagesRecord.images
                                                            .elementAtOrNull(
                                                                2) ==
                                                        null ||
                                                    columnMessagesRecord.images
                                                            .elementAtOrNull(
                                                                2) ==
                                                        '')))
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 0.0,
                                                                10.0, 8.0),
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          1.0,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  18.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  18.0),
                                                          topLeft:
                                                              Radius.circular(
                                                                  0.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  18.0),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    10.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Flexible(
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            10.0,
                                                                            8.0),
                                                                child:
                                                                    Container(
                                                                  width: 170.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Flexible(
                                                                        child:
                                                                            Material(
                                                                          color:
                                                                              Colors.transparent,
                                                                          elevation:
                                                                              1.0,
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              bottomLeft: Radius.circular(0.0),
                                                                              bottomRight: Radius.circular(18.0),
                                                                              topLeft: Radius.circular(18.0),
                                                                              topRight: Radius.circular(18.0),
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                180.0,
                                                                            height:
                                                                                370.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              borderRadius: BorderRadius.only(
                                                                                bottomLeft: Radius.circular(0.0),
                                                                                bottomRight: Radius.circular(18.0),
                                                                                topLeft: Radius.circular(18.0),
                                                                                topRight: Radius.circular(18.0),
                                                                              ),
                                                                              shape: BoxShape.rectangle,
                                                                              border: Border.all(
                                                                                color: Color(0xFF8B660F),
                                                                                width: 1.0,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    await Navigator.push(
                                                                                      context,
                                                                                      PageTransition(
                                                                                        type: PageTransitionType.fade,
                                                                                        child: FlutterFlowExpandedImageView(
                                                                                          image: Image.network(
                                                                                            columnMessagesRecord.images.elementAtOrNull(0)!,
                                                                                            fit: BoxFit.contain,
                                                                                          ),
                                                                                          allowRotation: false,
                                                                                          tag: columnMessagesRecord.images.elementAtOrNull(0)!,
                                                                                          useHeroAnimation: true,
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                  child: Hero(
                                                                                    tag: columnMessagesRecord.images.elementAtOrNull(0)!,
                                                                                    transitionOnUserGestures: true,
                                                                                    child: ClipRRect(
                                                                                      borderRadius: BorderRadius.only(
                                                                                        bottomLeft: Radius.circular(8.0),
                                                                                        bottomRight: Radius.circular(8.0),
                                                                                        topLeft: Radius.circular(8.0),
                                                                                        topRight: Radius.circular(8.0),
                                                                                      ),
                                                                                      child: Image.network(
                                                                                        columnMessagesRecord.images.elementAtOrNull(0)!,
                                                                                        width: 170.0,
                                                                                        height: 170.0,
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                                                                  child: InkWell(
                                                                                    splashColor: Colors.transparent,
                                                                                    focusColor: Colors.transparent,
                                                                                    hoverColor: Colors.transparent,
                                                                                    highlightColor: Colors.transparent,
                                                                                    onTap: () async {
                                                                                      await Navigator.push(
                                                                                        context,
                                                                                        PageTransition(
                                                                                          type: PageTransitionType.fade,
                                                                                          child: FlutterFlowExpandedImageView(
                                                                                            image: Image.network(
                                                                                              columnMessagesRecord.images.elementAtOrNull(1)!,
                                                                                              fit: BoxFit.contain,
                                                                                            ),
                                                                                            allowRotation: false,
                                                                                            tag: columnMessagesRecord.images.elementAtOrNull(1)!,
                                                                                            useHeroAnimation: true,
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                    child: Hero(
                                                                                      tag: columnMessagesRecord.images.elementAtOrNull(1)!,
                                                                                      transitionOnUserGestures: true,
                                                                                      child: ClipRRect(
                                                                                        borderRadius: BorderRadius.only(
                                                                                          bottomLeft: Radius.circular(8.0),
                                                                                          bottomRight: Radius.circular(8.0),
                                                                                          topLeft: Radius.circular(8.0),
                                                                                          topRight: Radius.circular(8.0),
                                                                                        ),
                                                                                        child: Image.network(
                                                                                          columnMessagesRecord.images.elementAtOrNull(1)!,
                                                                                          width: 170.0,
                                                                                          height: 170.0,
                                                                                          fit: BoxFit.cover,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                  children: [
                                                                                    Flexible(
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                        child: Text(
                                                                                          dateTimeFormat(
                                                                                            "d/M H:mm",
                                                                                            columnMessagesRecord.currentTime!,
                                                                                            locale: FFLocalizations.of(context).languageCode,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Inter',
                                                                                                fontSize: 8.0,
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        if ((columnMessagesRecord.userID ==
                                                currentUserUid) &&
                                            (columnMessagesRecord.type ==
                                                'Image') &&
                                            ((columnMessagesRecord.images
                                                            .elementAtOrNull(
                                                                1) !=
                                                        null &&
                                                    columnMessagesRecord.images
                                                            .elementAtOrNull(
                                                                1) !=
                                                        '') &&
                                                (columnMessagesRecord.images
                                                            .elementAtOrNull(
                                                                2) ==
                                                        null ||
                                                    columnMessagesRecord.images
                                                            .elementAtOrNull(
                                                                2) ==
                                                        '')))
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 0.0,
                                                                10.0, 8.0),
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          1.0,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  18.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  18.0),
                                                          topLeft:
                                                              Radius.circular(
                                                                  0.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  18.0),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    10.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Flexible(
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            10.0,
                                                                            8.0),
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      1.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Flexible(
                                                                        child:
                                                                            Material(
                                                                          color:
                                                                              Colors.transparent,
                                                                          elevation:
                                                                              1.0,
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              bottomLeft: Radius.circular(18.0),
                                                                              bottomRight: Radius.circular(0.0),
                                                                              topLeft: Radius.circular(18.0),
                                                                              topRight: Radius.circular(18.0),
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                170.0,
                                                                            height:
                                                                                370.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0xFF78D18A),
                                                                              borderRadius: BorderRadius.only(
                                                                                bottomLeft: Radius.circular(18.0),
                                                                                bottomRight: Radius.circular(0.0),
                                                                                topLeft: Radius.circular(18.0),
                                                                                topRight: Radius.circular(18.0),
                                                                              ),
                                                                              shape: BoxShape.rectangle,
                                                                              border: Border.all(
                                                                                color: Color(0xFF8B660F),
                                                                                width: 1.0,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    await Navigator.push(
                                                                                      context,
                                                                                      PageTransition(
                                                                                        type: PageTransitionType.fade,
                                                                                        child: FlutterFlowExpandedImageView(
                                                                                          image: Image.network(
                                                                                            columnMessagesRecord.images.elementAtOrNull(0)!,
                                                                                            fit: BoxFit.contain,
                                                                                          ),
                                                                                          allowRotation: false,
                                                                                          tag: columnMessagesRecord.images.elementAtOrNull(0)!,
                                                                                          useHeroAnimation: true,
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                  child: Hero(
                                                                                    tag: columnMessagesRecord.images.elementAtOrNull(0)!,
                                                                                    transitionOnUserGestures: true,
                                                                                    child: ClipRRect(
                                                                                      borderRadius: BorderRadius.only(
                                                                                        bottomLeft: Radius.circular(8.0),
                                                                                        bottomRight: Radius.circular(8.0),
                                                                                        topLeft: Radius.circular(8.0),
                                                                                        topRight: Radius.circular(8.0),
                                                                                      ),
                                                                                      child: Image.network(
                                                                                        columnMessagesRecord.images.elementAtOrNull(0)!,
                                                                                        width: 170.0,
                                                                                        height: 170.0,
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                                                                  child: InkWell(
                                                                                    splashColor: Colors.transparent,
                                                                                    focusColor: Colors.transparent,
                                                                                    hoverColor: Colors.transparent,
                                                                                    highlightColor: Colors.transparent,
                                                                                    onTap: () async {
                                                                                      await Navigator.push(
                                                                                        context,
                                                                                        PageTransition(
                                                                                          type: PageTransitionType.fade,
                                                                                          child: FlutterFlowExpandedImageView(
                                                                                            image: Image.network(
                                                                                              columnMessagesRecord.images.elementAtOrNull(1)!,
                                                                                              fit: BoxFit.contain,
                                                                                            ),
                                                                                            allowRotation: false,
                                                                                            tag: columnMessagesRecord.images.elementAtOrNull(1)!,
                                                                                            useHeroAnimation: true,
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                    child: Hero(
                                                                                      tag: columnMessagesRecord.images.elementAtOrNull(1)!,
                                                                                      transitionOnUserGestures: true,
                                                                                      child: ClipRRect(
                                                                                        borderRadius: BorderRadius.only(
                                                                                          bottomLeft: Radius.circular(8.0),
                                                                                          bottomRight: Radius.circular(8.0),
                                                                                          topLeft: Radius.circular(8.0),
                                                                                          topRight: Radius.circular(8.0),
                                                                                        ),
                                                                                        child: Image.network(
                                                                                          columnMessagesRecord.images.elementAtOrNull(1)!,
                                                                                          width: 170.0,
                                                                                          height: 170.0,
                                                                                          fit: BoxFit.cover,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                  children: [
                                                                                    Flexible(
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                        child: Text(
                                                                                          dateTimeFormat(
                                                                                            "d/M h:mm a",
                                                                                            columnMessagesRecord.currentTime!,
                                                                                            locale: FFLocalizations.of(context).languageCode,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Inter',
                                                                                                fontSize: 8.0,
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        if ((columnMessagesRecord.userID !=
                                                currentUserUid) &&
                                            (columnMessagesRecord.type ==
                                                'Image') &&
                                            ((columnMessagesRecord.images
                                                            .elementAtOrNull(
                                                                2) !=
                                                        null &&
                                                    columnMessagesRecord.images
                                                            .elementAtOrNull(
                                                                2) !=
                                                        '') &&
                                                (columnMessagesRecord.images
                                                            .elementAtOrNull(
                                                                3) ==
                                                        null ||
                                                    columnMessagesRecord.images
                                                            .elementAtOrNull(
                                                                3) ==
                                                        '')))
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 0.0,
                                                                10.0, 8.0),
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          1.0,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  18.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  18.0),
                                                          topLeft:
                                                              Radius.circular(
                                                                  0.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  18.0),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    10.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Flexible(
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            10.0,
                                                                            8.0),
                                                                child:
                                                                    Container(
                                                                  width: 170.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Flexible(
                                                                        child:
                                                                            Material(
                                                                          color:
                                                                              Colors.transparent,
                                                                          elevation:
                                                                              1.0,
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              bottomLeft: Radius.circular(0.0),
                                                                              bottomRight: Radius.circular(18.0),
                                                                              topLeft: Radius.circular(18.0),
                                                                              topRight: Radius.circular(18.0),
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                180.0,
                                                                            height:
                                                                                544.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              borderRadius: BorderRadius.only(
                                                                                bottomLeft: Radius.circular(0.0),
                                                                                bottomRight: Radius.circular(18.0),
                                                                                topLeft: Radius.circular(18.0),
                                                                                topRight: Radius.circular(18.0),
                                                                              ),
                                                                              shape: BoxShape.rectangle,
                                                                              border: Border.all(
                                                                                color: Color(0xFF8B660F),
                                                                                width: 1.0,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    await Navigator.push(
                                                                                      context,
                                                                                      PageTransition(
                                                                                        type: PageTransitionType.fade,
                                                                                        child: FlutterFlowExpandedImageView(
                                                                                          image: Image.network(
                                                                                            columnMessagesRecord.images.elementAtOrNull(0)!,
                                                                                            fit: BoxFit.contain,
                                                                                          ),
                                                                                          allowRotation: false,
                                                                                          tag: columnMessagesRecord.images.elementAtOrNull(0)!,
                                                                                          useHeroAnimation: true,
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                  child: Hero(
                                                                                    tag: columnMessagesRecord.images.elementAtOrNull(0)!,
                                                                                    transitionOnUserGestures: true,
                                                                                    child: ClipRRect(
                                                                                      borderRadius: BorderRadius.only(
                                                                                        bottomLeft: Radius.circular(8.0),
                                                                                        bottomRight: Radius.circular(8.0),
                                                                                        topLeft: Radius.circular(8.0),
                                                                                        topRight: Radius.circular(8.0),
                                                                                      ),
                                                                                      child: Image.network(
                                                                                        columnMessagesRecord.images.elementAtOrNull(0)!,
                                                                                        width: 170.0,
                                                                                        height: 170.0,
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                                                                  child: InkWell(
                                                                                    splashColor: Colors.transparent,
                                                                                    focusColor: Colors.transparent,
                                                                                    hoverColor: Colors.transparent,
                                                                                    highlightColor: Colors.transparent,
                                                                                    onTap: () async {
                                                                                      await Navigator.push(
                                                                                        context,
                                                                                        PageTransition(
                                                                                          type: PageTransitionType.fade,
                                                                                          child: FlutterFlowExpandedImageView(
                                                                                            image: Image.network(
                                                                                              columnMessagesRecord.images.elementAtOrNull(1)!,
                                                                                              fit: BoxFit.contain,
                                                                                            ),
                                                                                            allowRotation: false,
                                                                                            tag: columnMessagesRecord.images.elementAtOrNull(1)!,
                                                                                            useHeroAnimation: true,
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                    child: Hero(
                                                                                      tag: columnMessagesRecord.images.elementAtOrNull(1)!,
                                                                                      transitionOnUserGestures: true,
                                                                                      child: ClipRRect(
                                                                                        borderRadius: BorderRadius.only(
                                                                                          bottomLeft: Radius.circular(8.0),
                                                                                          bottomRight: Radius.circular(8.0),
                                                                                          topLeft: Radius.circular(8.0),
                                                                                          topRight: Radius.circular(8.0),
                                                                                        ),
                                                                                        child: Image.network(
                                                                                          columnMessagesRecord.images.elementAtOrNull(1)!,
                                                                                          width: 170.0,
                                                                                          height: 170.0,
                                                                                          fit: BoxFit.cover,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                                                                  child: InkWell(
                                                                                    splashColor: Colors.transparent,
                                                                                    focusColor: Colors.transparent,
                                                                                    hoverColor: Colors.transparent,
                                                                                    highlightColor: Colors.transparent,
                                                                                    onTap: () async {
                                                                                      await Navigator.push(
                                                                                        context,
                                                                                        PageTransition(
                                                                                          type: PageTransitionType.fade,
                                                                                          child: FlutterFlowExpandedImageView(
                                                                                            image: Image.network(
                                                                                              columnMessagesRecord.images.elementAtOrNull(2)!,
                                                                                              fit: BoxFit.contain,
                                                                                            ),
                                                                                            allowRotation: false,
                                                                                            tag: columnMessagesRecord.images.elementAtOrNull(2)!,
                                                                                            useHeroAnimation: true,
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                    child: Hero(
                                                                                      tag: columnMessagesRecord.images.elementAtOrNull(2)!,
                                                                                      transitionOnUserGestures: true,
                                                                                      child: ClipRRect(
                                                                                        borderRadius: BorderRadius.only(
                                                                                          bottomLeft: Radius.circular(8.0),
                                                                                          bottomRight: Radius.circular(8.0),
                                                                                          topLeft: Radius.circular(8.0),
                                                                                          topRight: Radius.circular(8.0),
                                                                                        ),
                                                                                        child: Image.network(
                                                                                          columnMessagesRecord.images.elementAtOrNull(2)!,
                                                                                          width: 170.0,
                                                                                          height: 170.0,
                                                                                          fit: BoxFit.cover,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                  children: [
                                                                                    Flexible(
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                        child: Text(
                                                                                          dateTimeFormat(
                                                                                            "d/M H:mm",
                                                                                            columnMessagesRecord.currentTime!,
                                                                                            locale: FFLocalizations.of(context).languageCode,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Inter',
                                                                                                fontSize: 8.0,
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        if ((columnMessagesRecord.userID ==
                                                currentUserUid) &&
                                            (columnMessagesRecord.type ==
                                                'Image') &&
                                            ((columnMessagesRecord.images
                                                            .elementAtOrNull(
                                                                2) !=
                                                        null &&
                                                    columnMessagesRecord.images
                                                            .elementAtOrNull(
                                                                2) !=
                                                        '') &&
                                                (columnMessagesRecord.images
                                                            .elementAtOrNull(
                                                                3) ==
                                                        null ||
                                                    columnMessagesRecord.images
                                                            .elementAtOrNull(
                                                                3) ==
                                                        '')))
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 0.0,
                                                                10.0, 8.0),
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          1.0,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  18.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  18.0),
                                                          topLeft:
                                                              Radius.circular(
                                                                  0.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  18.0),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    10.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Flexible(
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            10.0,
                                                                            8.0),
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      1.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Flexible(
                                                                        child:
                                                                            Material(
                                                                          color:
                                                                              Colors.transparent,
                                                                          elevation:
                                                                              1.0,
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              bottomLeft: Radius.circular(18.0),
                                                                              bottomRight: Radius.circular(0.0),
                                                                              topLeft: Radius.circular(18.0),
                                                                              topRight: Radius.circular(18.0),
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                170.0,
                                                                            height:
                                                                                544.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0xFF78D18A),
                                                                              borderRadius: BorderRadius.only(
                                                                                bottomLeft: Radius.circular(18.0),
                                                                                bottomRight: Radius.circular(0.0),
                                                                                topLeft: Radius.circular(18.0),
                                                                                topRight: Radius.circular(18.0),
                                                                              ),
                                                                              shape: BoxShape.rectangle,
                                                                              border: Border.all(
                                                                                color: Color(0xFF8B660F),
                                                                                width: 1.0,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    await Navigator.push(
                                                                                      context,
                                                                                      PageTransition(
                                                                                        type: PageTransitionType.fade,
                                                                                        child: FlutterFlowExpandedImageView(
                                                                                          image: Image.network(
                                                                                            columnMessagesRecord.images.elementAtOrNull(0)!,
                                                                                            fit: BoxFit.contain,
                                                                                          ),
                                                                                          allowRotation: false,
                                                                                          tag: columnMessagesRecord.images.elementAtOrNull(0)!,
                                                                                          useHeroAnimation: true,
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                  child: Hero(
                                                                                    tag: columnMessagesRecord.images.elementAtOrNull(0)!,
                                                                                    transitionOnUserGestures: true,
                                                                                    child: ClipRRect(
                                                                                      borderRadius: BorderRadius.only(
                                                                                        bottomLeft: Radius.circular(8.0),
                                                                                        bottomRight: Radius.circular(8.0),
                                                                                        topLeft: Radius.circular(8.0),
                                                                                        topRight: Radius.circular(8.0),
                                                                                      ),
                                                                                      child: Image.network(
                                                                                        columnMessagesRecord.images.elementAtOrNull(0)!,
                                                                                        width: 170.0,
                                                                                        height: 170.0,
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                                                                  child: InkWell(
                                                                                    splashColor: Colors.transparent,
                                                                                    focusColor: Colors.transparent,
                                                                                    hoverColor: Colors.transparent,
                                                                                    highlightColor: Colors.transparent,
                                                                                    onTap: () async {
                                                                                      await Navigator.push(
                                                                                        context,
                                                                                        PageTransition(
                                                                                          type: PageTransitionType.fade,
                                                                                          child: FlutterFlowExpandedImageView(
                                                                                            image: Image.network(
                                                                                              columnMessagesRecord.images.elementAtOrNull(1)!,
                                                                                              fit: BoxFit.contain,
                                                                                            ),
                                                                                            allowRotation: false,
                                                                                            tag: columnMessagesRecord.images.elementAtOrNull(1)!,
                                                                                            useHeroAnimation: true,
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                    child: Hero(
                                                                                      tag: columnMessagesRecord.images.elementAtOrNull(1)!,
                                                                                      transitionOnUserGestures: true,
                                                                                      child: ClipRRect(
                                                                                        borderRadius: BorderRadius.only(
                                                                                          bottomLeft: Radius.circular(8.0),
                                                                                          bottomRight: Radius.circular(8.0),
                                                                                          topLeft: Radius.circular(8.0),
                                                                                          topRight: Radius.circular(8.0),
                                                                                        ),
                                                                                        child: Image.network(
                                                                                          columnMessagesRecord.images.elementAtOrNull(1)!,
                                                                                          width: 170.0,
                                                                                          height: 170.0,
                                                                                          fit: BoxFit.cover,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                                                                  child: InkWell(
                                                                                    splashColor: Colors.transparent,
                                                                                    focusColor: Colors.transparent,
                                                                                    hoverColor: Colors.transparent,
                                                                                    highlightColor: Colors.transparent,
                                                                                    onTap: () async {
                                                                                      await Navigator.push(
                                                                                        context,
                                                                                        PageTransition(
                                                                                          type: PageTransitionType.fade,
                                                                                          child: FlutterFlowExpandedImageView(
                                                                                            image: Image.network(
                                                                                              columnMessagesRecord.images.elementAtOrNull(2)!,
                                                                                              fit: BoxFit.contain,
                                                                                            ),
                                                                                            allowRotation: false,
                                                                                            tag: columnMessagesRecord.images.elementAtOrNull(2)!,
                                                                                            useHeroAnimation: true,
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                    child: Hero(
                                                                                      tag: columnMessagesRecord.images.elementAtOrNull(2)!,
                                                                                      transitionOnUserGestures: true,
                                                                                      child: ClipRRect(
                                                                                        borderRadius: BorderRadius.only(
                                                                                          bottomLeft: Radius.circular(8.0),
                                                                                          bottomRight: Radius.circular(8.0),
                                                                                          topLeft: Radius.circular(8.0),
                                                                                          topRight: Radius.circular(8.0),
                                                                                        ),
                                                                                        child: Image.network(
                                                                                          columnMessagesRecord.images.elementAtOrNull(2)!,
                                                                                          width: 170.0,
                                                                                          height: 170.0,
                                                                                          fit: BoxFit.cover,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                  children: [
                                                                                    Flexible(
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                        child: Text(
                                                                                          dateTimeFormat(
                                                                                            "d/M H:mm",
                                                                                            columnMessagesRecord.currentTime!,
                                                                                            locale: FFLocalizations.of(context).languageCode,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Inter',
                                                                                                fontSize: 8.0,
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        if ((columnMessagesRecord.userID !=
                                                currentUserUid) &&
                                            (columnMessagesRecord.type ==
                                                'Image') &&
                                            (columnMessagesRecord.images
                                                        .elementAtOrNull(3) !=
                                                    null &&
                                                columnMessagesRecord.images
                                                        .elementAtOrNull(3) !=
                                                    ''))
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 0.0,
                                                                10.0, 8.0),
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          1.0,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  18.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  18.0),
                                                          topLeft:
                                                              Radius.circular(
                                                                  0.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  18.0),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    10.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Flexible(
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            10.0,
                                                                            8.0),
                                                                child: Material(
                                                                  color: Colors
                                                                      .transparent,
                                                                  elevation:
                                                                      1.0,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              16.0),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              16.0),
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              0.0),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              16.0),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        180.0,
                                                                    height:
                                                                        210.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        bottomLeft:
                                                                            Radius.circular(16.0),
                                                                        bottomRight:
                                                                            Radius.circular(16.0),
                                                                        topLeft:
                                                                            Radius.circular(0.0),
                                                                        topRight:
                                                                            Radius.circular(16.0),
                                                                      ),
                                                                      shape: BoxShape
                                                                          .rectangle,
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Color(
                                                                            0xFF8B660F),
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Stack(
                                                                      children: [
                                                                        Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 2.0, 0.0),
                                                                                  child: InkWell(
                                                                                    splashColor: Colors.transparent,
                                                                                    focusColor: Colors.transparent,
                                                                                    hoverColor: Colors.transparent,
                                                                                    highlightColor: Colors.transparent,
                                                                                    onTap: () async {
                                                                                      await Navigator.push(
                                                                                        context,
                                                                                        PageTransition(
                                                                                          type: PageTransitionType.fade,
                                                                                          child: FlutterFlowExpandedImageView(
                                                                                            image: Image.network(
                                                                                              columnMessagesRecord.images.elementAtOrNull(0)!,
                                                                                              fit: BoxFit.contain,
                                                                                            ),
                                                                                            allowRotation: false,
                                                                                            tag: columnMessagesRecord.images.elementAtOrNull(0)!,
                                                                                            useHeroAnimation: true,
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                    child: Hero(
                                                                                      tag: columnMessagesRecord.images.elementAtOrNull(0)!,
                                                                                      transitionOnUserGestures: true,
                                                                                      child: ClipRRect(
                                                                                        borderRadius: BorderRadius.only(
                                                                                          bottomLeft: Radius.circular(8.0),
                                                                                          bottomRight: Radius.circular(8.0),
                                                                                          topLeft: Radius.circular(8.0),
                                                                                          topRight: Radius.circular(8.0),
                                                                                        ),
                                                                                        child: Image.network(
                                                                                          columnMessagesRecord.images.elementAtOrNull(0)!,
                                                                                          width: 85.0,
                                                                                          height: 85.0,
                                                                                          fit: BoxFit.cover,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(2.0, 6.0, 0.0, 0.0),
                                                                                  child: InkWell(
                                                                                    splashColor: Colors.transparent,
                                                                                    focusColor: Colors.transparent,
                                                                                    hoverColor: Colors.transparent,
                                                                                    highlightColor: Colors.transparent,
                                                                                    onTap: () async {
                                                                                      await Navigator.push(
                                                                                        context,
                                                                                        PageTransition(
                                                                                          type: PageTransitionType.fade,
                                                                                          child: FlutterFlowExpandedImageView(
                                                                                            image: Image.network(
                                                                                              columnMessagesRecord.images.elementAtOrNull(1)!,
                                                                                              fit: BoxFit.contain,
                                                                                            ),
                                                                                            allowRotation: false,
                                                                                            tag: columnMessagesRecord.images.elementAtOrNull(1)!,
                                                                                            useHeroAnimation: true,
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                    child: Hero(
                                                                                      tag: columnMessagesRecord.images.elementAtOrNull(1)!,
                                                                                      transitionOnUserGestures: true,
                                                                                      child: ClipRRect(
                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                        child: Image.network(
                                                                                          columnMessagesRecord.images.elementAtOrNull(1)!,
                                                                                          width: 85.0,
                                                                                          height: 85.0,
                                                                                          fit: BoxFit.cover,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 2.0, 6.0),
                                                                                    child: InkWell(
                                                                                      splashColor: Colors.transparent,
                                                                                      focusColor: Colors.transparent,
                                                                                      hoverColor: Colors.transparent,
                                                                                      highlightColor: Colors.transparent,
                                                                                      onTap: () async {
                                                                                        await Navigator.push(
                                                                                          context,
                                                                                          PageTransition(
                                                                                            type: PageTransitionType.fade,
                                                                                            child: FlutterFlowExpandedImageView(
                                                                                              image: Image.network(
                                                                                                columnMessagesRecord.images.elementAtOrNull(2)!,
                                                                                                fit: BoxFit.contain,
                                                                                              ),
                                                                                              allowRotation: false,
                                                                                              tag: columnMessagesRecord.images.elementAtOrNull(2)!,
                                                                                              useHeroAnimation: true,
                                                                                            ),
                                                                                          ),
                                                                                        );
                                                                                      },
                                                                                      child: Hero(
                                                                                        tag: columnMessagesRecord.images.elementAtOrNull(2)!,
                                                                                        transitionOnUserGestures: true,
                                                                                        child: ClipRRect(
                                                                                          borderRadius: BorderRadius.circular(8.0),
                                                                                          child: Image.network(
                                                                                            columnMessagesRecord.images.elementAtOrNull(2)!,
                                                                                            width: 85.0,
                                                                                            height: 85.0,
                                                                                            fit: BoxFit.cover,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 0.0, 6.0),
                                                                                    child: InkWell(
                                                                                      splashColor: Colors.transparent,
                                                                                      focusColor: Colors.transparent,
                                                                                      hoverColor: Colors.transparent,
                                                                                      highlightColor: Colors.transparent,
                                                                                      onTap: () async {
                                                                                        await Navigator.push(
                                                                                          context,
                                                                                          PageTransition(
                                                                                            type: PageTransitionType.fade,
                                                                                            child: FlutterFlowExpandedImageView(
                                                                                              image: Image.network(
                                                                                                columnMessagesRecord.images.elementAtOrNull(3)!,
                                                                                                fit: BoxFit.contain,
                                                                                              ),
                                                                                              allowRotation: false,
                                                                                              tag: columnMessagesRecord.images.elementAtOrNull(3)!,
                                                                                              useHeroAnimation: true,
                                                                                            ),
                                                                                          ),
                                                                                        );
                                                                                      },
                                                                                      child: Hero(
                                                                                        tag: columnMessagesRecord.images.elementAtOrNull(3)!,
                                                                                        transitionOnUserGestures: true,
                                                                                        child: ClipRRect(
                                                                                          borderRadius: BorderRadius.circular(8.0),
                                                                                          child: Image.network(
                                                                                            columnMessagesRecord.images.elementAtOrNull(3)!,
                                                                                            width: 85.0,
                                                                                            height: 85.0,
                                                                                            fit: BoxFit.cover,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                  child: Text(
                                                                                    dateTimeFormat(
                                                                                      "d/M h:mm a",
                                                                                      columnMessagesRecord.currentTime!,
                                                                                      locale: FFLocalizations.of(context).languageCode,
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Inter',
                                                                                          fontSize: 8.0,
                                                                                          letterSpacing: 0.0,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              60.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Container(
                                                                                width: 80.0,
                                                                                height: 80.0,
                                                                                decoration: BoxDecoration(
                                                                                  color: Color(0xCD757575),
                                                                                  borderRadius: BorderRadius.circular(18.0),
                                                                                ),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    Text(
                                                                                      columnMessagesRecord.images.length.toString(),
                                                                                      textAlign: TextAlign.center,
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'Inter',
                                                                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                            fontSize: 26.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                          ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        if ((columnMessagesRecord.userID ==
                                                currentUserUid) &&
                                            (columnMessagesRecord.type ==
                                                'Image') &&
                                            (columnMessagesRecord.images
                                                        .elementAtOrNull(3) !=
                                                    null &&
                                                columnMessagesRecord.images
                                                        .elementAtOrNull(3) !=
                                                    ''))
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 0.0,
                                                                10.0, 8.0),
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          1.0,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  18.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  18.0),
                                                          topLeft:
                                                              Radius.circular(
                                                                  18.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  0.0),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    10.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Flexible(
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            10.0,
                                                                            8.0),
                                                                child: Material(
                                                                  color: Colors
                                                                      .transparent,
                                                                  elevation:
                                                                      1.0,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              16.0),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              16.0),
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              16.0),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              0.0),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        180.0,
                                                                    height:
                                                                        210.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xFF78D18A),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        bottomLeft:
                                                                            Radius.circular(16.0),
                                                                        bottomRight:
                                                                            Radius.circular(16.0),
                                                                        topLeft:
                                                                            Radius.circular(16.0),
                                                                        topRight:
                                                                            Radius.circular(0.0),
                                                                      ),
                                                                      shape: BoxShape
                                                                          .rectangle,
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Color(
                                                                            0xFF8B660F),
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Stack(
                                                                      children: [
                                                                        Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 2.0, 0.0),
                                                                                  child: InkWell(
                                                                                    splashColor: Colors.transparent,
                                                                                    focusColor: Colors.transparent,
                                                                                    hoverColor: Colors.transparent,
                                                                                    highlightColor: Colors.transparent,
                                                                                    onTap: () async {
                                                                                      await Navigator.push(
                                                                                        context,
                                                                                        PageTransition(
                                                                                          type: PageTransitionType.fade,
                                                                                          child: FlutterFlowExpandedImageView(
                                                                                            image: Image.network(
                                                                                              columnMessagesRecord.images.elementAtOrNull(0)!,
                                                                                              fit: BoxFit.contain,
                                                                                            ),
                                                                                            allowRotation: false,
                                                                                            tag: columnMessagesRecord.images.elementAtOrNull(0)!,
                                                                                            useHeroAnimation: true,
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                    child: Hero(
                                                                                      tag: columnMessagesRecord.images.elementAtOrNull(0)!,
                                                                                      transitionOnUserGestures: true,
                                                                                      child: ClipRRect(
                                                                                        borderRadius: BorderRadius.only(
                                                                                          bottomLeft: Radius.circular(8.0),
                                                                                          bottomRight: Radius.circular(8.0),
                                                                                          topLeft: Radius.circular(8.0),
                                                                                          topRight: Radius.circular(8.0),
                                                                                        ),
                                                                                        child: Image.network(
                                                                                          columnMessagesRecord.images.elementAtOrNull(0)!,
                                                                                          width: 85.0,
                                                                                          height: 85.0,
                                                                                          fit: BoxFit.cover,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(2.0, 6.0, 0.0, 0.0),
                                                                                  child: InkWell(
                                                                                    splashColor: Colors.transparent,
                                                                                    focusColor: Colors.transparent,
                                                                                    hoverColor: Colors.transparent,
                                                                                    highlightColor: Colors.transparent,
                                                                                    onTap: () async {
                                                                                      await Navigator.push(
                                                                                        context,
                                                                                        PageTransition(
                                                                                          type: PageTransitionType.fade,
                                                                                          child: FlutterFlowExpandedImageView(
                                                                                            image: Image.network(
                                                                                              columnMessagesRecord.images.elementAtOrNull(1)!,
                                                                                              fit: BoxFit.contain,
                                                                                            ),
                                                                                            allowRotation: false,
                                                                                            tag: columnMessagesRecord.images.elementAtOrNull(1)!,
                                                                                            useHeroAnimation: true,
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                    child: Hero(
                                                                                      tag: columnMessagesRecord.images.elementAtOrNull(1)!,
                                                                                      transitionOnUserGestures: true,
                                                                                      child: ClipRRect(
                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                        child: Image.network(
                                                                                          columnMessagesRecord.images.elementAtOrNull(1)!,
                                                                                          width: 85.0,
                                                                                          height: 85.0,
                                                                                          fit: BoxFit.cover,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 2.0, 6.0),
                                                                                    child: InkWell(
                                                                                      splashColor: Colors.transparent,
                                                                                      focusColor: Colors.transparent,
                                                                                      hoverColor: Colors.transparent,
                                                                                      highlightColor: Colors.transparent,
                                                                                      onTap: () async {
                                                                                        await Navigator.push(
                                                                                          context,
                                                                                          PageTransition(
                                                                                            type: PageTransitionType.fade,
                                                                                            child: FlutterFlowExpandedImageView(
                                                                                              image: Image.network(
                                                                                                columnMessagesRecord.images.elementAtOrNull(2)!,
                                                                                                fit: BoxFit.contain,
                                                                                              ),
                                                                                              allowRotation: false,
                                                                                              tag: columnMessagesRecord.images.elementAtOrNull(2)!,
                                                                                              useHeroAnimation: true,
                                                                                            ),
                                                                                          ),
                                                                                        );
                                                                                      },
                                                                                      child: Hero(
                                                                                        tag: columnMessagesRecord.images.elementAtOrNull(2)!,
                                                                                        transitionOnUserGestures: true,
                                                                                        child: ClipRRect(
                                                                                          borderRadius: BorderRadius.circular(8.0),
                                                                                          child: Image.network(
                                                                                            columnMessagesRecord.images.elementAtOrNull(2)!,
                                                                                            width: 85.0,
                                                                                            height: 85.0,
                                                                                            fit: BoxFit.cover,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 0.0, 6.0),
                                                                                    child: InkWell(
                                                                                      splashColor: Colors.transparent,
                                                                                      focusColor: Colors.transparent,
                                                                                      hoverColor: Colors.transparent,
                                                                                      highlightColor: Colors.transparent,
                                                                                      onTap: () async {
                                                                                        await Navigator.push(
                                                                                          context,
                                                                                          PageTransition(
                                                                                            type: PageTransitionType.fade,
                                                                                            child: FlutterFlowExpandedImageView(
                                                                                              image: Image.network(
                                                                                                columnMessagesRecord.images.elementAtOrNull(3)!,
                                                                                                fit: BoxFit.contain,
                                                                                              ),
                                                                                              allowRotation: false,
                                                                                              tag: columnMessagesRecord.images.elementAtOrNull(3)!,
                                                                                              useHeroAnimation: true,
                                                                                            ),
                                                                                          ),
                                                                                        );
                                                                                      },
                                                                                      child: Hero(
                                                                                        tag: columnMessagesRecord.images.elementAtOrNull(3)!,
                                                                                        transitionOnUserGestures: true,
                                                                                        child: ClipRRect(
                                                                                          borderRadius: BorderRadius.circular(8.0),
                                                                                          child: Image.network(
                                                                                            columnMessagesRecord.images.elementAtOrNull(3)!,
                                                                                            width: 85.0,
                                                                                            height: 85.0,
                                                                                            fit: BoxFit.cover,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                  child: Text(
                                                                                    dateTimeFormat(
                                                                                      "d/M h:mm a",
                                                                                      columnMessagesRecord.currentTime!,
                                                                                      locale: FFLocalizations.of(context).languageCode,
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Inter',
                                                                                          fontSize: 8.0,
                                                                                          letterSpacing: 0.0,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              60.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Container(
                                                                                width: 80.0,
                                                                                height: 80.0,
                                                                                decoration: BoxDecoration(
                                                                                  color: Color(0xCD757575),
                                                                                  borderRadius: BorderRadius.circular(18.0),
                                                                                ),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    Text(
                                                                                      columnMessagesRecord.images.length.toString(),
                                                                                      textAlign: TextAlign.center,
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'Inter',
                                                                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                            fontSize: 26.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                          ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    );
                                  }),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 30.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 12.0, 20.0),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                borderRadius: BorderRadius.circular(18.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  width: 1.0,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 0.0, 0.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        await showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          enableDrag: false,
                                          context: context,
                                          builder: (context) {
                                            return GestureDetector(
                                              onTap: () {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                              },
                                              child: Padding(
                                                padding:
                                                    MediaQuery.viewInsetsOf(
                                                        context),
                                                child:
                                                    ButtonSheetChatPhotoWidget(
                                                  chatID: widget!.chatID!,
                                                ),
                                              ),
                                            );
                                          },
                                        ).then((value) => safeSetState(() {}));
                                      },
                                      child: Icon(
                                        Icons.photo_camera_sharp,
                                        color: Color(0xFF8B660F),
                                        size: 35.0,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: 200.0,
                                      child: TextFormField(
                                        controller: _model.textController,
                                        focusNode: _model.textFieldFocusNode,
                                        onChanged: (_) => EasyDebounce.debounce(
                                          '_model.textController',
                                          Duration(milliseconds: 1000),
                                          () => safeSetState(() {}),
                                        ),
                                        autofocus: false,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          labelStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .override(
                                                    fontFamily: 'Inter',
                                                    letterSpacing: 0.0,
                                                  ),
                                          hintText: FFLocalizations.of(context)
                                              .getText(
                                            'eg8g1fib' /* 打声招呼吧 */,
                                          ),
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .override(
                                                    fontFamily: 'Inter',
                                                    letterSpacing: 0.0,
                                                  ),
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                          filled: true,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  4.0, 6.0, 4.0, 6.0),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              letterSpacing: 0.0,
                                            ),
                                        textAlign: TextAlign.start,
                                        maxLines: 5,
                                        minLines: 1,
                                        cursorColor:
                                            FlutterFlowTheme.of(context)
                                                .primaryText,
                                        validator: _model
                                            .textControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                  if (_model.textController.text != null &&
                                      _model.textController.text != '')
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 10.0, 0.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          await MessagesRecord.collection
                                              .doc()
                                              .set(createMessagesRecordData(
                                                chatID: widget!.chatID,
                                                userID: currentUserUid,
                                                text:
                                                    _model.textController.text,
                                                currentTime:
                                                    getCurrentTimestamp,
                                                type: 'Text',
                                              ));

                                          await chatChatRecord!.reference
                                              .update(createChatRecordData(
                                            lastMessage:
                                                _model.textController.text,
                                            lastaMessageTime:
                                                getCurrentTimestamp,
                                          ));
                                          safeSetState(() {
                                            _model.textController?.clear();
                                          });
                                          await _model.columnChat?.animateTo(
                                            _model.columnChat!.position
                                                .maxScrollExtent,
                                            duration:
                                                Duration(milliseconds: 100),
                                            curve: Curves.ease,
                                          );
                                        },
                                        child: Icon(
                                          Icons.send_outlined,
                                          color: Color(0xFF8B660F),
                                          size: 35.0,
                                        ),
                                      ),
                                    ),
                                  if (_model.textController.text == null ||
                                      _model.textController.text == '')
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 10.0, 0.0),
                                      child: Icon(
                                        Icons.send_outlined,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 35.0,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
