import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'log_in_model.dart';
export 'log_in_model.dart';

class LogInWidget extends StatefulWidget {
  const LogInWidget({super.key});

  @override
  State<LogInWidget> createState() => _LogInWidgetState();
}

class _LogInWidgetState extends State<LogInWidget> {
  late LogInModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LogInModel());

    _model.textFieldEmailTextController ??= TextEditingController();
    _model.textFieldEmailFocusNode ??= FocusNode();

    _model.textFieldPasswordTextController ??= TextEditingController();
    _model.textFieldPasswordFocusNode ??= FocusNode();
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
      height: 300.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
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
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  FFLocalizations.of(context).getText(
                    '4b9jca5z' /* 输入您的账户信息 */,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Roboto',
                        fontSize: 18.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
            child: TextFormField(
              controller: _model.textFieldEmailTextController,
              focusNode: _model.textFieldEmailFocusNode,
              onFieldSubmitted: (_) async {
                GoRouter.of(context).prepareAuthEvent();

                final user = await authManager.signInWithEmail(
                  context,
                  _model.textFieldEmailTextController.text,
                  _model.textFieldPasswordTextController.text,
                );
                if (user == null) {
                  return;
                }

                context.goNamedAuth(HomeWidget.routeName, context.mounted);
              },
              autofocus: true,
              obscureText: false,
              decoration: InputDecoration(
                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily: 'Inter',
                      letterSpacing: 0.0,
                    ),
                hintText: FFLocalizations.of(context).getText(
                  '9z8tu85e' /* 电子邮箱 */,
                ),
                hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily: 'Inter',
                      letterSpacing: 0.0,
                    ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF8B660F),
                    width: 3.0,
                  ),
                  borderRadius: BorderRadius.circular(18.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF8B660F),
                    width: 3.0,
                  ),
                  borderRadius: BorderRadius.circular(18.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).error,
                    width: 3.0,
                  ),
                  borderRadius: BorderRadius.circular(18.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).error,
                    width: 3.0,
                  ),
                  borderRadius: BorderRadius.circular(18.0),
                ),
                filled: true,
                fillColor: Color(0xFFE7DFDF),
                prefixIcon: Icon(
                  Icons.email,
                ),
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Inter',
                    letterSpacing: 0.0,
                  ),
              keyboardType: TextInputType.emailAddress,
              validator: _model.textFieldEmailTextControllerValidator
                  .asValidator(context),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
            child: TextFormField(
              controller: _model.textFieldPasswordTextController,
              focusNode: _model.textFieldPasswordFocusNode,
              autofocus: true,
              obscureText: !_model.textFieldPasswordVisibility,
              decoration: InputDecoration(
                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily: 'Inter',
                      letterSpacing: 0.0,
                    ),
                hintText: FFLocalizations.of(context).getText(
                  '388x77vu' /* 密码 */,
                ),
                hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily: 'Inter',
                      letterSpacing: 0.0,
                    ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF8B660F),
                    width: 3.0,
                  ),
                  borderRadius: BorderRadius.circular(18.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF8B660F),
                    width: 3.0,
                  ),
                  borderRadius: BorderRadius.circular(18.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).error,
                    width: 3.0,
                  ),
                  borderRadius: BorderRadius.circular(18.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).error,
                    width: 3.0,
                  ),
                  borderRadius: BorderRadius.circular(18.0),
                ),
                filled: true,
                fillColor: Color(0xFFE7DFDF),
                suffixIcon: InkWell(
                  onTap: () => safeSetState(
                    () => _model.textFieldPasswordVisibility =
                        !_model.textFieldPasswordVisibility,
                  ),
                  focusNode: FocusNode(skipTraversal: true),
                  child: Icon(
                    _model.textFieldPasswordVisibility
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 30.0,
                  ),
                ),
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Inter',
                    letterSpacing: 0.0,
                  ),
              validator: _model.textFieldPasswordTextControllerValidator
                  .asValidator(context),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
            child: FFButtonWidget(
              onPressed: () async {
                GoRouter.of(context).prepareAuthEvent();

                final user = await authManager.signInWithEmail(
                  context,
                  _model.textFieldEmailTextController.text,
                  _model.textFieldPasswordTextController.text,
                );
                if (user == null) {
                  return;
                }

                context.goNamedAuth(HomeWidget.routeName, context.mounted);
              },
              text: FFLocalizations.of(context).getText(
                'q9tf4jlf' /* 点击登录 */,
              ),
              options: FFButtonOptions(
                width: 120.0,
                height: 40.0,
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: Color(0xFF8B660F),
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: 'Inter',
                      color: Colors.white,
                      letterSpacing: 0.0,
                    ),
                elevation: 2.0,
                borderSide: BorderSide(
                  color: Color(0xFF8B660F),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                if (_model.textFieldEmailTextController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        FFLocalizations.of(context).getText(
                          'f4ljuys3' /* 请填写电子邮箱！ */,
                        ),
                      ),
                    ),
                  );
                  return;
                }
                await authManager.resetPassword(
                  email: _model.textFieldEmailTextController.text,
                  context: context,
                );
                Navigator.pop(context);
              },
              child: Text(
                FFLocalizations.of(context).getText(
                  '6ic9bt5b' /* 忘记密码？ */,
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Roboto',
                      color: FlutterFlowTheme.of(context).secondaryText,
                      fontSize: 12.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
