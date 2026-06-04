import 'package:cloud_firestore/cloud_firestore.dart';

DocumentReference orgDoc(String orgId) =>
    FirebaseFirestore.instance.collection('organizations').doc(orgId);
