import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'users_page_model.dart';
export 'users_page_model.dart';

class UsersPageWidget extends StatefulWidget {
  const UsersPageWidget({
    super.key,
    required this.user,
  });

  final String? user;

  static String routeName = 'UsersPage';
  static String routePath = '/usersPage';

  @override
  State<UsersPageWidget> createState() => _UsersPageWidgetState();
}

class _UsersPageWidgetState extends State<UsersPageWidget> {
  late UsersPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UsersPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: StreamBuilder<List<UsersRecord>>(
          stream: queryUsersRecord(
            queryBuilder: (usersRecord) => usersRecord.where(
              'uid',
              isEqualTo: widget!.user,
            ),
            singleRecord: true,
          ),
          builder: (context, snapshot) {
            // Customize what your widget looks like when it's loading.
            if (!snapshot.hasData) {
              return Center(
                child: SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                  ),
                ),
              );
            }
            List<UsersRecord> columnUsersRecordList = snapshot.data!;
            // Return an empty Container when the item does not exist.
            if (snapshot.data!.isEmpty) {
              return Container();
            }
            final columnUsersRecord = columnUsersRecordList.isNotEmpty
                ? columnUsersRecordList.first
                : null;

            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(12.0, 20.0, 12.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
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
                          FontAwesomeIcons.solidArrowAltCircleLeft,
                          color: Color(0xFF8B660F),
                          size: 24.0,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                        child: Text(
                          valueOrDefault<String>(
                            columnUsersRecord?.username,
                            '用户名',
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
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
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 80.0,
                        height: 80.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          columnUsersRecord!.photoUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 20.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                child: Container(
                                  height: 60.0,
                                  decoration: BoxDecoration(),
                                  child: FutureBuilder<int>(
                                    future: queryPostRecordCount(
                                      queryBuilder: (postRecord) =>
                                          postRecord.where(
                                        'userID',
                                        isEqualTo: widget!.user,
                                      ),
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
                                                    .secondaryBackground,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      int columnCount = snapshot.data!;

                                      return Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            columnCount.toString(),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Inter',
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'tkav54tm' /* Posts */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Inter',
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Flexible(
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                      FollowersFollowingWidget.routeName,
                                      queryParameters: {
                                        'userid': serializeParam(
                                          columnUsersRecord?.uid,
                                          ParamType.String,
                                        ),
                                      }.withoutNulls,
                                      extra: <String, dynamic>{
                                        kTransitionInfoKey: TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.fade,
                                          duration: Duration(milliseconds: 0),
                                        ),
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: 60.0,
                                    decoration: BoxDecoration(),
                                    child: FutureBuilder<int>(
                                      future: queryUsersRecordCount(
                                        queryBuilder: (usersRecord) =>
                                            usersRecord.where(
                                          'following',
                                          arrayContains:
                                              columnUsersRecord?.reference,
                                        ),
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
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        int columnCount = snapshot.data!;

                                        return Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              columnCount.toString(),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        color: Colors.black,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                            ),
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                '4ozkx29y' /* Followers */,
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        color: Colors.black,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                    FollowersFollowingWidget.routeName,
                                    queryParameters: {
                                      'userid': serializeParam(
                                        columnUsersRecord?.uid,
                                        ParamType.String,
                                      ),
                                    }.withoutNulls,
                                    extra: <String, dynamic>{
                                      kTransitionInfoKey: TransitionInfo(
                                        hasTransition: true,
                                        transitionType: PageTransitionType.fade,
                                        duration: Duration(milliseconds: 0),
                                      ),
                                    },
                                  );
                                },
                                child: Container(
                                  height: 60.0,
                                  decoration: BoxDecoration(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        valueOrDefault<String>(
                                          columnUsersRecord?.following?.length
                                              ?.toString(),
                                          '0',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color: Colors.black,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'f8y80uoj' /* Following */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color: Colors.black,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (columnUsersRecord?.displayName != null &&
                          columnUsersRecord?.displayName != '')
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 12.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: Text(
                                  columnUsersRecord!.displayName,
                                  maxLines: 1,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (columnUsersRecord?.description != null &&
                          columnUsersRecord?.description != '')
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 6.0, 12.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: Text(
                                  columnUsersRecord!.description,
                                  maxLines: 4,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        lineHeight: 1.0,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (columnUsersRecord?.website != null &&
                          columnUsersRecord?.website != '')
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 6.0, 12.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: Text(
                                  columnUsersRecord!.website,
                                  maxLines: 4,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        lineHeight: 1.0,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (!(currentUserDocument?.following?.toList() ?? [])
                          .contains(columnUsersRecord?.reference))
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 0.0, 0.0),
                          child: AuthUserStreamWidget(
                            builder: (context) => FFButtonWidget(
                              onPressed: () async {
                                await currentUserReference!.update({
                                  ...mapToFirestore(
                                    {
                                      'following': FieldValue.arrayUnion(
                                          [columnUsersRecord?.reference]),
                                    },
                                  ),
                                });
                                FFAppState().FollowUnfollow =
                                    random_data.randomInteger(3, 3);
                                safeSetState(() {});
                              },
                              text: FFLocalizations.of(context).getText(
                                'cgmquefy' /* Follow */,
                              ),
                              options: FFButtonOptions(
                                width: 110.0,
                                height: 30.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: Color(0xFF8B660F),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Inter',
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                    ),
                                elevation: 1.0,
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              showLoadingIndicator: false,
                            ),
                          ),
                        ),
                      if ((currentUserDocument?.following?.toList() ?? [])
                          .contains(columnUsersRecord?.reference))
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 0.0, 0.0),
                          child: AuthUserStreamWidget(
                            builder: (context) => FFButtonWidget(
                              onPressed: () async {
                                await currentUserReference!.update({
                                  ...mapToFirestore(
                                    {
                                      'following': FieldValue.arrayRemove(
                                          [columnUsersRecord?.reference]),
                                    },
                                  ),
                                });
                                FFAppState().FollowUnfollow =
                                    random_data.randomInteger(3, 3);
                                safeSetState(() {});
                              },
                              text: FFLocalizations.of(context).getText(
                                '54pztqq4' /* Unfollow */,
                              ),
                              options: FFButtonOptions(
                                width: 110.0,
                                height: 30.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: Color(0xFF8F9AA4),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Inter',
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                    ),
                                elevation: 1.0,
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              showLoadingIndicator: false,
                            ),
                          ),
                        ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                        child: StreamBuilder<List<ChatRecord>>(
                          stream: queryChatRecord(
                            queryBuilder: (chatRecord) => chatRecord.where(
                              'chatID',
                              isEqualTo:
                                  '${columnUsersRecord?.uid}${currentUserUid}',
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
                            List<ChatRecord> messageChatRecordList =
                                snapshot.data!;
                            final messageChatRecord =
                                messageChatRecordList.isNotEmpty
                                    ? messageChatRecordList.first
                                    : null;

                            return FFButtonWidget(
                              onPressed: () async {
                                if (messageChatRecord?.reference != null) {
                                  context.pushNamed(
                                    ChatWidget.routeName,
                                    queryParameters: {
                                      'chatID': serializeParam(
                                        messageChatRecord?.chatID,
                                        ParamType.String,
                                      ),
                                    }.withoutNulls,
                                    extra: <String, dynamic>{
                                      kTransitionInfoKey: TransitionInfo(
                                        hasTransition: true,
                                        transitionType: PageTransitionType.fade,
                                        duration: Duration(milliseconds: 0),
                                      ),
                                    },
                                  );
                                } else {
                                  context.pushNamed(
                                    ChatIntermediateWidget.routeName,
                                    queryParameters: {
                                      'otherUserID': serializeParam(
                                        columnUsersRecord?.uid,
                                        ParamType.String,
                                      ),
                                    }.withoutNulls,
                                    extra: <String, dynamic>{
                                      kTransitionInfoKey: TransitionInfo(
                                        hasTransition: true,
                                        transitionType: PageTransitionType.fade,
                                        duration: Duration(milliseconds: 0),
                                      ),
                                    },
                                  );
                                }
                              },
                              text: FFLocalizations.of(context).getText(
                                'aygwrogy' /* 发信息 */,
                              ),
                              options: FFButtonOptions(
                                width: 110.0,
                                height: 30.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).alternate,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Inter',
                                      color: Color(0xFF8B660F),
                                      letterSpacing: 0.0,
                                    ),
                                elevation: 1.0,
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(-1.0, 0.0),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                        child: StreamBuilder<List<PostRecord>>(
                          stream: queryPostRecord(
                            queryBuilder: (postRecord) => postRecord
                                .where(
                                  'userID',
                                  isEqualTo: columnUsersRecord?.uid,
                                )
                                .orderBy('time', descending: true),
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 40.0,
                                  height: 40.0,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                    ),
                                  ),
                                ),
                              );
                            }
                            List<PostRecord> wrapPostRecordList =
                                snapshot.data!;

                            return Wrap(
                              spacing: 2.0,
                              runSpacing: 2.0,
                              alignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              direction: Axis.horizontal,
                              runAlignment: WrapAlignment.start,
                              verticalDirection: VerticalDirection.down,
                              clipBehavior: Clip.none,
                              children: List.generate(wrapPostRecordList.length,
                                  (wrapIndex) {
                                final wrapPostRecord =
                                    wrapPostRecordList[wrapIndex];
                                return Container(
                                  decoration: BoxDecoration(),
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.32,
                                    height: 130.0,
                                    child: Stack(
                                      children: [
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            context.pushNamed(
                                              UserPostWidget.routeName,
                                              queryParameters: {
                                                'codeRef': serializeParam(
                                                  wrapPostRecord.codeRef,
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
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              wrapPostRecord
                                                  .photos.firstOrNull!,
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.32,
                                              height: 130.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        if (wrapPostRecord.photos.length != 1)
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Icon(
                                                Icons.photo_library_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                size: 24.0,
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
