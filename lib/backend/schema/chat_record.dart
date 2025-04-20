import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatRecord extends FirestoreRecord {
  ChatRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "chatID" field.
  String? _chatID;
  String get chatID => _chatID ?? '';
  bool hasChatID() => _chatID != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "user_a" field.
  String? _userA;
  String get userA => _userA ?? '';
  bool hasUserA() => _userA != null;

  // "user_b" field.
  String? _userB;
  String get userB => _userB ?? '';
  bool hasUserB() => _userB != null;

  // "last_message" field.
  String? _lastMessage;
  String get lastMessage => _lastMessage ?? '';
  bool hasLastMessage() => _lastMessage != null;

  // "lasta_message_time" field.
  DateTime? _lastaMessageTime;
  DateTime? get lastaMessageTime => _lastaMessageTime;
  bool hasLastaMessageTime() => _lastaMessageTime != null;

  void _initializeFields() {
    _chatID = snapshotData['chatID'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _userA = snapshotData['user_a'] as String?;
    _userB = snapshotData['user_b'] as String?;
    _lastMessage = snapshotData['last_message'] as String?;
    _lastaMessageTime = snapshotData['lasta_message_time'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('chat');

  static Stream<ChatRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ChatRecord.fromSnapshot(s));

  static Future<ChatRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ChatRecord.fromSnapshot(s));

  static ChatRecord fromSnapshot(DocumentSnapshot snapshot) => ChatRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ChatRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ChatRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ChatRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ChatRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createChatRecordData({
  String? chatID,
  DateTime? createdTime,
  String? userA,
  String? userB,
  String? lastMessage,
  DateTime? lastaMessageTime,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'chatID': chatID,
      'created_time': createdTime,
      'user_a': userA,
      'user_b': userB,
      'last_message': lastMessage,
      'lasta_message_time': lastaMessageTime,
    }.withoutNulls,
  );

  return firestoreData;
}

class ChatRecordDocumentEquality implements Equality<ChatRecord> {
  const ChatRecordDocumentEquality();

  @override
  bool equals(ChatRecord? e1, ChatRecord? e2) {
    return e1?.chatID == e2?.chatID &&
        e1?.createdTime == e2?.createdTime &&
        e1?.userA == e2?.userA &&
        e1?.userB == e2?.userB &&
        e1?.lastMessage == e2?.lastMessage &&
        e1?.lastaMessageTime == e2?.lastaMessageTime;
  }

  @override
  int hash(ChatRecord? e) => const ListEquality().hash([
        e?.chatID,
        e?.createdTime,
        e?.userA,
        e?.userB,
        e?.lastMessage,
        e?.lastaMessageTime
      ]);

  @override
  bool isValidKey(Object? o) => o is ChatRecord;
}
