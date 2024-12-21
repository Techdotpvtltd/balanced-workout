// Project: 	   balanced_workout
// File:    	   web_services
// Path:    	   lib/web_services/web_services.dart
// Author:       Ali Akbar
// Date:        06-07-24 12:34:54 -- Saturday
// Description:

import 'dart:developer';
import 'dart:ui';

import 'package:balanced_workout/exceptions/exception_parsing.dart';
import 'package:balanced_workout/web_services/query_model.dart';
import 'package:balanced_workout/web_services/web_service_prototype.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'model_prototype.dart';

class WebServices implements WebServicePrototype<FirebaseFirestore> {
  @override
  FirebaseFirestore service = FirebaseFirestore.instance;

  @override
  Future<void> copyDoc<T>({required String from, required String to}) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete<T>({required String collection, required String docId}) {
    throw UnimplementedError();
  }

  @override
  Future<T?> fetch<T>({required String path, required String docId}) {
    throw UnimplementedError();
  }

  @override
  Future<void> fetchMultiple<T>(
      {required String collection,
      required Function(dynamic p1) onError,
      required Function(T p1)? onAdded,
      required Function(T p1)? onRemoved,
      required Function(T p1)? onUpdated,
      VoidCallback? onAllDataGet,
      onCompleted,
      required List<QueryModel> queries}) {
    throw UnimplementedError();
  }

  @override
  Future<List<T>> fetchMultipleWithConditions<T>(
      {required String collection,
      required List<QueryModel> queries,
      Function(DocumentSnapshot<Object?>? p1)? lastDocSnapshot}) async {
    try {
      final CollectionReference<Map<String, dynamic>> collectionReference =
          service.collection(collection);

      final Query<Map<String, dynamic>> query = _generateQuery(
          queries: queries, collectionReference: collectionReference);
      final List<Map<String, dynamic>> map = await _getWithQuery(
        query: query,
        lastDocSnapshot: (snapshot) {
          if (lastDocSnapshot != null) {
            lastDocSnapshot(snapshot);
          }
        },
      );

      return convertListToModel(map, T as ModelPrototype) as List<T>;
    } catch (e) {
      log('WebService: $T => ${e.toString()}');
      throw throwAppException(e: e);
    }
  }

  @override
  Future<T> save<T>({required String path, String? docIdFiled}) {
    throw UnimplementedError();
  }

  @override
  Future<T> update<T>(
      {required String path,
      String? docId,
      required Map<String, dynamic> data}) {
    throw UnimplementedError();
  }
}

/// Private Methods
extension _WebServicePrivate on WebServices {
  Query<Map<String, dynamic>> _generateQuery(
      {required List<QueryModel> queries,
      required CollectionReference<Map<String, dynamic>> collectionReference}) {
    Query<Map<String, dynamic>> query = collectionReference;
    for (QueryModel condition in queries) {
      switch (condition.type) {
        case QueryType.isEqual:
          query = query.where(condition.field, isEqualTo: condition.value);
          break; //Note: isNotEqual will not work if you have already add other queries
        case QueryType.isNotEqual:
          query = query.where(condition.field, isNotEqualTo: condition.value);
          break;
        case QueryType.whereIn:
          query = query.where(condition.field, whereIn: condition.value);
          break; // Note: WhereNotIn will not work if you have already add isEqual or isNotEqual
        case QueryType.whereNotIn:
          query = query.where(condition.field, whereNotIn: condition.value);
          break;
        case QueryType.arrayContains:
          query = query.where(condition.field, arrayContains: condition.value);
          break;
        case QueryType.arrayContainsAny:
          query =
              query.where(condition.field, arrayContainsAny: condition.value);
          break;
        case QueryType.isGreaterThan:
          query = query.where(condition.field, isGreaterThan: condition.value);
          break;
        case QueryType.isGreaterThanOrEqual:
          query = query.where(condition.field,
              isGreaterThanOrEqualTo: condition.value);
          break;
        case QueryType.isLessThan:
          query = query.where(condition.field, isLessThan: condition.value);
          break;
        case QueryType.isLessThanOrEqual:
          query = query.where(condition.field,
              isLessThanOrEqualTo: condition.value);
          break;
        case QueryType.orderBy:
          query = query.orderBy(condition.field, descending: condition.value);
          break;
        case QueryType.startAt: // Add OrderBy query first
          query = query.startAt(condition.value);
          break;
        case QueryType.startAfter: // Add OrderBy query first
          query = query.startAfter(condition.value);
          break;
        case QueryType.endAt: // Add OrderBy query first
          query = query.endAt(condition.value);
          break;
        case QueryType.endBefore: // Add OrderBy query first
          query = query.endBefore(condition.value);
          break;
        case QueryType.limit: // Add OrderBy query first
          query = query.limit(condition.value);
          break;
        case QueryType.limitToLast: // Add OrderBy query first
          query = query.limitToLast(condition.value);
          break;
        case QueryType.startAfterDocument:
          // Take document as value and fetch after that document. he starting position is relative to the order of the query.
          // The [documentSnapshot] must contain all of the fields provided in the orderBy of this query.
          query = query.startAfterDocument(condition.value);
          break;
        case QueryType.startAtDocument:
          //Creates and returns a new [Query] that starts at the provided document (inclusive). The starting position is relative to the order of the query. The document must contain all of the fields provided in the orderBy of this query.
          ///Calling this method will replace any existing cursor "start" query modifiers.
          query = query.startAtDocument(condition.value);
          break;
      }
    }
    // debugPrint(query.parameters.toString());
    return query;
  }

  /// Mutliple records fetching query method
  Future<List<Map<String, dynamic>>> _getWithQuery(
      {required Query<Map<String, dynamic>> query,
      required Function(DocumentSnapshot?) lastDocSnapshot}) async {
    final snapshot =
        await query.get(const GetOptions(source: Source.serverAndCache));

    lastDocSnapshot(snapshot.docs.lastOrNull);

    return snapshot.docs.map((e) => e.data()).toList();
  }

  /// Conversion
  List<T> convertListToModel<T extends ModelPrototype>(
      List<Map<String, dynamic>> data, ModelPrototype type) {
    return data.map((e) => type.fromMap(e)).toList() as List<T>;
  }
}
