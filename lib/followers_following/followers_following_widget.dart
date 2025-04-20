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
import 'followers_following_model.dart';
export 'followers_following_model.dart';

class FollowersFollowingWidget extends StatefulWidget {
  const FollowersFollowingWidget({
    super.key,
    required this.userid,
  });

  final String? userid;

  static String routeName = 'Followers_Following';
  static String routePath = '/followersFollowing';

  @override
  State<FollowersFollowingWidget> createState() =>
      _FollowersFollowingWidgetState();
}

class _FollowersFollowingWidgetState extends State<FollowersFollowingWidget>
    with TickerProviderStateMixin {
  late FollowersFollowingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FollowersFollowingModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UsersRecord>>(
      stream: queryUsersRecord(
        queryBuilder: (usersRecord) => usersRecord.where(
          'uid',
          isEqualTo: widget!.userid,
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
                width: 40.0,
                height: 40.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                ),
              ),
            ),
          );
        }
        List<UsersRecord> followersFollowingUsersRecordList = snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final followersFollowingUsersRecord =
            followersFollowingUsersRecordList.isNotEmpty
                ? followersFollowingUsersRecordList.first
                : null;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Column(
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
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment(0.0, 0),
                        child: TabBar(
                          labelColor: Color(0xFF8B660F),
                          unselectedLabelColor:
                              FlutterFlowTheme.of(context).secondaryText,
                          labelStyle:
                              FlutterFlowTheme.of(context).titleMedium.override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                          unselectedLabelStyle:
                              FlutterFlowTheme.of(context).titleMedium.override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                          indicatorColor: Color(0xFF8B660F),
                          tabs: [
                            Tab(
                              text: FFLocalizations.of(context).getText(
                                'hfr12582' /* Followers */,
                              ),
                              iconMargin: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 20.0, 20.0, 20.0),
                            ),
                            Tab(
                              text: FFLocalizations.of(context).getText(
                                'cmb12buu' /* Following */,
                              ),
                            ),
                          ],
                          controller: _model.tabBarController,
                          onTap: (i) async {
                            [() async {}, () async {}][i]();
                          },
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _model.tabBarController,
                          children: [
                            StreamBuilder<List<UsersRecord>>(
                              stream: queryUsersRecord(
                                queryBuilder: (usersRecord) =>
                                    usersRecord.where(
                                  'following',
                                  arrayContains:
                                      followersFollowingUsersRecord?.reference,
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
                                List<UsersRecord>
                                    columnFollowersUsersRecordList =
                                    snapshot.data!;

                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: List.generate(
                                      columnFollowersUsersRecordList.length,
                                      (columnFollowersIndex) {
                                    final columnFollowersUsersRecord =
                                        columnFollowersUsersRecordList[
                                            columnFollowersIndex];
                                    return Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      height: 60.0,
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12.0, 0.0, 12.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 10.0, 0.0, 0.0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  if (columnFollowersUsersRecord
                                                          .uid ==
                                                      currentUserUid) {
                                                    context.pushNamed(
                                                      MyProfileWidget.routeName,
                                                      extra: <String, dynamic>{
                                                        kTransitionInfoKey:
                                                            TransitionInfo(
                                                          hasTransition: true,
                                                          transitionType:
                                                              PageTransitionType
                                                                  .fade,
                                                          duration: Duration(
                                                              milliseconds: 0),
                                                        ),
                                                      },
                                                    );
                                                  } else {
                                                    context.pushNamed(
                                                      UsersPageWidget.routeName,
                                                      queryParameters: {
                                                        'user': serializeParam(
                                                          columnFollowersUsersRecord
                                                              .uid,
                                                          ParamType.String,
                                                        ),
                                                      }.withoutNulls,
                                                      extra: <String, dynamic>{
                                                        kTransitionInfoKey:
                                                            TransitionInfo(
                                                          hasTransition: true,
                                                          transitionType:
                                                              PageTransitionType
                                                                  .fade,
                                                          duration: Duration(
                                                              milliseconds: 0),
                                                        ),
                                                      },
                                                    );
                                                  }
                                                },
                                                child: Container(
                                                  width: 60.0,
                                                  height: 60.0,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Image.network(
                                                    columnFollowersUsersRecord
                                                        .photoUrl,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 0.0, 10.0, 0.0),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    if (columnFollowersUsersRecord
                                                            .uid ==
                                                        currentUserUid) {
                                                      context.pushNamed(
                                                        MyProfileWidget
                                                            .routeName,
                                                        extra: <String,
                                                            dynamic>{
                                                          kTransitionInfoKey:
                                                              TransitionInfo(
                                                            hasTransition: true,
                                                            transitionType:
                                                                PageTransitionType
                                                                    .fade,
                                                            duration: Duration(
                                                                milliseconds:
                                                                    0),
                                                          ),
                                                        },
                                                      );
                                                    } else {
                                                      context.pushNamed(
                                                        UsersPageWidget
                                                            .routeName,
                                                        queryParameters: {
                                                          'user':
                                                              serializeParam(
                                                            columnFollowersUsersRecord
                                                                .uid,
                                                            ParamType.String,
                                                          ),
                                                        }.withoutNulls,
                                                        extra: <String,
                                                            dynamic>{
                                                          kTransitionInfoKey:
                                                              TransitionInfo(
                                                            hasTransition: true,
                                                            transitionType:
                                                                PageTransitionType
                                                                    .fade,
                                                            duration: Duration(
                                                                milliseconds:
                                                                    0),
                                                          ),
                                                        },
                                                      );
                                                    }
                                                  },
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Flexible(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      6.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            columnFollowersUsersRecord
                                                                .username,
                                                            maxLines: 1,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  lineHeight:
                                                                      1.0,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      6.0),
                                                          child: Text(
                                                            columnFollowersUsersRecord
                                                                .displayName,
                                                            maxLines: 1,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  letterSpacing:
                                                                      0.0,
                                                                  lineHeight:
                                                                      1.0,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (currentUserUid ==
                                                widget!.userid)
                                              FFButtonWidget(
                                                onPressed: () async {
                                                  await columnFollowersUsersRecord
                                                      .reference
                                                      .update({
                                                    ...mapToFirestore(
                                                      {
                                                        'following': FieldValue
                                                            .arrayRemove([
                                                          currentUserReference
                                                        ]),
                                                      },
                                                    ),
                                                  });
                                                },
                                                text:
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                  '590nqi3s' /* 删除 */,
                                                ),
                                                options: FFButtonOptions(
                                                  width: 100.0,
                                                  height: 30.0,
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          16.0, 0.0, 16.0, 0.0),
                                                  iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0.0, 0.0,
                                                              0.0, 0.0),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.0,
                                                      ),
                                                  elevation: 0.0,
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                ),
                                                showLoadingIndicator: false,
                                              ),
                                            if ((columnFollowersUsersRecord
                                                        .uid !=
                                                    currentUserUid) &&
                                                (widget!.userid !=
                                                    currentUserUid))
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  if (!(currentUserDocument
                                                                  ?.following
                                                                  ?.toList() ??
                                                              [])
                                                          .contains(
                                                              columnFollowersUsersRecord
                                                                  .reference) &&
                                                      (widget!.userid !=
                                                          currentUserUid))
                                                    AuthUserStreamWidget(
                                                      builder: (context) =>
                                                          FFButtonWidget(
                                                        onPressed: () async {
                                                          await currentUserReference!
                                                              .update({
                                                            ...mapToFirestore(
                                                              {
                                                                'following':
                                                                    FieldValue
                                                                        .arrayUnion([
                                                                  columnFollowersUsersRecord
                                                                      .reference
                                                                ]),
                                                              },
                                                            ),
                                                          });
                                                          FFAppState()
                                                                  .FollowUnfollow =
                                                              random_data
                                                                  .randomInteger(
                                                                      3, 3);
                                                          safeSetState(() {});
                                                        },
                                                        text:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                          '1nuek9wq' /* Follow */,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          width: 100.0,
                                                          height: 30.0,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      16.0,
                                                                      0.0,
                                                                      16.0,
                                                                      0.0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'Inter',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    fontSize:
                                                                        14.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                          elevation: 0.0,
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryText,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      18.0),
                                                        ),
                                                        showLoadingIndicator:
                                                            false,
                                                      ),
                                                    ),
                                                  if ((currentUserDocument
                                                              ?.following
                                                              ?.toList() ??
                                                          [])
                                                      .contains(
                                                          columnFollowersUsersRecord
                                                              .reference))
                                                    AuthUserStreamWidget(
                                                      builder: (context) =>
                                                          FFButtonWidget(
                                                        onPressed: () async {
                                                          await currentUserReference!
                                                              .update({
                                                            ...mapToFirestore(
                                                              {
                                                                'following':
                                                                    FieldValue
                                                                        .arrayRemove([
                                                                  columnFollowersUsersRecord
                                                                      .reference
                                                                ]),
                                                              },
                                                            ),
                                                          });
                                                          FFAppState()
                                                                  .FollowUnfollow =
                                                              random_data
                                                                  .randomInteger(
                                                                      3, 3);
                                                          safeSetState(() {});
                                                        },
                                                        text:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                          '1lb8cym9' /* UnFollow */,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          width: 100.0,
                                                          height: 30.0,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      16.0,
                                                                      0.0,
                                                                      16.0,
                                                                      0.0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'Inter',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    fontSize:
                                                                        14.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                          elevation: 0.0,
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryText,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      18.0),
                                                        ),
                                                        showLoadingIndicator:
                                                            false,
                                                      ),
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
                            Builder(
                              builder: (context) {
                                final following = followersFollowingUsersRecord
                                        ?.following
                                        ?.toList() ??
                                    [];

                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: List.generate(following.length,
                                      (followingIndex) {
                                    final followingItem =
                                        following[followingIndex];
                                    return StreamBuilder<List<UsersRecord>>(
                                      stream: queryUsersRecord(
                                        queryBuilder: (usersRecord) =>
                                            usersRecord.where(
                                          'uid',
                                          isEqualTo: followingItem.id,
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
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        List<UsersRecord>
                                            containerUsersRecordList =
                                            snapshot.data!;
                                        // Return an empty Container when the item does not exist.
                                        if (snapshot.data!.isEmpty) {
                                          return Container();
                                        }
                                        final containerUsersRecord =
                                            containerUsersRecordList.isNotEmpty
                                                ? containerUsersRecordList.first
                                                : null;

                                        return Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          height: 60.0,
                                          decoration: BoxDecoration(),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12.0, 0.0, 12.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    if (containerUsersRecord
                                                            ?.uid ==
                                                        currentUserUid) {
                                                      context.pushNamed(
                                                        MyProfileWidget
                                                            .routeName,
                                                        extra: <String,
                                                            dynamic>{
                                                          kTransitionInfoKey:
                                                              TransitionInfo(
                                                            hasTransition: true,
                                                            transitionType:
                                                                PageTransitionType
                                                                    .fade,
                                                            duration: Duration(
                                                                milliseconds:
                                                                    0),
                                                          ),
                                                        },
                                                      );
                                                    } else {
                                                      context.pushNamed(
                                                        UsersPageWidget
                                                            .routeName,
                                                        queryParameters: {
                                                          'user':
                                                              serializeParam(
                                                            containerUsersRecord
                                                                ?.uid,
                                                            ParamType.String,
                                                          ),
                                                        }.withoutNulls,
                                                        extra: <String,
                                                            dynamic>{
                                                          kTransitionInfoKey:
                                                              TransitionInfo(
                                                            hasTransition: true,
                                                            transitionType:
                                                                PageTransitionType
                                                                    .fade,
                                                            duration: Duration(
                                                                milliseconds:
                                                                    0),
                                                          ),
                                                        },
                                                      );
                                                    }
                                                  },
                                                  child: Container(
                                                    width: 60.0,
                                                    height: 60.0,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Image.network(
                                                      containerUsersRecord!
                                                          .photoUrl,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 0.0,
                                                                10.0, 0.0),
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        if (containerUsersRecord
                                                                ?.uid ==
                                                            currentUserUid) {
                                                          context.pushNamed(
                                                            MyProfileWidget
                                                                .routeName,
                                                            extra: <String,
                                                                dynamic>{
                                                              kTransitionInfoKey:
                                                                  TransitionInfo(
                                                                hasTransition:
                                                                    true,
                                                                transitionType:
                                                                    PageTransitionType
                                                                        .fade,
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        0),
                                                              ),
                                                            },
                                                          );
                                                        } else {
                                                          context.pushNamed(
                                                            UsersPageWidget
                                                                .routeName,
                                                            queryParameters: {
                                                              'user':
                                                                  serializeParam(
                                                                containerUsersRecord
                                                                    ?.uid,
                                                                ParamType
                                                                    .String,
                                                              ),
                                                            }.withoutNulls,
                                                            extra: <String,
                                                                dynamic>{
                                                              kTransitionInfoKey:
                                                                  TransitionInfo(
                                                                hasTransition:
                                                                    true,
                                                                transitionType:
                                                                    PageTransitionType
                                                                        .fade,
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        0),
                                                              ),
                                                            },
                                                          );
                                                        }
                                                      },
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Flexible(
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          6.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  containerUsersRecord
                                                                      ?.username,
                                                                  'UserName',
                                                                ),
                                                                maxLines: 1,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Inter',
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      lineHeight:
                                                                          1.0,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                          Flexible(
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          6.0),
                                                              child: Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  containerUsersRecord
                                                                      ?.displayName,
                                                                  'DisplayName',
                                                                ),
                                                                maxLines: 1,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Inter',
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.0,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                if ((currentUserDocument
                                                            ?.following
                                                            ?.toList() ??
                                                        [])
                                                    .contains(
                                                        containerUsersRecord
                                                            ?.reference))
                                                  AuthUserStreamWidget(
                                                    builder: (context) =>
                                                        FFButtonWidget(
                                                      onPressed: () async {
                                                        await currentUserReference!
                                                            .update({
                                                          ...mapToFirestore(
                                                            {
                                                              'following':
                                                                  FieldValue
                                                                      .arrayRemove([
                                                                containerUsersRecord
                                                                    ?.reference
                                                              ]),
                                                            },
                                                          ),
                                                        });
                                                        FFAppState()
                                                                .FollowUnfollow =
                                                            random_data
                                                                .randomInteger(
                                                                    3, 3);
                                                        safeSetState(() {});
                                                      },
                                                      text: FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'yjbqtadv' /* Unfollow */,
                                                      ),
                                                      options: FFButtonOptions(
                                                        width: 100.0,
                                                        height: 30.0,
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    16.0,
                                                                    0.0,
                                                                    16.0,
                                                                    0.0),
                                                        iconPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontSize:
                                                                      14.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                        elevation: 0.0,
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18.0),
                                                      ),
                                                      showLoadingIndicator:
                                                          false,
                                                    ),
                                                  ),
                                                if (!(currentUserDocument
                                                                ?.following
                                                                ?.toList() ??
                                                            [])
                                                        .contains(
                                                            containerUsersRecord
                                                                ?.reference) &&
                                                    (containerUsersRecord
                                                            ?.uid !=
                                                        currentUserUid))
                                                  AuthUserStreamWidget(
                                                    builder: (context) =>
                                                        FFButtonWidget(
                                                      onPressed: () async {
                                                        await currentUserReference!
                                                            .update({
                                                          ...mapToFirestore(
                                                            {
                                                              'following':
                                                                  FieldValue
                                                                      .arrayUnion([
                                                                containerUsersRecord
                                                                    ?.reference
                                                              ]),
                                                            },
                                                          ),
                                                        });
                                                        FFAppState()
                                                                .FollowUnfollow =
                                                            random_data
                                                                .randomInteger(
                                                                    3, 3);
                                                        safeSetState(() {});
                                                      },
                                                      text: FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'pdn42u74' /* Follow */,
                                                      ),
                                                      options: FFButtonOptions(
                                                        width: 100.0,
                                                        height: 30.0,
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    16.0,
                                                                    0.0,
                                                                    16.0,
                                                                    0.0),
                                                        iconPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontSize:
                                                                      14.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                        elevation: 0.0,
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18.0),
                                                      ),
                                                      showLoadingIndicator:
                                                          false,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }),
                                );
                              },
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
        );
      },
    );
  }
}
