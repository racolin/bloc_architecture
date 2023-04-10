import 'package:flutter/foundation.dart';
import '../../../data/models/promotion_category_model.dart';
import '../../../data/models/promotion_model.dart';
import '../message_notify.dart';

@immutable
abstract class PromotionState {}

class PromotionInitial extends PromotionState {
  PromotionInitial() {
    print(runtimeType);
  }
}

class PromotionLoading extends PromotionState {
  PromotionLoading() {
    print(runtimeType);
  }
}

class PromotionLoaded extends PromotionState {
  final List<PromotionModel> list;
  final List<PromotionCategoryModel> typeList;
  final int? selectedIndex;
  final List<int> reloadList;

  PromotionLoaded({
    required this.list,
    required this.typeList,
    required this.selectedIndex,
    this.reloadList = const [],
  }) {
    print(runtimeType);
    if (kDebugMode) {
      // print('PromotionCategoryModels(${typeList.length}): $typeList');
      // print('PromotionModels(${list.length}): $list');
      // print('selectedItem: $selectedIndex');
      // print('selectedItem: $reloadList');
    }
  }

  bool reloading(int index) {
    return reloadList.contains(index);
  }

  List<PromotionModel> getFromMe() {
    return list.where((e) => e.from == 0).toList();
  }

  List<PromotionModel> getFromPartner() {
    return list.where((e) => e.from == 1).toList();
  }

  List<PromotionModel> getByCategoryId(int id) {
    return list.where((e) => e.categoryId == id).toList();
  }

  List<PromotionModel> getOutStanding(int threshold) {
    return list.where((e) => e.rate > threshold).toList();
  }

  PromotionLoaded copyWith({
    List<PromotionModel>? list,
    List<PromotionCategoryModel>? typeList,
    int? selectedIndex,
    List<int>? reloadList,
  }) {
    return PromotionLoaded(
      list: list ?? this.list,
      typeList: typeList ?? this.typeList,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      reloadList: reloadList ?? this.reloadList,
    );
  }
}

class PromotionFailure extends PromotionState {
  MessageNotify message;

  PromotionFailure({
    required this.message,
  }) {
    print(runtimeType);
  }
}
