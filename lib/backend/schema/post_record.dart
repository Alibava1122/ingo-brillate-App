import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PostRecord extends FirestoreRecord {
  PostRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "username" field.
  String? _username;
  String get username => _username ?? '';
  bool hasUsername() => _username != null;

  // "photos" field.
  List<String>? _photos;
  List<String> get photos => _photos ?? const [];
  bool hasPhotos() => _photos != null;

  // "time" field.
  DateTime? _time;
  DateTime? get time => _time;
  bool hasTime() => _time != null;

  // "code_ref" field.
  String? _codeRef;
  String get codeRef => _codeRef ?? '';
  bool hasCodeRef() => _codeRef != null;

  // "likes_users" field.
  List<DocumentReference>? _likesUsers;
  List<DocumentReference> get likesUsers => _likesUsers ?? const [];
  bool hasLikesUsers() => _likesUsers != null;

  // "likes_number" field.
  int? _likesNumber;
  int get likesNumber => _likesNumber ?? 0;
  bool hasLikesNumber() => _likesNumber != null;

  // "userID" field.
  String? _userID;
  String get userID => _userID ?? '';
  bool hasUserID() => _userID != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "bookmark_users" field.
  List<DocumentReference>? _bookmarkUsers;
  List<DocumentReference> get bookmarkUsers => _bookmarkUsers ?? const [];
  bool hasBookmarkUsers() => _bookmarkUsers != null;

  // "location_address" field.
  String? _locationAddress;
  String get locationAddress => _locationAddress ?? '';
  bool hasLocationAddress() => _locationAddress != null;

  // "location_LatLng" field.
  LatLng? _locationLatLng;
  LatLng? get locationLatLng => _locationLatLng;
  bool hasLocationLatLng() => _locationLatLng != null;

  void _initializeFields() {
    _username = snapshotData['username'] as String?;
    _photos = getDataList(snapshotData['photos']);
    _time = snapshotData['time'] as DateTime?;
    _codeRef = snapshotData['code_ref'] as String?;
    _likesUsers = getDataList(snapshotData['likes_users']);
    _likesNumber = castToType<int>(snapshotData['likes_number']);
    _userID = snapshotData['userID'] as String?;
    _description = snapshotData['description'] as String?;
    _bookmarkUsers = getDataList(snapshotData['bookmark_users']);
    _locationAddress = snapshotData['location_address'] as String?;
    _locationLatLng = snapshotData['location_LatLng'] as LatLng?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('post');

  static Stream<PostRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PostRecord.fromSnapshot(s));

  static Future<PostRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PostRecord.fromSnapshot(s));

  static PostRecord fromSnapshot(DocumentSnapshot snapshot) => PostRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PostRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PostRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PostRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PostRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPostRecordData({
  String? username,
  DateTime? time,
  String? codeRef,
  int? likesNumber,
  String? userID,
  String? description,
  String? locationAddress,
  LatLng? locationLatLng,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'username': username,
      'time': time,
      'code_ref': codeRef,
      'likes_number': likesNumber,
      'userID': userID,
      'description': description,
      'location_address': locationAddress,
      'location_LatLng': locationLatLng,
    }.withoutNulls,
  );

  return firestoreData;
}

class PostRecordDocumentEquality implements Equality<PostRecord> {
  const PostRecordDocumentEquality();

  @override
  bool equals(PostRecord? e1, PostRecord? e2) {
    const listEquality = ListEquality();
    return e1?.username == e2?.username &&
        listEquality.equals(e1?.photos, e2?.photos) &&
        e1?.time == e2?.time &&
        e1?.codeRef == e2?.codeRef &&
        listEquality.equals(e1?.likesUsers, e2?.likesUsers) &&
        e1?.likesNumber == e2?.likesNumber &&
        e1?.userID == e2?.userID &&
        e1?.description == e2?.description &&
        listEquality.equals(e1?.bookmarkUsers, e2?.bookmarkUsers) &&
        e1?.locationAddress == e2?.locationAddress &&
        e1?.locationLatLng == e2?.locationLatLng;
  }

  @override
  int hash(PostRecord? e) => const ListEquality().hash([
        e?.username,
        e?.photos,
        e?.time,
        e?.codeRef,
        e?.likesUsers,
        e?.likesNumber,
        e?.userID,
        e?.description,
        e?.bookmarkUsers,
        e?.locationAddress,
        e?.locationLatLng
      ]);

  @override
  bool isValidKey(Object? o) => o is PostRecord;
}
