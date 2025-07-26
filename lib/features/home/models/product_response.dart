import 'package:json_annotation/json_annotation.dart';
import 'package:your_store_app/features/home/models/product_model.dart';

part 'product_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductResponse {
  final List<ProductModel> products;
  final int total;
  final int skip;
  final int limit;

  const ProductResponse({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}
