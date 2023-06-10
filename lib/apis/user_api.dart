import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '/constants/constants.dart';
import '/core/core.dart';
import '/models/user_model.dart';

final userApiProvider = Provider((ref) {
  return UserAPI(db: ref.watch(appwriteDatabaseProvider));
});

abstract class IUserAPI {
  FutureEitherVoid saveUserData(UserModel userModel);
  Future<model.Document> getUserData(String uid);
}

class UserAPI implements IUserAPI {
  final Databases _db;
  UserAPI({
    required this._db,
  }) : _db = db;

  @override
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try {
      await _db.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.usersCollection,
        documentId: userModel.uid,
        data: userModel.toMap(),
      );
      return right(null);
    } on AppwriteException catch (e, stackTrace) {
      return left(Failure(e.message ?? 'Some unexpected error', stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }

  UserAPI copyWith({
    Databases? _db,
  }) {
    return UserAPI(
      _db: _db ?? this._db,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'_db': _db.toMap()});
  
    return result;
  }

  factory UserAPI.fromMap(Map<String, dynamic> map) {
    return UserAPI(
      _db: Databases.fromMap(map['_db']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAPI.fromJson(String source) => UserAPI.fromMap(json.decode(source));

  @override
  String toString() => 'UserAPI(_db: $_db)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserAPI &&
      other._db == _db;
  }

  @override
  int get hashCode => _db.hashCode;
  
  @override
  Future<model.Document> getUserData(String uid) {
    return _db.getDocument(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.usersCollection,
      documentId: uid);
      
  }
}
