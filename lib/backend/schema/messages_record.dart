import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MessagesRecord extends FirestoreRecord {
  MessagesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "chat_ID" field.
  String? _chatID;
  String get chatID => _chatID ?? '';
  bool hasChatID() => _chatID != null;

  // "userID" field.
  String? _userID;
  String get userID => _userID ?? '';
  bool hasUserID() => _userID != null;

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  bool hasText() => _text != null;

  // "images" field.
  List<String>? _images;
  List<String> get images => _images ?? const [];
  bool hasImages() => _images != null;

  // "current_time" field.
  DateTime? _currentTime;
  DateTime? get currentTime => _currentTime;
  bool hasCurrentTime() => _currentTime != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  void _initializeFields() {
    _chatID = snapshotData['chat_ID'] as String?;
    _userID = snapshotData['userID'] as String?;
    _text = snapshotData['text'] as String?;
    _images = getDataList(snapshotData['images']);
    _currentTime = snapshotData['current_time'] as DateTime?;
    _type = snapshotData['type'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('messages');

  static Stream<MessagesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MessagesRecord.fromSnapshot(s));

  static Future<MessagesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MessagesRecord.fromSnapshot(s));

  static MessagesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MessagesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MessagesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MessagesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MessagesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MessagesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMessagesRecordData({
  String? chatID,
  String? userID,
  String? text,
  DateTime? currentTime,
  String? type,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'chat_ID': chatID,
      'userID': userID,
      'text': text,
      'current_time': currentTime,
      'type': type,
    }.withoutNulls,
  );

  return firestoreData;
}

class MessagesRecordDocumentEquality implements Equality<MessagesRecord> {
  const MessagesRecordDocumentEquality();

  @override
  bool equals(MessagesRecord? e1, MessagesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.chatID == e2?.chatID &&
        e1?.userID == e2?.userID &&
        e1?.text == e2?.text &&
        listEquality.equals(e1?.images, e2?.images) &&
        e1?.currentTime == e2?.currentTime &&
        e1?.type == e2?.type;
  }

  @override
  int hash(MessagesRecord? e) => const ListEquality().hash(
      [e?.chatID, e?.userID, e?.text, e?.images, e?.currentTime, e?.type]);

  @override
  bool isValidKey(Object? o) => o is MessagesRecord;
}
