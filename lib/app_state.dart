import 'package:flutter/material.dart';
import '/backend/backend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  String _UserPhoto = '';
  String get UserPhoto => _UserPhoto;
  set UserPhoto(String value) {
    _UserPhoto = value;
  }

  List<String> _SelectePhotos = [];
  List<String> get SelectePhotos => _SelectePhotos;
  set SelectePhotos(List<String> value) {
    _SelectePhotos = value;
  }

  void addToSelectePhotos(String value) {
    SelectePhotos.add(value);
  }

  void removeFromSelectePhotos(String value) {
    SelectePhotos.remove(value);
  }

  void removeAtIndexFromSelectePhotos(int index) {
    SelectePhotos.removeAt(index);
  }

  void updateSelectePhotosAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    SelectePhotos[index] = updateFn(_SelectePhotos[index]);
  }

  void insertAtIndexInSelectePhotos(int index, String value) {
    SelectePhotos.insert(index, value);
  }

  int _FollowUnfollow = 0;
  int get FollowUnfollow => _FollowUnfollow;
  set FollowUnfollow(int value) {
    _FollowUnfollow = value;
  }

  bool _CommentIsAnswer = false;
  bool get CommentIsAnswer => _CommentIsAnswer;
  set CommentIsAnswer(bool value) {
    _CommentIsAnswer = value;
  }

  String _AnswerUsername = '';
  String get AnswerUsername => _AnswerUsername;
  set AnswerUsername(String value) {
    _AnswerUsername = value;
  }

  String _Location = '';
  String get Location => _Location;
  set Location(String value) {
    _Location = value;
  }
}
