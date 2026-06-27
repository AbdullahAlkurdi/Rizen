import 'package:freezed_annotation/freezed_annotation.dart';

part 'reward_item_model.freezed.dart';
part 'reward_item_model.g.dart';

@freezed
class RewardItem with _$RewardItem {
  const factory RewardItem({
    required String id,
    required String name,
    required String description,
    required int cost,
    required String icon,
    @Default(false) bool unlocked,
  }) = _RewardItem;

  factory RewardItem.fromJson(Map<String, dynamic> json) =>
      _$RewardItemFromJson(json);
}
