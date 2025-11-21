import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:mentor/feature/assessment/data/models/analysis_result/analysis_result.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;
  final Uuid _uuid;

  FirestoreService()
      : _firestore = FirebaseFirestore.instance,
        _uuid = Uuid();

  /// حفظ النتيجة في Firestore وإرجاع docId
  Future<String> saveAnalysisResult({
    required AnalysisResult result,
    required String assessmentLevel,
    String? userId,
    Map<String, String>? answers,
    List<Map<String, dynamic>>? questions,
    String? locale,
  }) async {
    try {
      final docId = _uuid.v4();
      final docRef = _firestore.collection('results').doc(docId);

      final data = {
        'id': docId,
        'assessmentLevel': assessmentLevel,
        'userId': userId,
        'locale': locale,
        'answers': answers ?? {},
        'questions': questions ?? [],
        'result': result.toJson(),
        'createdAt': FieldValue.serverTimestamp(),
      };

      await docRef.set(data);
      return docId;
    } catch (e) {
      rethrow;
    }
  }
}
