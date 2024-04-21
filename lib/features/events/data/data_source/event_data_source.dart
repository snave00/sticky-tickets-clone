import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../modules/firebase/firebase_const.dart';
import '../../../../utils/enums/event_type_enum.dart';
import '../../../../utils/helpers/network/network_handler.dart';
import '../../../../utils/logs/custom_log.dart';
import '../models/remote_models/event_model.dart';
import '../models/remote_models/ticket_model.dart';

abstract class EventDataSource {
  Future<List<EventModel>> getEvents({required EventType eventType});

  Future<EventModel?> getEvent({required String eventId});

  // will get guest list from tickets with matching eventId
  Future<List<TicketModel>> getTickets({required String eventId});

  Future<int> getGuestTotal({required String eventId});

  Future<int> getCheckedInGuestsTotal({required String eventId});
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

  @override
  Future<List<TicketModel>> getTickets({required String eventId}) async {
    // internet is required
    await NetworkHandler().checkNetworkConnectivity();

    var collectionRef = firebaseFirestore.collection(
      FirebaseConst.ticketsCollection,
    );
    var query = collectionRef.where(FirebaseConst.eventId, isEqualTo: eventId);

    final doc = await query.get();
    final data = doc.docs;

    final ticketsList =
        data.map((e) => TicketModel.fromJson(e.data())).toList();

    Log.logFireStoreCall(action: 'getTickets', result: ticketsList);

    return ticketsList;
  }

  @override
  Future<int> getGuestTotal({required String eventId}) async {
    // internet is required
    await NetworkHandler().checkNetworkConnectivity();

    var collectionRef = firebaseFirestore.collection(
      FirebaseConst.ticketsCollection,
    );
    var query =
        collectionRef.where(FirebaseConst.eventId, isEqualTo: eventId).count();

    final doc = await query.get();
    final count = doc.count;

    Log.logFireStoreCall(action: 'getGuestTotal', result: count);

    return count ?? 0;
  }

  @override
  Future<int> getCheckedInGuestsTotal({required String eventId}) async {
    // internet is required
    await NetworkHandler().checkNetworkConnectivity();

    var collectionRef = firebaseFirestore.collection(
      FirebaseConst.ticketsCollection,
    );
    var query = collectionRef
        .where(
          FirebaseConst.eventId,
          isEqualTo: eventId,
        )
        .where(
          FirebaseConst.isScanned,
          isEqualTo: true,
        )
        .count();

    final doc = await query.get();
    final count = doc.count;

    Log.logFireStoreCall(action: 'getCheckedInGuestsTotal', result: count);

    return count ?? 0;
  }
}

// made it top level function so it can be isolated
// Future<List<EventModel>> getEventsMockData(String response) async {
//   final List<dynamic> parsed = jsonDecode(response);
//   return parsed.map((json) => EventModel.fromJson(json)).toList();
// }
