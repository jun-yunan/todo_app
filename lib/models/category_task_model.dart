// import 'package:todo_app/models/task_type_model.dart';

import 'package:flutter/material.dart';

enum CategoryTaskType { Personal, Work, Metting }

class CategoryTaskModel {
  CategoryTaskType category;
  Color color;

  CategoryTaskModel({required this.category, required this.color});

  factory CategoryTaskModel.fromJson(Map<String, dynamic> json) =>
      CategoryTaskModel(
        category: json["category"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "category": category.name,
        "color": color,
      };
}
