import 'dart:convert';
import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../../../../modules/firebase/firebase_const.dart';
import '../../../../utils/constants/asset_const.dart';
import '../../../../utils/helpers/network/network_handler.dart';
import '../../../../utils/logs/custom_log.dart';
import '../models/remote_models/event_model.dart';

abstract class EventDataSource {
  Future<List<EventModel>> getEvents();

  Future<EventModel> getEvent({required String eventId});
}

class EventDataSourceImpl implements EventDataSource {
  final FirebaseFirestore firebaseFirestore;

  EventDataSourceImpl({
    required this.firebaseFirestore,
  });

  @override
  Future<List<EventModel>> getEvents() async {
    // internet is required
    await NetworkHandler().checkNetworkConnectivity();

    final collectionRef = firebaseFirestore.collection(
      FirebaseConst.eventsCollection,
    );

    final docUser = await collectionRef.get();
    final data = docUser.docs;

    final eventsList = data.map((e) => EventModel.fromJson(e.data())).toList();

    Log.logFireStoreCall(action: 'getEvents', result: eventsList);

    return eventsList;
  }

  @override
  Future<EventModel> getEvent({required String eventId}) async {
    final String response = await rootBundle.loadString(
      AssetConst.productMockData,
    );

    // get events
    final events = await Isolate.run(
      () => getEventsMockData(response),
    );

    // filter by eventId. this mocks the query for your backend
    final event = events.firstWhere(
      (element) => element.eventId == eventId,
    );

    return event;
  }
}

// made it top level function so it can be isolated
Future<List<EventModel>> getEventsMockData(String response) async {
  final List<dynamic> parsed = jsonDecode(response);
  return parsed.map((json) => EventModel.fromJson(json)).toList();
}
