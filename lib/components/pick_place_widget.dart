import '/flutter_flow/flutter_flow_place_picker.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/place.dart';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'pick_place_model.dart';
export 'pick_place_model.dart';

class PickPlaceWidget extends StatefulWidget {
  const PickPlaceWidget({super.key});

  @override
  State<PickPlaceWidget> createState() => _PickPlaceWidgetState();
}

class _PickPlaceWidgetState extends State<PickPlaceWidget> {
  late PickPlaceModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PickPlaceModel());
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
      height: 270.0,
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
            FlutterFlowPlacePicker(
              iOSGoogleMapsApiKey: 'AIzaSyBEO402DStvoKJHM4KOYfK9he_ccqgusUw',
              androidGoogleMapsApiKey:
                  'AIzaSyBsA1cmSGZZATrvGc-c6rvi__mArHhcQUc',
              webGoogleMapsApiKey: 'AIzaSyD-OB7rTTCKCKty3YhNHA2GaQ8akN8001E',
              onSelect: (place) async {
                safeSetState(() => _model.placePickerValue = place);
              },
              defaultText: FFLocalizations.of(context).getText(
                'jtawi16p' /* 选择所在地 */,
              ),
              icon: Icon(
                Icons.place_outlined,
                color: FlutterFlowTheme.of(context).info,
                size: 16.0,
              ),
              buttonOptions: FFButtonOptions(
                width: 200.0,
                height: 40.0,
                color: Color(0xFF8B660F),
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: 'Inter',
                      color: FlutterFlowTheme.of(context).info,
                      letterSpacing: 0.0,
                    ),
                elevation: 0.0,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    valueOrDefault<String>(
                      _model.placePickerValue.address,
                      '所在地',
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Inter',
                          letterSpacing: 0.0,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
              child: FFButtonWidget(
                onPressed: () async {
                  FFAppState().Location = _model.placePickerValue.address;
                  safeSetState(() {});
                  Navigator.pop(context, _model.placePickerValue.latLng);
                },
                text: FFLocalizations.of(context).getText(
                  'h8liz113' /* 确认 */,
                ),
                options: FFButtonOptions(
                  width: 120.0,
                  height: 40.0,
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).secondaryText,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Inter',
                        color: Colors.white,
                        letterSpacing: 0.0,
                      ),
                  elevation: 1.0,
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
