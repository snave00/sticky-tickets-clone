import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/guest_entity.dart';

part 'guest_model.freezed.dart';
part 'guest_model.g.dart';

@freezed
class GuestModel with _$GuestModel {
  GuestModel._();

  factory GuestModel({
    final String? guestId,
    final String? guestName,
  }) = _GuestModel;

  factory GuestModel.fromJson(Map<String, dynamic> json) =>
      _$GuestModelFromJson(json);

  factory GuestModel.empty() {
    return GuestModel(
      guestId: '',
      guestName: '',
    );
  }

  GuestEntity toEntity() => GuestEntity(
        guestId: guestId ?? '',
        guestName: guestName ?? '',
      );
}
