import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../modules/firebase/firebase_const.dart';
import '../../../../utils/enums/event_type_enum.dart';
import '../../../../utils/helpers/network/network_handler.dart';
import '../../../../utils/logs/custom_log.dart';
import '../models/remote_models/event_model.dart';

abstract class EventDataSource {
  Future<List<EventModel>> getEvents({required EventType eventType});

  Future<EventModel?> getEvent({required String eventId});
}

class EventDataSourceImpl implements EventDataSource {
  final FirebaseFirestore firebaseFirestore;

  EventDataSourceImpl({
    required this.firebaseFirestore,
  });

  @override
  Future<List<EventModel>> getEvents({required EventType eventType}) async {
    // internet is required
    await NetworkHandler().checkNetworkConnectivity();

    var collectionRef = firebaseFirestore.collection(
      FirebaseConst.eventsCollection,
    );
    var query = collectionRef.orderBy(FirebaseConst.date);

    if (eventType != EventType.all) {
      query = collectionRef
          .where(
            FirebaseConst.eventType,
            isEqualTo: eventType.title.toLowerCase(),
          )
          .orderBy(FirebaseConst.date);
    }

    final doc = await query.get();
    final data = doc.docs;

    final eventsList = data.map((e) => EventModel.fromJson(e.data())).toList();

    Log.logFireStoreCall(action: 'getEvents', result: eventsList);

    return eventsList;
  }

  @override
  Future<EventModel?> getEvent({required String eventId}) async {
    // internet is required
    NetworkHandler().checkNetworkConnectivity();

    final collectonRef =
        firebaseFirestore.collection(FirebaseConst.eventsCollection);
    final doc = await collectonRef.doc(eventId).get();
    final data = doc.data();

    if (data == null) return null;

    Log.logFireStoreCall(action: 'getEvent', result: data);

    return EventModel.fromJson(data);
  }
}

// made it top level function so it can be isolated
Future<List<EventModel>> getEventsMockData(String response) async {
  final List<dynamic> parsed = jsonDecode(response);
  return parsed.map((json) => EventModel.fromJson(json)).toList();
}
