import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/remote_models/guest_model.dart';

part 'guest_entity.freezed.dart';
part 'guest_entity.g.dart';

@freezed
class GuestEntity with _$GuestEntity {
  GuestEntity._();

  factory GuestEntity({
    required final String guestId,
    required final String guestName,
  }) = _GuestEntity;

  factory GuestEntity.empty() {
    return GuestEntity(
      guestId: '',
      guestName: '',
    );
  }

  GuestModel toRemoteModel() => GuestModel(
        guestId: guestId,
        guestName: guestName,
      );

  factory GuestEntity.fromJson(Map<String, dynamic> json) =>
      _$GuestEntityFromJson(json);
}
