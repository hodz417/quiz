// core/services/firestore_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:quiz/feature/assessment/data/models/analysis_result/analysis_result.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;
  final Uuid _uuid;

  FirestoreService()
      : _firestore = FirebaseFirestore.instance,
        _uuid = Uuid();

  Future<void> saveAnalysisResult({
    required AnalysisResult result,
    required String assessmentLevel,
  }) async {
    try {
      // Generate a UUID for the document ID
      final docId = _uuid.v4();
      
      await _firestore.collection('results').doc(docId).set({
        'id': docId, // Use the same UUID as the document ID and in the field
        'assessmentLevel': assessmentLevel,
        'result': result.toJson(),
        'timestamp': FieldValue.serverTimestamp(),
      });
      
      print('Result saved with ID: $docId');
    } catch (e) {
      print('Error saving analysis result: $e');
      rethrow;
    }
  }

  Stream<QuerySnapshot> getAllResults() {
    return _firestore
        .collection('results')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
  
  Future<DocumentSnapshot> getResult(String resultId) {
    return _firestore.collection('results').doc(resultId).get();
  }
  
  Future<void> deleteResult(String resultId) {
    return _firestore.collection('results').doc(resultId).delete();
  }
}