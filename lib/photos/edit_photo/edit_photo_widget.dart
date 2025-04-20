import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'edit_photo_model.dart';
export 'edit_photo_model.dart';

class EditPhotoWidget extends StatefulWidget {
  const EditPhotoWidget({super.key});

  @override
  State<EditPhotoWidget> createState() => _EditPhotoWidgetState();
}

class _EditPhotoWidgetState extends State<EditPhotoWidget> {
  late EditPhotoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditPhotoModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 210.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 5.0,
            color: Color(0x3B1D2429),
            offset: Offset(
              0.0,
              -3.0,
            ),
          )
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            FFButtonWidget(
              onPressed: () async {
                final selectedMedia = await selectMediaWithSourceBottomSheet(
                  context: context,
                  allowPhoto: true,
                );
                if (selectedMedia != null &&
                    selectedMedia.every(
                        (m) => validateFileFormat(m.storagePath, context))) {
                  safeSetState(() => _model.isDataUploading = true);
                  var selectedUploadedFiles = <FFUploadedFile>[];

                  var downloadUrls = <String>[];
                  try {
                    selectedUploadedFiles = selectedMedia
                        .map((m) => FFUploadedFile(
                              name: m.storagePath.split('/').last,
                              bytes: m.bytes,
                              height: m.dimensions?.height,
                              width: m.dimensions?.width,
                              blurHash: m.blurHash,
                            ))
                        .toList();

                    downloadUrls = (await Future.wait(
                      selectedMedia.map(
                        (m) async => await uploadData(m.storagePath, m.bytes),
                      ),
                    ))
                        .where((u) => u != null)
                        .map((u) => u!)
                        .toList();
                  } finally {
                    _model.isDataUploading = false;
                  }
                  if (selectedUploadedFiles.length == selectedMedia.length &&
                      downloadUrls.length == selectedMedia.length) {
                    safeSetState(() {
                      _model.uploadedLocalFile = selectedUploadedFiles.first;
                      _model.uploadedFileUrl = downloadUrls.first;
                    });
                  } else {
                    safeSetState(() {});
                    return;
                  }
                }

                FFAppState().UserPhoto = _model.uploadedFileUrl;
                safeSetState(() {});
                Navigator.pop(context);
              },
              text: FFLocalizations.of(context).getText(
                'yso0v1bk' /* 上传图片 */,
              ),
              options: FFButtonOptions(
                width: double.infinity,
                height: 60.0,
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: Color(0xFFE7DFDF),
                textStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                      fontFamily: 'Inter',
                      letterSpacing: 0.0,
                    ),
                elevation: 2.0,
                borderSide: BorderSide(
                  color: Color(0xFF8B660F),
                  width: 3.0,
                ),
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
              child: FFButtonWidget(
                onPressed: () async {
                  FFAppState().UserPhoto =
                      'https://firebasestorage.googleapis.com/v0/b/ingo-brillate-ins-app.appspot.com/o/user-profile-icon.jpg?alt=media&token=3991f4ee-30ae-48f0-8675-040a5eb01870';
                  safeSetState(() {});
                  Navigator.pop(context);
                },
                text: FFLocalizations.of(context).getText(
                  '8aou04k2' /* 删除图片 */,
                ),
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 60.0,
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: Color(0xFFE7DFDF),
                  textStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                        fontFamily: 'Plus Jakarta Sans',
                        color: Color(0xFF14181B),
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.normal,
                      ),
                  elevation: 2.0,
                  borderSide: BorderSide(
                    color: Color(0xFF8B660F),
                    width: 3.0,
                  ),
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
