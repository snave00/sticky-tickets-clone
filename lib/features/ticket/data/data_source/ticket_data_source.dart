import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../modules/firebase/firebase_const.dart';
import '../../../../utils/helpers/network/network_handler.dart';
import '../../../../utils/logs/custom_log.dart';
import '../models/remote_models/ticket_model.dart';

abstract class TicketDataSource {
  // will get guest list from tickets with matching eventId
  Future<List<TicketModel>> getTickets({required String eventId});

  Future<int> getGuestTotal({required String eventId});

  Future<int> getCheckedInGuestsTotal({required String eventId});

  Future<TicketModel?> getTicket({required String ticketId});

  Future<void> checkInTicket({required String ticketId});

  Future<void> checkOutTicket({required String ticketId});
}

class TicketDataSourceImpl implements TicketDataSource {
  final FirebaseFirestore firebaseFirestore;

  TicketDataSourceImpl({
    required this.firebaseFirestore,
  });

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
  Future<TicketModel?> getTicket({required String ticketId}) async {
    // internet is required
    await NetworkHandler().checkNetworkConnectivity();

    var collectionRef = firebaseFirestore.collection(
      FirebaseConst.ticketsCollection,
    );

    final doc = await collectionRef.doc(ticketId).get();
    final data = doc.data();

    if (data == null) return null;

    Log.logFireStoreCall(action: 'getTicket', result: data);

    return TicketModel.fromJson(data);
  }

  @override
  Future<void> checkInTicket({required String ticketId}) async {
    // internet is required
    await NetworkHandler().checkNetworkConnectivity();

    var collectionRef = firebaseFirestore.collection(
      FirebaseConst.ticketsCollection,
    );

    final doc = collectionRef.doc(ticketId);
    await doc.update({
      "isScanned": true,
      "scannedAt": Timestamp.now(),
    }).then(
      (value) => Log.logFireStoreCall(
        action: 'checkInTicket',
        result: 'checkInTicket success',
      ),
    );
  }

  @override
  Future<void> checkOutTicket({required String ticketId}) async {
    // internet is required
    await NetworkHandler().checkNetworkConnectivity();

    var collectionRef = firebaseFirestore.collection(
      FirebaseConst.ticketsCollection,
    );

    final doc = collectionRef.doc(ticketId);
    await doc.update({
      "isScanned": false,
    }).then(
      (value) => Log.logFireStoreCall(
        action: 'checkOutTicket',
        result: 'checkOutTicket success',
      ),
    );
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
