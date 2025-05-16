import 'package:flutter/material.dart';

class CreatePricingModel {
  final int from;
  final int? to;
  final int? id; // optional id
  final TextEditingController priceController = TextEditingController();

  CreatePricingModel({
    required this.from,
    required this.to,
    this.id,
  });

  void dispose() {
    priceController.dispose();
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'from': from,
      'to': to,
      'price': double.tryParse(priceController.text.trim())??0.0,
    };
  }
}
class PriceRange {
  int?id;
  final int? from;
  final int? to;
  final double? price;

  PriceRange({
    required this.id,
    required this.from,
    required this.to,
    required this.price,
  });

  factory PriceRange.fromJson(Map<String, dynamic> json) {
    return PriceRange(
id: int.tryParse( json['id'].toString()),
      from:int.tryParse( json['from'].toString()),
      to: int.tryParse( json['to'].toString()),
      price: double.tryParse( json['price'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'to': to,
      'price': price,
    };
  }
}
