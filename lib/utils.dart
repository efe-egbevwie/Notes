import 'package:cloud_firestore/cloud_firestore.dart';

class Utils{
  static DateTime toDateTime(Timestamp timestamp) {
    if (timestamp == null) return null;

    return timestamp.toDate();
    
  }

  static dynamic fromDateTime(DateTime dateTime) {
    if (dateTime == null) return null;

    return dateTime.toUtc();
  }
}