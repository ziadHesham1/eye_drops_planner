import 'package:equatable/equatable.dart';

import 'eye_drop_model.dart';

class EyeDropsListModel extends Equatable {
  final List<EyeDropModel> items;

  const EyeDropsListModel({required this.items});
  factory EyeDropsListModel.empty() {
    return const EyeDropsListModel(items: []);
  }

  EyeDropsListModel addEyeDrop(EyeDropModel newEyeDrop) {
    return EyeDropsListModel(
      items: List<EyeDropModel>.from(items)..add(newEyeDrop),
    );
  }

  get activeItems {
    return items.where((element) => element.isActive == false).toList();
  }

  @override
  List<Object> get props => [items];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory EyeDropsListModel.fromMap(Map<String, dynamic> map) {
    return EyeDropsListModel(
      items: List<EyeDropModel>.from(
        (map['items'] as List<dynamic>).map<EyeDropModel>(
          (x) => EyeDropModel.fromMap(x),
        ),
      ),
    );
  }
}
