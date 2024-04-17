import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/services.dart';

import '../../../../utils/constants/asset_const.dart';
import '../models/remote_models/event_model.dart';

abstract class EventDataSource {
  Future<List<EventModel>> getEvents();

  Future<EventModel> getEvent({required String eventId});
}

class EventDataSourceImpl implements EventDataSource {
  @override
  Future<List<EventModel>> getEvents() async {
    final String response = await rootBundle.loadString(
      AssetConst.productMockData,
    );

    // get events
    final events = await Isolate.run(
      () => getEventsMockData(response),
    );

    return events;
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
