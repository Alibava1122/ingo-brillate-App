import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/comments_widget.dart';
import '/components/google_map_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'user_post_model.dart';
export 'user_post_model.dart';

///
class UserPostWidget extends StatefulWidget {
  const UserPostWidget({
    super.key,
    required this.codeRef,
  });

  final String? codeRef;

  static String routeName = 'User_post';
  static String routePath = '/userPost';

  @override
  State<UserPostWidget> createState() => _UserPostWidgetState();
}

class _UserPostWidgetState extends State<UserPostWidget>
    with TickerProviderStateMixin {
  late UserPostModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserPostModel());

    animationsMap.addAll({
      'iconOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          ScaleEffect(
            curve: Curves.bounceOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.0, 0.0),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
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
        body: StreamBuilder<List<PostRecord>>(
          stream: queryPostRecord(
            queryBuilder: (postRecord) => postRecord.where(
              'code_ref',
              isEqualTo: widget!.codeRef,
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
            List<PostRecord> columnPostRecordList = snapshot.data!;
            // Return an empty Container when the item does not exist.
            if (snapshot.data!.isEmpty) {
              return Container();
            }
            final columnPostRecord = columnPostRecordList.isNotEmpty
                ? columnPostRecordList.first
                : null;

            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                      child: InkWell(
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
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          functions.mayus(columnPostRecord?.username)!,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    color: Color(0xFF8B660F),
                                    letterSpacing: 0.0,
                                  ),
                        ),
                        Text(
                          FFLocalizations.of(context).getText(
                            'wdz6y1uv' /* 帖子 */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    color: Color(0xFF8B660F),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                      child: FaIcon(
                        FontAwesomeIcons.solidArrowAltCircleLeft,
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        size: 24.0,
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 2.0,
                  color: Color(0xFF8B660F),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 6.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: StreamBuilder<List<UsersRecord>>(
                          stream: queryUsersRecord(
                            queryBuilder: (usersRecord) => usersRecord.where(
                              'uid',
                              isEqualTo: columnPostRecord?.userID,
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
                                      FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                  ),
                                ),
                              );
                            }
                            List<UsersRecord> rowUsersRecordList =
                                snapshot.data!;
                            // Return an empty Container when the item does not exist.
                            if (snapshot.data!.isEmpty) {
                              return Container();
                            }
                            final rowUsersRecord = rowUsersRecordList.isNotEmpty
                                ? rowUsersRecordList.first
                                : null;

                            return Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 0.0, 12.0, 0.0),
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
                                      width: 36.0,
                                      height: 36.0,
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
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      valueOrDefault<String>(
                                        columnPostRecord?.username,
                                        '用户名',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    InkWell(
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
                                                child: GoogleMapWidget(
                                                  latLng: columnPostRecord!
                                                      .locationLatLng!,
                                                ),
                                              ),
                                            );
                                          },
                                        ).then((value) => safeSetState(() {}));
                                      },
                                      child: Text(
                                        valueOrDefault<String>(
                                          columnPostRecord?.locationAddress,
                                          '所在地',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
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
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                        child: Icon(
                          Icons.keyboard_control,
                          color: Color(0xFF8B660F),
                          size: 28.0,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onDoubleTap: () async {
                    await columnPostRecord!.reference.update({
                      ...mapToFirestore(
                        {
                          'likes_users':
                              FieldValue.arrayUnion([currentUserReference]),
                        },
                      ),
                    });
                  },
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            if (columnPostRecord?.photos?.length != 1)
                              Builder(
                                builder: (context) {
                                  final pages =
                                      columnPostRecord?.photos?.toList() ?? [];

                                  return Container(
                                    height: 380.0,
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 30.0),
                                          child: PageView.builder(
                                            controller: _model
                                                    .pageViewController ??=
                                                PageController(
                                                    initialPage: max(
                                                        0,
                                                        min(0,
                                                            pages.length - 1))),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: pages.length,
                                            itemBuilder: (context, pagesIndex) {
                                              final pagesItem =
                                                  pages[pagesIndex];
                                              return Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 12.0, 0.0, 0.0),
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
                                                    await Navigator.push(
                                                      context,
                                                      PageTransition(
                                                        type: PageTransitionType
                                                            .fade,
                                                        child:
                                                            FlutterFlowExpandedImageView(
                                                          image: Image.network(
                                                            pagesItem,
                                                            fit: BoxFit.contain,
                                                          ),
                                                          allowRotation: false,
                                                          tag: pagesItem,
                                                          useHeroAnimation:
                                                              true,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  onDoubleTap: () async {
                                                    if (animationsMap[
                                                            'iconOnActionTriggerAnimation'] !=
                                                        null) {
                                                      await animationsMap[
                                                              'iconOnActionTriggerAnimation']!
                                                          .controller
                                                          .forward(from: 0.0);
                                                    }
                                                    if (animationsMap[
                                                            'iconOnActionTriggerAnimation'] !=
                                                        null) {
                                                      animationsMap[
                                                              'iconOnActionTriggerAnimation']!
                                                          .controller
                                                          .stop();
                                                    }
                                                    if (animationsMap[
                                                            'iconOnActionTriggerAnimation'] !=
                                                        null) {
                                                      animationsMap[
                                                              'iconOnActionTriggerAnimation']!
                                                          .controller
                                                          .reset();
                                                    }

                                                    await columnPostRecord!
                                                        .reference
                                                        .update({
                                                      ...mapToFirestore(
                                                        {
                                                          'likes_users':
                                                              FieldValue
                                                                  .arrayUnion([
                                                            currentUserReference
                                                          ]),
                                                        },
                                                      ),
                                                    });
                                                  },
                                                  child: Hero(
                                                    tag: pagesItem,
                                                    transitionOnUserGestures:
                                                        true,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.0),
                                                      child: Image.network(
                                                        pagesItem,
                                                        width: 300.0,
                                                        height: 200.0,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 1.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            child: smooth_page_indicator
                                                .SmoothPageIndicator(
                                              controller:
                                                  _model.pageViewController ??=
                                                      PageController(
                                                          initialPage: max(
                                                              0,
                                                              min(
                                                                  0,
                                                                  pages.length -
                                                                      1))),
                                              count: pages.length,
                                              axisDirection: Axis.horizontal,
                                              onDotClicked: (i) async {
                                                await _model.pageViewController!
                                                    .animateToPage(
                                                  i,
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.ease,
                                                );
                                                safeSetState(() {});
                                              },
                                              effect: smooth_page_indicator
                                                  .SlideEffect(
                                                spacing: 4.0,
                                                radius: 18.0,
                                                dotWidth: 16.0,
                                                dotHeight: 16.0,
                                                dotColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                activeDotColor:
                                                    Color(0xFF8B660F),
                                                paintStyle: PaintingStyle.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            if (columnPostRecord?.photos?.length == 1)
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
                                          columnPostRecord!.photos.firstOrNull!,
                                          fit: BoxFit.contain,
                                        ),
                                        allowRotation: false,
                                        tag: columnPostRecord!
                                            .photos.firstOrNull!,
                                        useHeroAnimation: true,
                                      ),
                                    ),
                                  );
                                },
                                onDoubleTap: () async {
                                  await columnPostRecord!.reference.update({
                                    ...mapToFirestore(
                                      {
                                        'likes_users': FieldValue.arrayUnion(
                                            [currentUserReference]),
                                      },
                                    ),
                                  });
                                },
                                child: Hero(
                                  tag: columnPostRecord!.photos.firstOrNull!,
                                  transitionOnUserGestures: true,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(18.0),
                                    child: Image.network(
                                      columnPostRecord!.photos.firstOrNull!,
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      height: 350.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 358.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 0.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  if (!columnPostRecord!.likesUsers
                                      .contains(currentUserReference))
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        await columnPostRecord!.reference
                                            .update({
                                          ...mapToFirestore(
                                            {
                                              'likes_users':
                                                  FieldValue.arrayUnion(
                                                      [currentUserReference]),
                                            },
                                          ),
                                        });
                                      },
                                      child: Icon(
                                        Icons.favorite_border,
                                        color: Color(0xFF8B660F),
                                        size: 28.0,
                                      ),
                                    ),
                                  if (columnPostRecord?.likesUsers
                                          ?.contains(currentUserReference) ??
                                      true)
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        await columnPostRecord!.reference
                                            .update({
                                          ...mapToFirestore(
                                            {
                                              'likes_users':
                                                  FieldValue.arrayRemove(
                                                      [currentUserReference]),
                                            },
                                          ),
                                        });
                                      },
                                      child: Icon(
                                        Icons.favorite,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 28.0,
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
                                        FFAppState().CommentIsAnswer = false;
                                        safeSetState(() {});
                                        FFAppState().AnswerUsername =
                                            'default1234';
                                        safeSetState(() {});
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
                                                child: Container(
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.6,
                                                  child: CommentsWidget(
                                                    postid: columnPostRecord!
                                                        .codeRef,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ).then((value) => safeSetState(() {}));
                                      },
                                      child: FaIcon(
                                        FontAwesomeIcons.comment,
                                        color: Color(0xFF8B660F),
                                        size: 24.0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 0.0, 0.0, 0.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.paperPlane,
                                      color: Color(0xFF8B660F),
                                      size: 24.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                if (!columnPostRecord!.bookmarkUsers
                                    .contains(currentUserReference))
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 12.0, 0.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        await columnPostRecord!.reference
                                            .update({
                                          ...mapToFirestore(
                                            {
                                              'bookmark_users':
                                                  FieldValue.arrayUnion(
                                                      [currentUserReference]),
                                            },
                                          ),
                                        });
                                      },
                                      child: FaIcon(
                                        FontAwesomeIcons.bookmark,
                                        color: Color(0xFF8B660F),
                                        size: 24.0,
                                      ),
                                    ),
                                  ),
                                if (columnPostRecord?.bookmarkUsers
                                        ?.contains(currentUserReference) ??
                                    true)
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 12.0, 0.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        await columnPostRecord!.reference
                                            .update({
                                          ...mapToFirestore(
                                            {
                                              'bookmark_users':
                                                  FieldValue.arrayRemove(
                                                      [currentUserReference]),
                                            },
                                          ),
                                        });
                                      },
                                      child: FaIcon(
                                        FontAwesomeIcons.solidBookmark,
                                        color: Color(0xFF8B660F),
                                        size: 24.0,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 140.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 60.0,
                            ).animateOnActionTrigger(
                              animationsMap['iconOnActionTriggerAnimation']!,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        child: RichText(
                          textScaler: MediaQuery.of(context).textScaler,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: columnPostRecord!.username,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              TextSpan(
                                text: FFLocalizations.of(context).getText(
                                  'cyp7z2gs' /*    */,
                                ),
                                style: TextStyle(),
                              ),
                              TextSpan(
                                text: columnPostRecord!.description,
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              )
                            ],
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 12.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          '7nz0rvd3' /* 发布日期 */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              letterSpacing: 0.0,
                            ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                        child: Text(
                          dateTimeFormat(
                            "d/M/y",
                            columnPostRecord!.time!,
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 0.0, 12.0),
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
                              FocusScope.of(context).unfocus();
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            child: Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: Container(
                                height: MediaQuery.sizeOf(context).height * 0.6,
                                child: CommentsWidget(
                                  postid: columnPostRecord!.codeRef,
                                ),
                              ),
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          FFLocalizations.of(context).getText(
                            '4sljc331' /* 查看 */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              6.0, 0.0, 0.0, 0.0),
                          child: FutureBuilder<int>(
                            future: queryCommentsRecordCount(
                              queryBuilder: (commentsRecord) =>
                                  commentsRecord.where(
                                'postid',
                                isEqualTo: columnPostRecord?.codeRef,
                              ),
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
                              int textCount = snapshot.data!;

                              return Text(
                                textCount.toString(),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              6.0, 0.0, 0.0, 0.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'zepw9bsr' /* 条评论 */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                  child: StreamBuilder<List<CommentsRecord>>(
                    stream: queryCommentsRecord(
                      queryBuilder: (commentsRecord) => commentsRecord
                          .where(
                            'postid',
                            isEqualTo: columnPostRecord?.codeRef,
                          )
                          .orderBy('date_time', descending: true),
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
                                FlutterFlowTheme.of(context).primaryBackground,
                              ),
                            ),
                          ),
                        );
                      }
                      List<CommentsRecord> rowCommentsRecordList =
                          snapshot.data!;
                      // Return an empty Container when the item does not exist.
                      if (snapshot.data!.isEmpty) {
                        return Container();
                      }
                      final rowCommentsRecord = rowCommentsRecordList.isNotEmpty
                          ? rowCommentsRecordList.first
                          : null;

                      return Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                            ),
                            child: StreamBuilder<List<UsersRecord>>(
                              stream: queryUsersRecord(
                                queryBuilder: (usersRecord) =>
                                    usersRecord.where(
                                  'uid',
                                  isEqualTo: rowCommentsRecord?.userID,
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
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          FlutterFlowTheme.of(context).primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                List<UsersRecord> circleImageUsersRecordList =
                                    snapshot.data!;
                                // Return an empty Container when the item does not exist.
                                if (snapshot.data!.isEmpty) {
                                  return Container();
                                }
                                final circleImageUsersRecord =
                                    circleImageUsersRecordList.isNotEmpty
                                        ? circleImageUsersRecordList.first
                                        : null;

                                return Container(
                                  width: 200.0,
                                  height: 200.0,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    circleImageUsersRecord!.photoUrl,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: StreamBuilder<List<UsersRecord>>(
                              stream: queryUsersRecord(
                                queryBuilder: (usersRecord) =>
                                    usersRecord.where(
                                  'uid',
                                  isEqualTo: rowCommentsRecord?.userID,
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
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          FlutterFlowTheme.of(context).primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                List<UsersRecord> textUsersRecordList =
                                    snapshot.data!;
                                // Return an empty Container when the item does not exist.
                                if (snapshot.data!.isEmpty) {
                                  return Container();
                                }
                                final textUsersRecord =
                                    textUsersRecordList.isNotEmpty
                                        ? textUsersRecordList.first
                                        : null;

                                return Text(
                                  textUsersRecord!.username,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: Text(
                              rowCommentsRecord!.text,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
